= Testing, Quality Assurance & DevOps <ch:testing_deployment>


== Testing Strategy and the Software Test Pyramid <sec:test_strategy>


Quality Assurance at Digicon is guided by Martin Fowler's *Software Test Pyramid* @fowler2018refactoring, which emphasizes a strong foundation of fast, automated unit tests, supported by intermediate integration test suites, and crowned by high-level end-to-end (E2E) acceptance tests. In high-concurrency enterprise systems, manual testing is fundamentally inadequate; automated test suites ensure that refactoring, dependency updates, and new features do not introduce regression defects.

The author was tasked with implementing automated test suites across all newly developed CRM and SMS gateway modules, achieving an aggregate code coverage exceeding 85%.

== Unit Testing with Jest <sec:test_unit>


*Jest*, Facebook's open-source JavaScript testing framework, was selected for unit testing due to its built-in test runner, assertion library, code coverage engine, and zero-configuration mocking capabilities. Unit tests isolate individual service methods from external infrastructure dependencies (such as physical MongoDB or Redis instances) using mock objects.

@lst:ticket_unit_test displays the unit test suite constructed for the `TicketService`, verifying SLA calculation logic and conflict handling during concurrent updates.

#figure(
```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { getModelToken } from '@nestjs/mongoose';
import { TicketService } from './ticket.service';
import { CacheService } from '../cache/cache.service';
import { ConflictException } from '@nestjs/common';

describe('TicketService Unit Tests', () => {
  let service: TicketService;
  let mockTicketModel: any;
  let mockCacheService: any;

  beforeEach(async () => {
    // Construct mock database functions
    mockTicketModel = {
      findById: jest.fn(),
      findOneAndUpdate: jest.fn(),
    };

    mockCacheService = {
      invalidatePattern: jest.fn().mockResolvedValue(undefined),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        TicketService,
        { provide: getModelToken('Ticket'), useValue: mockTicketModel },
        { provide: CacheService, useValue: mockCacheService },
      ],
    }).compile();

    service = module.get<TicketService>(TicketService);
  });

  it('should successfully assign ticket and increment version counter', async () => {
    const existingTicket = { _id: 'tck-123', version: 1 };
    const updatedTicket = { _id: 'tck-123', assignedAgentId: 'agent-456', status: 'IN_PROGRESS', version: 2 };

    mockTicketModel.findById.mockResolvedValue(existingTicket);
    mockTicketModel.findOneAndUpdate.mockResolvedValue(updatedTicket);

    const result = await service.assign('tck-123', 'agent-456', 'sup-789');

    expect(result.assignedAgentId).toEqual('agent-456');
    expect(result.version).toEqual(2);
    expect(mockTicketModel.findOneAndUpdate).toHaveBeenCalled();
  });

  it('should throw ConflictException when concurrent version mismatch occurs', async () => {
    mockTicketModel.findById.mockResolvedValue({ _id: 'tck-123', version: 1 });
    // Simulate optimistic lock failure returning null
    mockTicketModel.findOneAndUpdate.mockResolvedValue(null);

    await expect(service.assign('tck-123', 'agent-456', 'sup-789')).rejects.toThrow(
      ConflictException
    );
  });
});
```,
  caption: [Unit Test Suite for Ticket Service Using Jest.]
) <lst:ticket_unit_test>


== Integration and API Testing with Supertest <sec:test_integration>


While unit tests validate isolated business logic, *Integration Tests* verify the cohesive operation of routing controllers, authentication middleware, validation pipes, and database queries. The *Supertest* HTTP assertion library was utilized to execute simulated HTTP invocations against the compiled application instance.

@lst:api_integration_test showcases an integration test evaluating ticket creation and asserting authorization rejection when authentication tokens are missing.

#figure(
```typescript
import * as request from 'supertest';
import { Test } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { AppModule } from '../src/app.module';

describe('Ticket API Endpoints (e2e)', () => {
  let app: INestApplication;
  let validAgentToken: string;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleRef.createNestApplication();
    app.useGlobalPipes(new ValidationPipe());
    await app.init();

    // Authenticate and acquire valid JWT token
    const loginRes = await request(app.getHttpServer())
      .post('/api/v1/auth/login')
      .send({ email: 'agent@digicon.com.bd', password: 'ValidPassword123!' });
    validAgentToken = loginRes.body.accessToken;
  });

  it('POST /api/v1/tickets - should reject unauthenticated requests with 401', () => {
    return request(app.getHttpServer())
      .post('/api/v1/tickets')
      .send({ title: 'Telecom Network Failure', priority: 'HIGH' })
      .expect(401);
  });

  it('POST /api/v1/tickets - should create ticket and return 201 Created', () => {
    return request(app.getHttpServer())
      .post('/api/v1/tickets')
      .set('Authorization', `Bearer ${validAgentToken}`)
      .send({
        customerId: '123e4567-e89b-12d3-a456-426614174000',
        title: 'Billing Dispute Resolution',
        description: 'Customer charged twice for SMS bundle subscription.',
        priority: 'CRITICAL',
      })
      .expect(201)
      .expect((res) => {
        expect(res.body).toHaveProperty('ticketNumber');
        expect(res.body.status).toEqual('OPEN');
        expect(res.body.slaBreachAt).toBeDefined();
      });
  });

  afterAll(async () => {
    await app.close();
  });
});
```,
  caption: [API Integration Test Suite Using Supertest.]
) <lst:api_integration_test>


== Empirical Performance Profiling and Load Testing <sec:test_benchmarks>


To substantiate the performance benefits of the multi-tier Redis caching architecture (implemented in @sec:impl_caching), rigorous empirical load testing was conducted using *Autocannon* and *k6*. 

=== Benchmarking Methodology

The benchmark simulated real-world contact center peak traffic against the `GET /api/v1/tickets/summary` reporting endpoint. Two distinct system configurations were benchmarked under identical hardware conditions (4 vCPU, 8 GB RAM, Linux Ubuntu 22.04 LTS):
- *Direct Database Query (Uncached):* Every incoming request triggered a full aggregation query across 500,000 documents in MongoDB with sorting and filtering.
- *Redis Cached Layer (Optimized):* The endpoint resolved queries via the in-memory Redis cache with a 120-second TTL, populating cache misses asynchronously.

Both configurations were subjected to five escalation tiers of concurrent virtual clients (50, 100, 250, 500, and 1,000 concurrent connections) sustained over 60-second test windows.

=== Empirical Benchmark Results

@fig:benchmark_latency provides a comparative visualization of response latency and system throughput across both configurations. @tab:benchmark_metrics details the precise quantitative findings.

#figure(
  image("figures/benchmark_latency_comparison.png", width: 95%),
  caption: [Digicon CRM API Performance Benchmarks under Increasing Concurrency (Autocannon / k6).]
) <fig:benchmark_latency>


#figure(
  table(
    columns: (1.5fr, 1.2fr, 1.2fr, 1.2fr, 1.2fr),
    stroke: 0.5pt + luma(180),
    table.header(
      [*Concurrency*], [*Direct DB Latency*], [*Redis Latency*], [*Direct DB Tps*], [*Redis Tps*]
    ),
    [50 Virtual Users], [45.2 ms], [8.1 ms], [480 req/s], [950 req/s],
    [100 Virtual Users], [92.4 ms], [12.3 ms], [850 req/s], [2,100 req/s],
    [250 Virtual Users], [240.1 ms], [22.5 ms], [1,100 req/s], [4,800 req/s],
    [500 Virtual Users], [580.8 ms], [38.2 ms], [1,220 req/s], [7,900 req/s],
    [1000 Virtual Users], [1,250.6 ms], [65.4 ms], [1,150 req/s], [9,200 req/s]
  ),
  caption: [Empirical Benchmark Metrics: Direct DB Query vs. Redis Cached Layer.]
) <tab:benchmark_metrics>


=== Analytical Findings

As evidenced by the empirical data:
- At 1,000 concurrent connections, the uncached database architecture experienced severe CPU saturation and I/O wait degradation, resulting in average response latencies ballooning to *1,250.6 ms* and throughput plateauing at 1,150 req/sec.
- Conversely, the Redis-cached architecture maintained sub-70ms average latency (*65.4 ms*) at 1,000 concurrent users—a *94.7% reduction in latency*.
- Sustained system throughput scaled from 1,150 req/sec to *9,200 req/sec*, representing an *8-fold increase in processing capacity*.

== Docker Containerization and Multi-Stage Builds <sec:test_docker>


To eliminate the classic _“it works on my machine”_ dilemma and ensure immutable runtime parity between development workstations and production servers, all backend services were containerized using *Docker* @merkel2014docker.

=== Multi-Stage Dockerfile Engineering

A naive, single-stage Dockerfile copies the entire source repository and installs full Node.js build dependencies, resulting in bloated image sizes exceeding 800 MB. To optimize security and distribution speed, the author engineered *multi-stage Docker builds*. @lst:dockerfile shows the production Dockerfile.

#figure(
```bash
# Stage 1: Build & Compilation Stage
FROM node:20-alpine AS builder
WORKDIR /usr/src/app

# Install dependencies based on lockfile for deterministic builds
COPY package*.json ./
RUN npm ci

# Copy source code and compile TypeScript to JavaScript
COPY . .
RUN npm run build

# Prune development dependencies to keep production footprint minimal
RUN npm prune --production

# Stage 2: Minimalist Production Runtime
FROM node:20-alpine AS runner
WORKDIR /usr/src/app

ENV NODE_ENV=production
ENV PORT=3000

# Security Hardening: Execute under non-root unprivileged user
USER node

# Copy only production dependencies and compiled artifacts from Stage 1
COPY --chown=node:node --from=builder /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=builder /usr/src/app/dist ./dist
COPY --chown=node:node package*.json ./

EXPOSE 3000
CMD ["node", "dist/main.js"]
```,
  caption: [Production Multi-Stage Dockerfile for NestJS Backend.]
) <lst:dockerfile>


=== Container Optimization Impact

The multi-stage build strategy yielded decisive operational advantages:
- *Image Footprint Reduction:* The final container image size dropped from *840 MB* (naive single-stage image containing TypeScript compilers and development packages) to a lightweight *142 MB* (an *83% reduction*).
- *Attack Surface Minimization:* Build tools (such as `npm`, `tsc`, and git binaries) are absent from the production image, eliminating exploit vectors for container escape.
- *Non-Root Security:* The application process executes under the unprivileged `node` user rather than `root`, restricting access to the host operating system.

== Continuous Integration and Deployment (CI/CD) Workflow <sec:test_cicd>


Continuous Integration was configured via automated pipelines (GitLab CI / GitHub Actions). On every Pull Request:
- Linters (ESLint, Prettier) verify code formatting consistency.
- TypeScript compiler checks strict type compliance.
- Automated Jest unit and Supertest integration suites are executed against ephemeral MongoDB and PostgreSQL test containers.
- If all quality gates pass, Docker images are built and pushed to Digicon's private Docker registry, triggering a zero-downtime rolling update across staging servers.
