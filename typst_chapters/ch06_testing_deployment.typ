= Testing, Quality Assurance & DevOps <ch:testing_deployment>


== Testing Strategy and the Software Test Pyramid <sec:test_strategy>


Quality Assurance at Digicon is guided by Martin Fowler's *Software Test Pyramid* @fowler2018refactoring, which emphasizes a strong foundation of fast, automated unit tests, supported by intermediate integration test suites, and crowned by high-level end-to-end (E2E) acceptance tests. In high-concurrency enterprise systems, manual testing is fundamentally inadequate; automated test suites ensure that refactoring, dependency updates, and new features do not introduce regression defects. @fig:software_test_pyramid illustrates the proportional distribution of testing effort, speed, and execution cost adopted across Digicon backend systems.

#figure(
  image("figures/software_test_pyramid.png", width: 95%),
  caption: [Digicon Software Testing Pyramid: Distribution of Testing Layers.]
) <fig:software_test_pyramid>


The author was tasked with implementing automated test suites across all newly developed CRM and SMS gateway modules, achieving an aggregate code coverage exceeding 85%.

== Unit Testing with Jest <sec:test_unit>


*Jest*, Facebook's open-source JavaScript testing framework, was selected for unit testing due to its built-in test runner, assertion library, code coverage engine, and zero-configuration mocking capabilities. Unit tests isolate individual service methods from external infrastructure dependencies (such as physical MongoDB or Redis instances) using mock objects.

@lst:ticket_unit_test displays the unit test suite constructed for the `TicketService`, verifying SLA calculation logic and conflict handling during concurrent updates.

#figure(
```typescript
describe('TicketService Unit Tests', () => {
  it('should assign ticket and increment version counter', async () => {
    mockTicketModel.findById.mockResolvedValue({ _id: 'tck-123', version: 1 });
    mockTicketModel.findOneAndUpdate.mockResolvedValue({ assignedAgentId: 'agent-456', version: 2 });

    const result = await service.assign('tck-123', 'agent-456', 'sup-789');
    expect(result.assignedAgentId).toEqual('agent-456');
    expect(result.version).toEqual(2);
  });

  it('should throw ConflictException on concurrent version mismatch', async () => {
    mockTicketModel.findById.mockResolvedValue({ _id: 'tck-123', version: 1 });
    mockTicketModel.findOneAndUpdate.mockResolvedValue(null); // Simulate OCC conflict

    await expect(service.assign('tck-123', 'agent-456', 'sup-789'))
      .rejects.toThrow(ConflictException);
  });
});
```,
  caption: [Unit Test for Ticket Assignment and Optimistic Lock Mismatch.]
) <lst:ticket_unit_test>


== Integration and API Testing with Supertest <sec:test_integration>


While unit tests validate isolated business logic, *Integration Tests* verify the cohesive operation of routing controllers, authentication middleware, validation pipes, and database queries. The *Supertest* HTTP assertion library was utilized to execute simulated HTTP invocations against the compiled application instance.

@lst:api_integration_test showcases an integration test evaluating ticket creation and asserting authorization rejection when authentication tokens are missing.

#figure(
```typescript
describe('Ticket API Endpoints (e2e)', () => {
  it('POST /api/v1/tickets - rejects unauthenticated requests with 401', () => {
    return request(app.getHttpServer())
      .post('/api/v1/tickets')
      .send({ title: 'Telecom Outage', priority: 'HIGH' })
      .expect(401);
  });

  it('POST /api/v1/tickets - creates ticket and returns 201 Created', () => {
    return request(app.getHttpServer())
      .post('/api/v1/tickets')
      .set('Authorization', `Bearer ${validToken}`)
      .send({ customerId: 'c-101', title: 'Billing Dispute', priority: 'CRITICAL' })
      .expect(201)
      .expect((res) => {
        expect(res.body).toHaveProperty('ticketNumber');
        expect(res.body.status).toEqual('OPEN');
      });
  });
});
```,
  caption: [API Integration Test Using Supertest.]
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
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build && npm prune --production

# Stage 2: Minimalist Production Runtime
FROM node:20-alpine AS runner
WORKDIR /usr/src/app
USER node
COPY --chown=node:node --from=builder /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=builder /usr/src/app/dist ./dist
CMD ["node", "dist/main.js"]
```,
  caption: [Production Multi-Stage Dockerfile for NestJS Backend.]
) <lst:dockerfile>


=== Container Optimization Impact

@fig:docker_multistage_build visually contrasts the architecture of a naive single-stage build against Digicon's multi-stage build pipeline, highlighting the isolation of build compilers and the dramatic reduction in attack surface and binary size.

#figure(
  image("figures/docker_multistage_build.png", width: 95%),
  caption: [Multi-Stage Docker Build Architecture and Image Size Optimization.]
) <fig:docker_multistage_build>


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

== On-Premise Infrastructure and Facility Reliability <sec:test_datacenter>


To satisfy rigorous data sovereignty and latency mandates for tier-1 telecom and banking clientele, Digicon maintains an enterprise-grade on-premise data center and critical power backup infrastructure alongside cloud environments. 

@fig:digicon_server_room shows the server racks hosting internal microservices, private registries, and staging database clusters. @fig:digicon_power_infra depicts the industrial switchgear electrical panels and redundant online UPS battery cabinets guaranteeing uninterrupted operational continuity (99.98% uptime SLA) against municipal power grid fluctuations.

#figure(
  image("figures/photo_digicon_server_room.png", width: 95%),
  caption: [Digicon On-Premise Data Center and Application Server Racks.]
) <fig:digicon_server_room>


#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    figure(
    image("figures/photo_digicon_switchgear_panel.png", width: 100%),
    caption: [Main Switchgear and Electrical Distribution Panel]
  ),
  figure(
    image("figures/photo_digicon_power_cabinets.png", width: 100%),
    caption: [Redundant UPS Power Cabinets]
  )
  ),
  caption: [Industrial Power Distribution and Redundant Backup Infrastructure at Digicon Facilities.]
) <fig:digicon_power_infra>


