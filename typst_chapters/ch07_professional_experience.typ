= Professional Experience, Challenges & Key Learnings <ch:professional_experience>


== Workplace Environment and Industrial Culture <sec:exp_workplace>


The industrial attachment at *Digicon Technologies PLC* exposed the author to a fast-paced, high-accountability enterprise software engineering environment. Unlike academic group projects where deadlines are flexible and architectures are largely hypothetical, Digicon operates production platforms serving tier-1 telecommunications operators and corporate enterprises under strict contractual Service Level Agreements (SLAs).

The work environment is characterized by:
- *Strict Information Security Governance:* Operating under ISO 27001 standards, developer workstations operate within isolated network segments. Access to production database clusters is strictly partitioned via VPNs and multi-factor authentication (MFA).
- *Meritocratic and Collaborative Culture:* Senior software architects, team leads, and interns engage in open technical debate. Architectural design proposals are evaluated based on empirical benchmarks, code maintainability, and scalability rather than corporate hierarchy.
- *Continuous Learning and Mentorship:* Bi-weekly internal engineering seminars (known as _Tech Brown Bags_) provided forums where backend engineers presented emerging tools, such as Kafka event streaming, Kubernetes orchestration, and Rust-based WebAssembly integrations.

@fig:digicon_workstation showcases the author's primary engineering workstation at Digicon Technologies, configured with dual high-resolution displays, Linux-based development environments, and real-time monitoring terminals.

#figure(
  image("figures/photo_digicon_workstation.png", width: 95%),
  caption: [Engineering Workstation and Backend Development Setup during the Internship.]
) <fig:digicon_workstation>



== Agile/Scrum Workflow and Sprint Ceremonies <sec:exp_agile>


Digicon's software engineering division strictly adheres to the *Agile/Scrum* framework @schwaber2020scrum, organizing development around disciplined *two-week sprint cycles*. Active participation in these ceremonies provided the author with foundational industry competencies:

- *Sprint Planning:* At the commencement of each sprint, the engineering team, product owner, and business analysts evaluate the product backlog. User stories are decomposed into technical tasks, estimated using Fibonacci story points (1, 2, 3, 5, 8), and committed to the sprint scope.
- *Daily Scrum Stand-ups:* Every morning at 10:00 AM, the backend team conducts a focused 15-minute stand-up meeting where each engineer answers three canonical questions:
- What did I accomplish yesterday?
- What will I work on today?
- Are there any technical blockers impeding my progress?
- *Sprint Review & Demo:* At the conclusion of the two-week iteration, working software deliverables are demonstrated to enterprise stakeholders and BPO operations leads in the staging environment.
- *Sprint Retrospective:* The engineering team analyzes operational successes, identified bottlenecks, and actionable process improvements for the subsequent sprint.
- *Disciplined Git Collaboration:* Strict branch-protection rules govern the central Git repository. Feature branches follow semantic naming conventions (e.g., `feature/tck-104-sla-timer`, `bugfix/sms-dlr-signature`). Merging into the development branch mandates passing all automated CI unit tests and receiving mandatory approval from at least two senior code reviewers.

== Real-World Technical Challenges and Engineering Solutions <sec:exp_challenges>


Encountering unexpected runtime anomalies and debugging complex distributed systems failures constituted the most pedagogically valuable phase of the internship. Below, four critical real-world technical challenges encountered by the author and their corresponding engineering resolutions are detailed.

=== Challenge 1: Database Connection Pool Exhaustion under Concurrent Load

*Symptom:* During initial stress testing of the user authentication and ticket lookup service under simulated load (500+ concurrent requests), the application server abruptly halted, throwing fatal `ConnectionPoolTimeoutException: Timeout waiting for connection from pool`.

*Root-Cause Analysis:* Analysis of server logs revealed that database connections to PostgreSQL were being opened per request without strict pooling limits. Slow relational queries under concurrent loads held connections open for prolonged intervals, quickly depleting PostgreSQL's default limit of 100 connections. Subsequent incoming requests blocked waiting for an available connection until timing out.

*Engineering Resolution:*
- Reconfigured the PostgreSQL connection pool using Prisma/PgBouncer with explicit pooling thresholds: `min: 10, max: 50, idleTimeoutMillis: 30000, connectionTimeoutMillis: 2000`.
- Implemented the Redis *Cache-Aside* pattern for frequent user profile and permission lookups. Caching these reads in Redis eliminated 85% of direct database round-trips, ensuring the connection pool remained comfortably below 40% capacity even under 1,000 concurrent virtual users.

=== Challenge 2: Race Conditions in Concurrent Ticket Assignments

*Symptom:* In high-volume contact center shifts, two team supervisors would occasionally assign the same incoming ticket to two different support agents simultaneously, causing dual notifications and conflicting audit log entries.

*Root-Cause Analysis:* The ticket assignment routine initially followed a naive _Read-Modify-Write_ sequence:
$ "Supervisor A Reads" &--> "Supervisor B Reads" \
  &--> "A Writes Assignee" --> "B Overwrites Assignee" $

Because both transactions read the ticket state before either write completed, the second update silently overwrote the first without detection.

*Engineering Resolution:*
- Implemented *Optimistic Concurrency Control (OCC)* in MongoDB using an atomic document `version` field.
- Modified the update query to atomically match both the ticket ID and its current version:
$ "Match: " &{"id": "ticketId", "version": v} \
  ==> "Update: " &{"$set": {"agentId": "newAgent"}, "$inc": {"version": 1}} $

- If another user mutates the ticket first, the version increments to $v+1$. The second transaction's update matches zero documents and immediately throws an HTTP `409 ConflictException`, prompting the user to refresh their view.

=== Challenge 3: Unhandled Asynchronous Promise Rejections and Memory Leaks

*Symptom:* During prolonged continuous execution, the Node.js process resident memory (RSS) exhibited monotonic escalation from 180 MB to over 1.2 GB, eventually triggering an Out-Of-Memory (OOM) operating system process termination.

*Root-Cause Analysis:* Node.js heap profiling via Chrome DevTools revealed that asynchronous event listeners on WebSocket dispatches were retaining closures over large payload contexts. Furthermore, unhandled promise rejections in background queue callbacks were silently accumulating uncollected garbage references in V8 memory.

*Engineering Resolution:*
- Audited all asynchronous promise chains, ensuring every `Promise` was accompanied by explicit `.catch()` handling or wrapped in structured `try/catch` blocks.
- Configured global process-level hooks in `main.ts` to intercept and log unhandled rejections:
```javascript
process.on('unhandledRejection', (reason, promise) => {
  logger.error('Unhandled Promise Rejection detected:', reason);
});
```

- Refactored WebSocket event listeners to explicitly unbind handlers upon socket disconnection, stabilizing memory utilization at a consistent 160 MB.

=== Challenge 4: Telecommunication Carrier Rate Limiting and Message Starvation

*Symptom:* When client marketing teams dispatched promotional bulk SMS campaigns (50,000+ recipients), downstream telecommunication carrier gateways immediately returned HTTP `429 Too Many Requests` error codes, dropping thousands of messages.

*Root-Cause Analysis:* The initial dispatch script looped synchronously over recipient lists, firing hundreds of HTTP requests per second. Carrier firewalls enforce strict Transaction-Per-Second (TPS) rate caps (e.g., 200 TPS per shortcode) to protect their internal SMS Centers (SMSC).

*Engineering Resolution:*
- Integrated the *Token Bucket Rate Limiter* (@sec:impl_sms) in Redis, capping dispatch rates strictly at 180 TPS.
- Decoupled ingestion from transmission using *BullMQ*. Inbound campaign requests are accepted instantaneously, while background worker processes consume jobs at the regulated carrier rate.
- Configured automated exponential backoff retries with randomized jitter, ensuring zero message loss during temporary carrier network congestion.

== Acquisition of Professional and Soft Skills <sec:exp_soft_skills>


Beyond technical and architectural proficiencies, the industrial internship served as an incubator for critical professional attributes essential for a practicing engineer:

- *Cross-Functional Communication:* Communicating technical trade-offs to non-technical stakeholders (such as BPO operations managers and client representatives) required translating architectural concepts (latency, concurrency, rate limits) into tangible business impacts (customer satisfaction, cost savings, SLA compliance).
- *Code Review Etiquette and Receptivity to Feedback:* Learning to embrace constructive criticism during senior peer reviews fostered humility and a focus on clean, self-documenting code.
- *Time Management and Prioritization:* Managing competing priorities across sprint deliverables, bug fixes, and technical documentation developed disciplined time allocation and milestone tracking.
- *Resilience in High-Pressure Scenarios:* Navigating production bugs in live contact center systems cultivated poise, systematic root-cause tracing, and a methodical approach to incident remediation.
