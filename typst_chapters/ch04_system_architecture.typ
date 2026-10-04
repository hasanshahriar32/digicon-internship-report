= System Architecture & Requirements Analysis <ch:system_architecture>


== Requirement Gathering and Engineering Analysis <sec:arch_requirements>


Before engineering production backend services, thorough systems analysis was conducted in collaboration with Digicon's business analysts, BPO team leads, and lead software architects. The objective was to specify exact functional deliverables and non-functional performance guarantees for two core enterprise modules: the *Customer Relationship Management (CRM) Support Ticket Routing Engine* and the *Enterprise SMS Gateway Microservice*.

=== Functional Requirements (FR)

The functional specifications define the operational capabilities that the backend systems must execute:

- *User Management and Access Control (FR-01):*
- Secure authentication via email and salted/hashed passwords.
- Issuance of cryptographically signed JWT access tokens and HTTP-only refresh tokens.
- Enforcement of Role-Based Access Control (RBAC) permitting distinct administrative operations across SuperAdmin, TeamLead, SupportAgent, and Customer roles.
- *CRM Ticket Management and SLA Lifecycle (FR-02):*
- Ingestion of support tickets generated from multi-channel inputs (telephony calls, web forms, email, and social media webhooks).
- Dynamic assignment of priority tiers (`LOW`, `MEDIUM`, `HIGH`, `CRITICAL`) and automated calculation of Service Level Agreement (SLA) breach timestamps.
- Intelligent agent skill-matching and ticket assignment based on real-time agent presence tracked in Redis.
- State transition management (`OPEN` $\to$ `IN\_PROGRESS` $\to$ `ESCALATED` $\to$ `RESOLVED` $\to$ `CLOSED`) with mandatory immutable audit logging.
- *Enterprise SMS Gateway and Batch Queuing (FR-03):*
- Ingestion of single and bulk SMS dispatch requests via authenticated REST endpoints.
- Dynamic phone number normalization and telecommunication carrier identification (Grameenphone, Robi, Banglalink, Teletalk).
- Asynchronous queuing of dispatch jobs into Redis BullMQ to decouple client HTTP requests from carrier dispatch latency.
- Webhook callback receiver to ingest real-time Delivery Receipts (DLR) from telecom aggregators, with cryptographic verification of payload signatures.

=== Non-Functional Requirements (NFR)

Non-functional requirements establish the qualitative and architectural constraints under which the systems must operate:

- *High Concurrency and Scalability (NFR-01):* The backend infrastructure must support over 1,500 active concurrent contact center agents without thread starvation. The SMS gateway must handle sustained throughput exceeding 1,500 messages per second.
- *Low Latency (NFR-02):* Core API endpoints must respond with sub-50ms latency for 95% of requests under normal load, achieved through multi-tier Redis caching.
- *High Availability and Fault Tolerance (NFR-03):* Maintain 99.98% operational uptime. Outbound telecom failures must not result in message loss; the queue must execute automated exponential backoff retries.
- *Data Integrity and Consistency (NFR-04):* Ticket assignments must employ optimistic concurrency control to prevent multiple agents from simultaneously locking or mutating the same ticket document.
- *Security and Regulatory Compliance (NFR-05):* Complete adherence to OWASP Top 10 guidelines, TLS 1.3 transport encryption, and compliance with the Bangladesh Telecommunication Regulatory Commission (BTRC) messaging guidelines.

== High-Level Layered Microservices Architecture <sec:arch_layered>


To satisfy both functional flexibility and enterprise scalability, the backend system was architected following the *Multi-Tier Layered Architecture* and the *Microservices Pattern* @newman2021building. @fig:backend_layered_architecture delineates the comprehensive six-layer architectural blueprint.

#figure(
  image("figures/backend_layered_architecture.png", width: 95%),
  caption: [Digicon Backend System — Layered Microservices Architecture.]
) <fig:backend_layered_architecture>


The architecture is partitioned into cleanly decoupled tiers:
- *Client Tier:* Represents diverse omni-channel consumers, including the React-based Contact Center Agent Workspace, administrative dashboards, automated IVR telephony servers, and external third-party webhook integrations.
- *Gateway & Security Tier:* The entry point for all external traffic. *Nginx* acts as a reverse proxy, terminating SSL/TLS certificates and distributing traffic across clustered Node.js worker processes. *Helmet.js* and CORS middleware enforce transport security, while a *Token Bucket Rate Limiter* defends against denial-of-service spikes. An authorization guard verifies JWT signatures before requests enter application memory.
- *API & Routing Tier (Controllers):* Implemented using NestJS and Express routers. Controllers are strictly responsible for route binding, parsing URL parameters, executing declarative DTO payload validation via `class-validator`, and delegating tasks to underlying services.
- *Business Logic Tier (Services):* Contains domain business rules isolated from HTTP transport mechanics. The _Ticket Service_ evaluates SLA timers, determines agent availability, and manages status transitions. The _SMS Dispatcher Service_ compiles dynamic templates and produces jobs for asynchronous queue workers.
- *Data Access & Caching Tier:* Encapsulates persistence logic. The _Mongoose ODM_ interfaces with MongoDB for unstructured ticket documents. _Prisma / TypeORM_ executes relational queries against PostgreSQL for user identities and audit logs. The _Redis Layer_ serves a dual role: caching frequently read entities and powering the _BullMQ_ distributed message broker.
- *External Infrastructure Tier:* Comprises underlying bare-metal Linux servers executing containerized Docker workloads, managed PostgreSQL/MongoDB database clusters, and external telecommunication carrier SMPP/HTTP endpoints.

== Database Schema and Data Modeling <sec:arch_db_schema>


The polyglot persistence strategy adopted at Digicon strategically segregates structured transactional entities from flexible document entities. @fig:database_er_schema presents the database Entity-Relationship and document schema architecture.

#figure(
  image("figures/database_er_schema.png", width: 95%),
  caption: [Database Relational and Document Schema Architecture.]
) <fig:database_er_schema>


=== Relational PostgreSQL Entities

- *User Table:* Stores system operators and contact center staff. Employs a `UUID` primary key, unique email index, Bcrypt hashed password, foreign key reference to the `Role` entity, and account activation flags.
- *Role & Permission Table:* Defines granular authorization roles. The `permissions` attribute is modeled as a PostgreSQL `JSONB` field, permitting high-speed indexed lookups of specific capability flags (e.g., `\{"tickets": ["read", "write", "escalate"]\}`).
- *SmsDispatch Table:* Records every outbound SMS transmission with unique tracking UUIDs, recipient phone number, alphanumeric sender ID, message body, current status (`PENDING`, `SENT`, `FAILED`), and scheduling timestamps.
- *DeliveryReceipt Table:* Persists telecommunication carrier delivery reports (DLR). Relates to `SmsDispatch` via a foreign key, recording the carrier's internal message ID, final delivery state (`DELIVRD`, `UNDELIV`, `EXPIRED`), delivery timestamp, and error diagnostics.

=== Document MongoDB Entities

- *Ticket Collection:* Represents customer support cases. Modeled as a MongoDB document containing unique ticket numbers, customer identifiers, assigned agent IDs, categorical status enums, priority rankings, calculated SLA breach timestamps, and a dynamic `metadata` subdocument accommodating custom client-specific fields. Compound indexes are constructed on `\{status: 1, priority: -1, sla\_breach\_at: 1\}` to ensure sub-millisecond query execution during queue sorting.
- *TicketAuditLog Collection:* An immutable, append-only collection that captures every state alteration, recording the acting user ID, old status, new status, explanatory comment, and exact ISO timestamp, satisfying strict corporate compliance auditing.

== CRM Ticket Lifecycle and Event Routing Flow <sec:arch_crm_flow>


The lifecycle of a customer support ticket within Digicon's contact center involves intricate orchestration across HTTP routes, database transactions, caching layers, and WebSocket event emitters. @fig:crm_ticket_flow visualizes the complete end-to-end lifecycle progression.

#figure(
  image("figures/crm_ticket_flow.png", width: 95%),
  caption: [CRM Customer Support Ticket Lifecycle and Event Routing Flow.]
) <fig:crm_ticket_flow>


The sequential flow operates through eight clearly defined stages:
- *Inbound Inquiry Ingestion:* Inbound customer communications arriving from call center telephony, web forms, or external client webhooks trigger a `POST /api/v1/tickets` invocation.
- *Payload Validation:* Express Validator and DTO pipes verify that mandatory fields (customer ID, issue category, description) conform to data schemas and that the client's JWT possesses `TICKET\_CREATE` privileges.
- *Document Creation:* The ticket is written to MongoDB with initial status `OPEN`.
- *SLA Calculation & Skill Matching:* The service calculates the maximum allowable resolution window based on customer contract tier (e.g., Critical = 2 hours, Low = 24 hours). Concurrently, an in-memory Redis query identifies currently active, non-overloaded agents matching the required skill domain.
- *Atomic Agent Assignment:* The ticket document is updated with the assigned agent ID and status transitioned to `IN\_PROGRESS` using optimistic locking to prevent double-assignment.
- *Real-Time WebSocket Push:* A Redis Pub/Sub event is emitted, causing the WebSocket gateway to push the new ticket notification directly to the selected agent's browser workstation within 50 milliseconds.
- *Escalation Daemon Monitoring:* A scheduled background cron evaluates tickets approaching SLA breach, automatically raising priority and alerting team leads if resolution thresholds are crossed.
- *Resolution and Feedback:* Upon problem resolution, the agent updates the status to `RESOLVED`. An automated SMS notification containing a CSAT rating link is enqueued to the customer.

== Enterprise SMS Gateway and Asynchronous Queue Architecture <sec:arch_sms_pipeline>


The SMS Gateway microservice was designed to address high-volume message delivery under strict telecom rate constraints. @fig:sms_gateway_pipeline illustrates the asynchronous pipeline architecture.

#figure(
  image("figures/sms_gateway_pipeline.png", width: 95%),
  caption: [Enterprise SMS Gateway and Asynchronous Dispatch Pipeline.]
) <fig:sms_gateway_pipeline>


=== Pipeline Mechanics

- *Ingestion & Rate Limiting:* Clients initiate single or bulk SMS dispatch requests via HTTPS. The request passes through an in-memory *Token Bucket Rate Limiter* implemented via Redis atomic operations, guaranteeing that inbound client traffic does not overwhelm internal capacity.
- *Queue Decoupling (Producer):* The API service acts as a producer, persisting initial message metadata into PostgreSQL and enqueuing jobs into the *BullMQ Redis Queue*. The HTTP connection immediately terminates with an HTTP `202 Accepted` response and tracking UUID, freeing the client from carrier latency.
- *Parallel Worker Pool (Consumer):* Clustered BullMQ worker processes continuously pull pending jobs from Redis. Workers format the payload to carrier-specific SMPP or HTTP protocols, execute telco routing, and dispatch messages across direct interconnects with Bangladesh operators (Grameenphone, Robi, Banglalink, Teletalk).
- *Retry with Exponential Backoff:* If a telecom carrier endpoint returns a transient network timeout or HTTP 5xx error, BullMQ automatically schedules retries using an exponential backoff formula:
$ T_"wait" = T_"base" times 2^"attempt" + "jitter" $

    preventing thundering herd problems against carrier gateways.
- *Webhook Ingestion & Cryptographic Verification:* When carriers deliver messages to handsets, they dispatch an asynchronous Delivery Receipt (DLR) webhook to Digicon. An HMAC-SHA256 signature guard verifies that the webhook genuinely originated from the carrier, after which the delivery state is updated in PostgreSQL.

== JWT Authentication and Role-Based Access Control Flow <sec:arch_jwt_flow>


To satisfy non-functional security requirements, authentication and authorization are unified into a stateless, cryptographically enforced pipeline. @fig:jwt_auth_workflow illustrates the sequence of interactions governing access.

#figure(
  image("figures/jwt_auth_workflow.png", width: 95%),
  caption: [JWT Authentication and Role-Based Access Control (RBAC) Flow.]
) <fig:jwt_auth_workflow>


The authentication lifecycle proceeds as follows:
- *Credential Verification:* The client submits an email and password to `POST /api/v1/auth/login`. The Auth Service retrieves the user record from PostgreSQL and verifies the Bcrypt hash.
- *Token Minting:* Upon successful authentication, the server mints a short-lived Access Token (JWT) containing the user's UUID, assigned role, and permissions, along with a cryptographically random Refresh Token persisted in Redis.
- *Protected Endpoint Invocation:* Subsequent requests to protected routes (e.g., `GET /api/v1/tickets`) supply the JWT within the standard HTTP `Authorization: Bearer <token>` header.
- *Stateless Signature Verification:* The API Gateway Guard verifies the token's cryptographic signature using a shared secret key without querying the database, eliminating authentication bottlenecks.
- *RBAC Permission Evaluation:* An authorization guard inspects the decoded role claims against the endpoint's permission decorator. If the role possesses the required permission (e.g., `TICKET\_READ`), the request proceeds to controller execution; otherwise, an immediate HTTP `403 Forbidden` error is returned.

== DevOps and Continuous Deployment Pipeline <sec:arch_devops>


To maintain engineering consistency across development, staging, and production environments, Digicon utilizes a structured DevOps pipeline. @fig:ci_cd_docker_pipeline depicts the continuous integration and deployment workflow.

#figure(
  image("figures/ci_cd_docker_pipeline.png", width: 95%),
  caption: [Continuous Integration, Docker Containerization and Deployment Pipeline.]
) <fig:ci_cd_docker_pipeline>


The pipeline enforces rigorous quality gates:
- *Stage 1: Git Version Control:* Developers push feature branches and submit Pull Requests (PR) against the primary development branch.
- *Stage 2: Static Analysis:* Automated Git hooks execute ESLint and Prettier formatting checks, followed by TypeScript strict compilation checks.
- *Stage 3: Automated Testing:* The CI pipeline executes comprehensive Jest unit tests and Supertest API specifications. Pull Requests cannot be merged if any test fails or if coverage drops below the 80% threshold.
- *Stage 4: Multi-Stage Docker Build:* A minimal, production-optimized Alpine Linux Docker image is constructed, discarding compilation tools and `devDependencies`.
- *Stage 5: Container Registry Storage:* The verified image is tagged with the semantic Git release version and pushed to Digicon's private Docker registry.
- *Stage 6: Zero-Downtime Deployment:* Production host servers pull the updated container image and execute a rolling container restart behind Nginx load balancers without dropping active user connections.
