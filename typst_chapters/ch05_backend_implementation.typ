= Design & Implementation of Backend Services <ch:backend_implementation>


== Project Directory Structure and Modular Organization <sec:impl_structure>


To ensure long-term maintainability, testability, and adherence to clean code standards, the backend systems implemented at Digicon follow a strictly modular, layered directory hierarchy. Both the CRM Support Ticket platform and the Enterprise SMS Gateway microservice adhere to standardized architectural conventions. @lst:project_structure illustrates the standardized workspace layout.

#figure(
```bash
src/
|-- common/                  # Cross-cutting guards, interceptors, decorators, & filters
|-- config/                  # Environment variable schemas & database connection configs
|-- modules/                 # Domain-driven feature modules
|   |-- auth/                # JWT strategy, password hashing, & RBAC guards
|   |-- tickets/             # Ticket controller, SLA service, & MongoDB schemas
|   |-- sms/                 # SMS dispatch controller, BullMQ producer & worker
|   |-- cache/               # Redis in-memory cache-aside manager
|-- main.ts                  # Application bootstrap, Swagger setup, & global pipes
```,
  caption: [Modular Backend Project Directory Layout.]
) <lst:project_structure>


== Implementation of Authentication, JWT, and RBAC Middleware <sec:impl_auth>


Stateless security is enforced across all API endpoints using JSON Web Tokens (JWT) coupled with declarative Role-Based Access Control (RBAC) guards.

=== JWT Authentication Strategy

When an incoming HTTP request reaches a protected route, the `JwtAuthGuard` intercepts the execution context and delegates token verification to the `JwtStrategy`. @lst:jwt_strategy presents the implementation of the passport-based JWT strategy.

#figure(
```typescript
@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly config: ConfigService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.get<string>('JWT_SECRET_KEY'),
    });
  }

  async validate(payload: JwtPayload) {
    if (!payload?.sub) throw new UnauthorizedException('Malformed or expired token');
    return { userId: payload.sub, email: payload.email, role: payload.role };
  }
}
```,
  caption: [Stateless JWT Verification Strategy.]
) <lst:jwt_strategy>


=== Declarative RBAC Authorization Guard

Endpoint access permissions are declared using custom TypeScript metadata decorators (e.g., `@Roles('SUPER\_ADMIN', 'TEAM\_LEAD')`). @lst:roles_guard demonstrates the execution guard that enforces this policy at runtime.

#figure(
```typescript
@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<string[]>('roles', [
      context.getHandler(), context.getClass(),
    ]);
    if (!requiredRoles?.length) return true;

    const { user } = context.switchToHttp().getRequest();
    if (!user || !requiredRoles.includes(user.role)) {
      throw new ForbiddenException(`Role '${user?.role}' unauthorized for resource`);
    }
    return true;
  }
}
```,
  caption: [Role-Based Access Control (RBAC) Guard.]
) <lst:roles_guard>


== Implementation of the CRM Support Ticket Routing Engine <sec:impl_crm>


The CRM Support Ticket platform handles customer issues arriving across Digicon's BPO contact center channels. The implementation leverages MongoDB via Mongoose to accommodate semi-structured customer case parameters.

=== Ticket Controller Implementation

The controller defines RESTful endpoints, enforces authorization guards, and validates client input through Data Transfer Objects (DTOs) decorated with `class-validator` annotations. @lst:ticket_controller details the controller methods for ticket ingestion and atomic agent assignment.

#figure(
```typescript
@Controller('api/v1/tickets')
@UseGuards(JwtAuthGuard, RolesGuard)
export class TicketController {
  constructor(private readonly ticketService: TicketService) {}

  @Post()
  @Roles('SUPER_ADMIN', 'TEAM_LEAD', 'SUPPORT_AGENT')
  create(@Body() dto: CreateTicketDto, @Req() req: RequestWithUser) {
    return this.ticketService.create(dto, req.user.userId);
  }

  @Patch(':id/assign')
  @Roles('SUPER_ADMIN', 'TEAM_LEAD')
  assign(@Param('id') id: string, @Body('agentId') agentId: string, @Req() req: RequestWithUser) {
    return this.ticketService.assign(id, agentId, req.user.userId);
  }
}
```,
  caption: [RESTful Ticket Management Controller.]
) <lst:ticket_controller>


=== Ticket Service Business Logic and Optimistic Concurrency Control

The service layer implements business rules, automated SLA calculation, and optimistic concurrency control. @lst:ticket_service illustrates the core atomic assignment logic using version incrementing.

#figure(
```typescript
@Injectable()
export class TicketService {
  constructor(@InjectModel(Ticket.name) private ticketModel: Model<TicketDocument>) {}

  async assign(ticketId: string, agentId: string, supervisorId: string): Promise<Ticket> {
    const existing = await this.ticketModel.findById(ticketId);
    if (!existing) throw new NotFoundException('Ticket not found');

    // Optimistic Concurrency Control: match ID and current version
    const updated = await this.ticketModel.findOneAndUpdate(
      { _id: ticketId, version: existing.version },
      {
        $set: { assignedAgentId: agentId, status: 'IN_PROGRESS', updatedAt: new Date() },
        $inc: { version: 1 },
        $push: { auditLogs: { action: 'ASSIGN', by: supervisorId, at: new Date() } },
      },
      { new: true }
    );
    if (!updated) throw new ConflictException('Concurrent update conflict on ticket');
    return updated;
  }
}
```,
  caption: [Ticket Service with Optimistic Concurrency Control.]
) <lst:ticket_service>


The sequence of interactions during ticket assignment and conflict detection under Optimistic Concurrency Control (OCC) is illustrated in @fig:optimistic_locking_sequence. When multiple supervisors attempt to modify the same ticket concurrently, only the first transaction matching the expected document version succeeds, while conflicting updates are rejected with an HTTP 409 Conflict.

#figure(
  image("figures/optimistic_locking_sequence.png", width: 95%),
  caption: [Optimistic Concurrency Control Sequence in Ticket Assignment.]
) <fig:optimistic_locking_sequence>


== Implementation of the Enterprise SMS Gateway Microservice <sec:impl_sms>


The SMS Gateway microservice is engineered to decouple high-volume outbound messaging from downstream carrier response latencies. It integrates the BullMQ message queue and a custom Token Bucket rate limiter.

=== Token Bucket Rate Limiting Algorithm

To adhere strictly to Bangladesh Telecommunication Regulatory Commission (BTRC) compliance and prevent carrier API flooding (HTTP 429), a Token Bucket rate limiter was implemented in Redis. The algorithm continuously replenishes tokens into a bucket at a fixed rate $R$ up to capacity $C$. Inbound dispatches consume tokens atomically via Lua scripts. @lst:token_bucket shows the implementation.

#figure(
```typescript
async acquireToken(key: string, capacity: number, fillRatePerSec: number): Promise<boolean> {
  const luaScript = `
    local key, cap, rate, now = KEYS[1], tonumber(ARGV[1]), tonumber(ARGV[2]), tonumber(ARGV[3])
    local data = redis.call('HMGET', key, 'tokens', 'last_updated')
    local tokens = tonumber(data[1]) or cap
    local last = tonumber(data[2]) or now
    tokens = math.min(cap, tokens + math.max(0, (now - last) / 1000) * rate)
    if tokens >= 1 then
      redis.call('HMSET', key, 'tokens', tokens - 1, 'last_updated', now)
      redis.call('EXPIRE', key, 60); return 1
    end
    redis.call('HMSET', key, 'tokens', tokens, 'last_updated', now); return 0
  `;
  const res = await this.redis.eval(luaScript, 1, `limiter:${key}`, capacity, fillRatePerSec, Date.now());
  return res === 1;
}
```,
  caption: [Redis Lua Token Bucket Rate Limiter.]
) <lst:token_bucket>


=== BullMQ Asynchronous Queue Processing and Worker Lifecycle

Outbound message requests are rapidly enqueued by the Producer service, freeing the HTTP request thread. The end-to-end lifecycle of asynchronous SMS jobs within BullMQ, including active concurrency pools, exponential backoff retries, and dead letter queue routing, is illustrated in @fig:bullmq_job_lifecycle.

#figure(
  image("figures/bullmq_job_lifecycle.png", width: 95%),
  caption: [BullMQ Asynchronous Job Lifecycle and Dead Letter Queue (DLQ).]
) <fig:bullmq_job_lifecycle>


@lst:sms_queue presents the BullMQ worker configuration, carrier HTTP dispatch, and provider rate quota enforcement.

#figure(
```typescript
@Injectable()
export class SmsQueueWorker {
  constructor(private readonly config: ConfigService) {
    new Worker('sms-dispatch-queue', async (job: Job) => {
      const { recipient, message, trackingId } = job.data;
      return await axios.post(this.config.get('TELCO_GATEWAY_URL'), {
        msisdn: recipient, text: message, transaction_id: trackingId,
      }, { timeout: 4000 });
    }, {
      concurrency: 20, // 20 parallel worker threads per process
      connection: { host: config.get('REDIS_HOST'), port: config.get('REDIS_PORT') },
      limiter: { max: 100, duration: 1000 }, // Enforce 100 msg/sec carrier quota
    });
  }
}
```,
  caption: [BullMQ Asynchronous SMS Queue Worker.]
) <lst:sms_queue>


=== Cryptographic Webhook Signature Verification

When telecommunication operators send asynchronous Delivery Receipts (DLR), an HMAC-SHA256 signature middleware validates the payload authenticity to prevent spoofing, as demonstrated in @lst:webhook_verifier.

#figure(
```typescript
@Injectable()
export class WebhookSignatureMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    const signature = req.headers['x-telco-signature'] as string;
    if (!signature) throw new UnauthorizedException('Missing carrier signature header');

    const expected = crypto.createHmac('sha256', process.env.TELCO_WEBHOOK_SECRET)
                           .update(JSON.stringify(req.body)).digest('hex');
    const isValid = crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(expected));
    if (!isValid) throw new UnauthorizedException('Invalid cryptographic signature');
    next();
  }
}
```,
  caption: [HMAC-SHA256 Webhook Verification Middleware.]
) <lst:webhook_verifier>


== Distributed Caching Implementation with Redis <sec:impl_caching>


To satisfy NFR-02 (sub-50ms latency), a generalized Cache-Aside service was implemented. The service manages serialized JSON data, TTL expiration, and pattern-based cache invalidation. @lst:cache_service presents the implementation.

#figure(
```typescript
@Injectable()
export class CacheService {
  constructor(private readonly redis: Redis) {}

  async getOrSet<T>(key: string, ttlSeconds: number, fetcher: () => Promise<T>): Promise<T> {
    const cached = await this.redis.get(key).catch(() => null);
    if (cached) return JSON.parse(cached) as T;

    const freshData = await fetcher();
    if (freshData !== null && freshData !== undefined) {
      await this.redis.set(key, JSON.stringify(freshData), 'EX', ttlSeconds).catch(() => null);
    }
    return freshData;
  }

  async invalidatePattern(pattern: string): Promise<void> {
    const keys = await this.redis.keys(pattern);
    if (keys.length > 0) await this.redis.del(...keys);
  }
}
```,
  caption: [Redis Cache-Aside Service Implementation.]
) <lst:cache_service>


== Global Error Handling and Centralized Logging <sec:impl_error_logging>


In enterprise environments, unhandled exceptions can leak internal stack traces and compromise security. A global HTTP exception filter was implemented to catch all anomalies and format them into standardized JSON error structures in conformance with RFC 7807 (Problem Details for HTTP APIs). @lst:exception_filter shows the global exception filter.

#figure(
```typescript
@Catch()
export class GlobalExceptionFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const res = ctx.getResponse<Response>();
    const req = ctx.getRequest<Request>();

    const status = exception instanceof HttpException ? exception.getStatus() : 500;
    const errorResponse = {
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: req.url,
      error: exception instanceof HttpException ? exception.getResponse() : 'Internal Server Error',
    };
    res.status(status).json(errorResponse);
  }
}
```,
  caption: [Global Centralized HTTP Exception Filter.]
) <lst:exception_filter>

