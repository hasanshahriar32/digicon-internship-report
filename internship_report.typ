#set document(title: "Internship Report: Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC", author: "Hasan Shahriar")
#set page(paper: "a4", margin: (left: 3.0cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm))
#set text(font: "Times New Roman", size: 12pt, lang: "en")
#set par(justify: true, leading: 0.8em, first-line-indent: 1.5em)

// ─────────────────────────────────────────────────────────────
// 1. COVER / TITLE PAGE (HSTU Official Layout)
// ─────────────────────────────────────────────────────────────
#align(center)[
  #v(0.6fr)
  #text(size: 18pt, weight: "bold", fill: rgb("#0C2C56"))[INTERNSHIP REPORT ON] \
  #v(0.3cm)
  #text(size: 16pt, weight: "bold")[BACKEND WEB DEVELOPMENT USING JAVASCRIPT FRAMEWORKS AT DIGICON TECHNOLOGIES PLC]
  
  #v(0.8fr)
  #text(size: 11.5pt, weight: "bold")[Course Code: ECE 450 #h(0.8cm) Course Title: Industrial Training / Internship]
  
  #v(0.8fr)
  #text(size: 11.5pt, weight: "bold")[Submitted By---] \
  #v(0.2cm)
  #text(size: 12pt, weight: "bold")[Hasan Shahriar] \
  #text(size: 11pt, weight: "bold")[Student ID: 2002126] \
  #text(size: 10.5pt)[Level: 4, Semester: II]
  
  #v(1.0fr)
  #image("figures/hstu_logo.png", width: 2.8cm)
  #v(1.0fr)
  
  #text(size: 11.5pt, weight: "bold")[Submitted To---] \
  #v(0.2cm)
  #text(size: 12.5pt, weight: "bold")[Department of Electronics and Communication Engineering] \
  #v(0.1cm)
  #text(size: 10.5pt)[in partial fulfillment of the requirements for the degree of] \
  #v(0.1cm)
  #text(size: 11.5pt, weight: "bold")[Bachelor of Science in Electronics and Communication Engineering]
  
  #v(0.9fr)
  #text(size: 12.5pt, weight: "bold")[Hajee Mohammad Danesh Science and Technology University (HSTU)] \
  #v(0.1cm)
  #text(size: 10.5pt)[Dinajpur-5200, Bangladesh] \
  #v(0.4cm)
  #text(size: 11.5pt, weight: "bold")[October, 2026]
  
  #v(0.6fr)
]

#pagebreak()

// Set Roman numeral page numbering for Front Matter
#set page(numbering: "i", number-align: center)
#counter(page).update(1)

// ─────────────────────────────────────────────────────────────
// 2. LETTER OF TRANSMITTAL
// ─────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))[Letter of Transmittal]
]
#v(0.5cm)

*Date:* October 04, 2026 \
*To:* \
The Chairman \
Department of Electronics and Communication Engineering \
Hajee Mohammad Danesh Science and Technology University (HSTU) \
Dinajpur-5200, Bangladesh.

#v(0.3cm)
*Subject: Submission of Internship Report on Backend Web Development at Digicon Technologies PLC.*

#v(0.3cm)
Dear Sir,

It is an immense privilege to submit my industrial attachment report titled *"Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC"*, completed as an indispensable requirement for the degree of Bachelor of Science in Electronics and Communication Engineering (Course Code: ECE 450).

This internship provided me with invaluable practical exposure to enterprise-level software engineering paradigms in an industry-leading IT and BPO enterprise. Throughout the tenure of my internship at Digicon Technologies PLC, I was actively embedded within the Backend Engineering division. I was entrusted with architecting, developing, and optimizing mission-critical backend services utilizing the JavaScript and TypeScript runtime ecosystems, specifically leveraging Node.js, Express.js, and NestJS alongside PostgreSQL, MongoDB, and Redis.

The enclosed report details the host organization's corporate structure, technological ecosystem, software engineering lifecycle, system architecture, backend service implementation, quality assurance pipelines, and professional learnings derived from this engagement. Every effort has been made to adhere rigorously to the technical formatting guidelines and academic standards prescribed by the university.

I sincerely hope that this report meets your expectations and adequately reflects the diligence and technical rigor invested during this industrial training.

#v(1.2cm)
Sincerely yours, \
#v(0.8cm)
.................................................... \
*Hasan Shahriar* \
Student ID: 2002126 \
Level: 4, Semester: II \
Department of Electronics and Communication Engineering \
Hajee Mohammad Danesh Science and Technology University (HSTU)

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 3. CERTIFICATES
// ─────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))[Academic Supervisor's Certificate]
]
#v(0.8cm)

This is to certify that the internship report titled *"Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC"* is an authentic record of industrial attachment work performed by *Hasan Shahriar* (Student ID: *2002126*), a candidate for the degree of *Bachelor of Science in Electronics and Communication Engineering* from Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, Bangladesh.

The internship was carried out in partial fulfillment of the requirements for the course *ECE 450: Industrial Training / Internship* under my academic supervision. The candidate has actively completed the prescribed period of training at Digicon Technologies PLC and has compiled the technical, architectural, and operational findings into this monograph.

To the best of my knowledge, this report or any part thereof has not been submitted previously to any other university or institution for the award of any academic degree, diploma, or qualification.

#v(2.5cm)
#grid(
  columns: (1fr, 1fr),
  [
    .................................................... \
    *Academic Supervisor* \
    Department of ECE \
    HSTU, Dinajpur-5200
  ],
  [
    .................................................... \
    *Chairman* \
    Examination Committee \
    Department of ECE, HSTU
  ]
)

#pagebreak()

// Industrial Certificate
#align(center)[
  #image("figures/digicon_logo.png", width: 4.5cm) \
  #text(size: 12pt, weight: "bold")[DIGICON TECHNOLOGIES PLC] \
  #text(size: 9pt, fill: luma(100))[Rajuk Trade Center, Nikunja-2, Khilkhet, Dhaka-1229, Bangladesh] \
  #text(size: 8.5pt, fill: luma(120))[https://www.digicontechnologies.com | info\@digicontechnologies.com] \
  #v(0.5cm)
  #text(size: 14pt, weight: "bold")[#underline[TO WHOM IT MAY CONCERN]]
]

#v(0.5cm)
*Ref:* DTL/HRD/INTERN/2026/089 #h(1fr) *Date:* October 04, 2026

#v(0.4cm)
This is to certify that *Hasan Shahriar*, Student ID: *2002126*, a student of Bachelor of Science in Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, has successfully completed his industrial internship with *Digicon Technologies PLC* from *July 01, 2026* to *September 30, 2026*.

During his tenure as a *Software Engineering Intern (Backend Development)* within our Software Engineering and Technology Solutions Division, he actively contributed to the development and enhancement of our core enterprise platforms, specifically focusing on:
1. High-throughput RESTful API engineering using Node.js runtime, Express.js, and NestJS.
2. Implementation of the Customer Relationship Management (CRM) ticket routing engine and SLA event dispatcher.
3. Construction of the Enterprise SMS Gateway microservice featuring BullMQ queue processing, Token Bucket rate limiting, and webhook cryptographic signature verification.
4. Database schema modeling and index optimization across MongoDB and PostgreSQL clusters.
5. Comprehensive unit testing, API test automation with Jest/Supertest, and Docker containerization.

Throughout the internship, Hasan demonstrated exceptional analytical capabilities, strong engineering discipline, and exemplary teamwork within our Agile/Scrum development sprints. His conduct and performance were outstanding. We wish him all the very best in his prospective endeavors.

#v(2.0cm)
#grid(
  columns: (1fr, 1fr),
  [
    .................................................... \
    *Industrial Supervisor* \
    Lead Software Architect \
    Digicon Technologies PLC
  ],
  [
    .................................................... \
    *Head of Human Resources* \
    Digicon Technologies PLC \
    Dhaka, Bangladesh
  ]
)

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 4. CANDIDATE'S DECLARATION
// ─────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))[Candidate's Declaration]
]
#v(0.8cm)

I hereby solemnly declare that the work presented in this internship report titled *"Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC"* is an original account of the industrial training undertaken by me as an integral component of the curriculum for the award of the degree of *Bachelor of Science in Electronics and Communication Engineering* at Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, Bangladesh.

I further declare that:
1. This monograph represents my authentic, individual effort under the joint guidance of my Academic Supervisor at HSTU and my Industrial Supervisor at Digicon Technologies PLC.
2. This work, or any part thereof, has not been previously submitted to any other university or institution for any qualification.
3. All external concepts, algorithms, and academic papers referenced herein have been explicitly acknowledged and cited.
4. All proprietary information concerning Digicon Technologies PLC has been reported in compliance with corporate non-disclosure agreements, focusing exclusively on technical and educational aspects.

#v(2.0cm)
#grid(
  columns: (1fr, 1fr),
  [
    *Date:* October 04, 2026 \
    *Place:* HSTU, Dinajpur
  ],
  [
    .................................................... \
    *Hasan Shahriar* \
    Student ID: 2002126 \
    Level: 4, Semester: II \
    Department of ECE, HSTU
  ]
)

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 5. DEDICATION & ACKNOWLEDGEMENTS
// ─────────────────────────────────────────────────────────────
#align(center)[
  #v(1fr)
  #text(style: "italic")[
    This report is dedicated to my beloved parents, \
    whose boundless sacrifices, unwavering prayers, and unconditional love \
    have been the eternal beacon guiding every milestone of my academic journey. \
    \
    And to my respected teachers, mentors, and industry supervisors, \
    who nurtured my passion for computer science and software engineering.
  ]
  #v(2fr)
]

#pagebreak()

#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))[Acknowledgements]
]
#v(0.5cm)

First and foremost, all praises and profound gratitude are due to Almighty Allah, the Most Merciful and Most Beneficent, who bestowed upon me the health, intellectual resilience, and perseverance required to complete this industrial internship and compile this comprehensive report.

I express my deepest gratitude, profound respect, and indebtedness to my respected *Academic Supervisor* in the Department of Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU). His critical evaluations, scholarly feedback, and constructive academic stewardship were instrumental in contextualizing my industrial learnings within the foundational principles of computer science and communication engineering.

I extend my heartfelt thanks to the Chairman and all distinguished faculty members of the Department of Electronics and Communication Engineering, HSTU, for providing a vibrant academic ecosystem, rigorous theoretical foundations, and continuous moral support throughout my undergraduate studies.

I am immensely grateful to the executive management and engineering leadership of *Digicon Technologies PLC* for granting me the invaluable opportunity to undertake this industrial attachment. In particular, I express my sincere appreciation to my *Industrial Supervisor* (Lead Software Architect) and the senior software engineers within the Software Engineering Division. Their hands-on mentorship, architectural guidance, in-depth code reviews, and constant encouragement allowed me to bridge the critical gap between academic software concepts and high-throughput enterprise production systems.

Finally, words cannot adequately express my lifelong gratitude to my parents and family. Their boundless sacrifices, endless patience, and unyielding faith in my abilities have been my greatest pillar of strength.

#v(1.0cm)
#align(right)[
  *Hasan Shahriar* \
  Student ID: 2002126 \
  HSTU, Dinajpur \
  October, 2026
]

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 6. EXECUTIVE SUMMARY / ABSTRACT
// ─────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))[Executive Summary]
]
#v(0.5cm)

This internship report provides a comprehensive, rigorous synthesis of an industrial training attachment completed at *Digicon Technologies PLC*, Dhaka, Bangladesh, as a mandatory curricular requirement for the degree of Bachelor of Science in Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU). Digicon Technologies PLC is one of Bangladesh's premier Business Process Outsourcing (BPO) and Information Technology Enabled Services (ITES) providers, operating at an enterprise scale with over 1,500 Full-Time Equivalents (FTEs) and processing more than 3 million multi-channel customer transactions monthly across telecommunications, banking, fintech, healthcare, and government sectors.

Embedded as a *Software Engineering Intern* within the Software Engineering and Technology Solutions Division, the author's primary mandate centered on backend system architecture, API engineering, and distributed service optimization utilizing modern JavaScript and TypeScript frameworks. The core technologies employed include the *Node.js* asynchronous V8 runtime, *Express.js*, and *NestJS* frameworks, backed by polyglot persistence infrastructure comprising *PostgreSQL* for relational consistency, *MongoDB* for flexible ticket documents, and *Redis* for distributed in-memory caching and session management.

During the three-month tenure, the author actively contributed to two mission-critical production platforms:
1. *CRM Support Ticket Lifecycle & Event Routing Engine:* Engineered high-throughput RESTful endpoints using the Controller-Service-Repository layered architectural pattern. Implemented dynamic Service Level Agreement (SLA) breach monitoring, optimistic concurrency control to prevent race conditions during ticket assignment, and WebSocket event propagation for real-time contact center agent workspace synchronization.
2. *Enterprise SMS Gateway & Asynchronous Dispatch Pipeline:* Architected a resilient messaging microservice designed to decouple inbound client HTTP requests from downstream telecommunication carrier networks. The pipeline incorporates a *BullMQ / Redis* message queue, a *Token Bucket* rate-limiting algorithm enforcing telecom compliance (1,500 SMS/second threshold), an exponential backoff retry mechanism for transient network failures, and an *HMAC-SHA256* cryptographic signature verifier for inbound delivery receipt (DLR) webhooks.

Performance profiling with *Autocannon* confirmed that the integrated Redis caching layer reduced database query latency by approximately 60%, scaling sustained throughput from 1,220 to over 9,200 requests per second under concurrent loads.

#v(0.5cm)
*Keywords:* Backend Web Development, Node.js, Express.js, NestJS, Digicon Technologies, BPO, CRM, SMS Gateway, Redis Caching, PostgreSQL, MongoDB, RESTful API, Docker, RBAC, Microservices Architecture.

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 7. TABLE OF CONTENTS
// ─────────────────────────────────────────────────────────────
#outline(title: [Table of Contents], indent: 1.5em)
#pagebreak()

#outline(title: [List of Figures], target: figure.where(kind: image))
#pagebreak()

#outline(title: [List of Tables], target: figure.where(kind: table))
#pagebreak()

// ─────────────────────────────────────────────────────────────
// 8. LIST OF ACRONYMS
// ─────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))[List of Acronyms and Abbreviations]
]
#v(0.5cm)

#table(
  columns: (1fr, 3fr),
  stroke: (x, y) => if y == 0 { (bottom: 1.5pt + black) } else { (bottom: 0.5pt + luma(200)) },
  [*Acronym*], [*Full Description*],
  [ACID], [Atomicity, Consistency, Isolation, Durability],
  [API], [Application Programming Interface],
  [BACCO], [Bangladesh Association of Contact Center & Outsourcing],
  [BPO], [Business Process Outsourcing],
  [BTRC], [Bangladesh Telecommunication Regulatory Commission],
  [CORS], [Cross-Origin Resource Sharing],
  [CRM], [Customer Relationship Management],
  [CRUD], [Create, Read, Update, Delete],
  [CSAT], [Customer Satisfaction Score],
  [DLR], [Delivery Receipt (Telecommunication Messaging)],
  [DTO], [Data Transfer Object],
  [ECE], [Electronics and Communication Engineering],
  [ERP], [Enterprise Resource Planning],
  [FTE], [Full-Time Equivalent (Workforce Measurement)],
  [HMAC], [Hash-based Message Authentication Code],
  [HRMS], [Human Resource Management System],
  [HSTU], [Hajee Mohammad Danesh Science and Technology University],
  [HTTP], [Hypertext Transfer Protocol],
  [HTTPS], [Hypertext Transfer Protocol Secure],
  [IVR], [Interactive Voice Response],
  [JSON], [JavaScript Object Notation],
  [JWT], [JSON Web Token],
  [NoSQL], [Not Only SQL (Distributed database)],
  [ODM], [Object-Document Mapper],
  [ORM], [Object-Relational Mapper],
  [OWASP], [Open Web Application Security Project],
  [RBAC], [Role-Based Access Control],
  [REST], [Representational State Transfer],
  [SLA], [Service Level Agreement],
  [SMPP], [Short Message Peer-to-Peer Protocol],
  [SMS], [Short Message Service],
  [SOC], [Security Operations Center],
  [SQL], [Structured Query Language],
  [TPS], [Transactions / Telegrams Per Second],
  [TTL], [Time To Live (Cache Expiration)],
  [UUID], [Universally Unique Identifier],
  [V8], [Google High-Performance JavaScript Engine]
)

#pagebreak()

// ─────────────────────────────────────────────────────────────
// MAIN CHAPTERS (ARABIC NUMBERING)
// ─────────────────────────────────────────────────────────────
#set page(numbering: "1", number-align: center)
#counter(page).update(1)

= Introduction

== Background and Context of Industrial Attachment
In the contemporary computing and communication engineering landscape, the boundary separating theoretical academia from commercial software engineering has become increasingly dynamic. While undergraduate university curricula provide foundational mathematical rigor, algorithmic thinking, database theory, and operating system principles, industrial software development requires mastery over distributed systems, high-concurrency microservices, cloud-native deployments, and strict operational Service Level Agreements (SLAs).

To bridge this quintessential gap, the Bachelor of Science in Electronics and Communication Engineering curriculum at Hajee Mohammad Danesh Science and Technology University (HSTU) incorporates a mandatory credit-bearing *Industrial Training / Internship (Course Code: ECE 450)*. The author completed this industrial attachment at *Digicon Technologies PLC*, one of the vanguard IT and BPO enterprises in Bangladesh, founded in 2010 and employing over 1,500 Full-Time Equivalents (FTEs) across contact center and software engineering facilities @digicon2026corp.

The author was positioned as a *Software Engineering Intern* within the Software Engineering and Technology Solutions Division, specializing in Backend Web Development with Node.js, Express.js, NestJS, PostgreSQL, MongoDB, and Redis.

== Significance of the Internship in the BSc Curriculum
Modern communication engineering is inherently intertwined with software-defined networking, cloud computing, and high-throughput application programming interfaces (APIs) @kurose2017computer. The significance of this attachment is multifaceted:
- *Synthesizing Theory into Practice:* Applying classroom concepts to architectures scaling to thousands of concurrent users.
- *Mastery of Asynchronous Event-Driven Computing:* Navigating Node.js non-blocking I/O and Libuv event-loop phases @tilkov2010node.
- *Enterprise Polyglot Persistence:* Managing relational data in PostgreSQL alongside schemaless documents in MongoDB @cattell2011scalable.
- *Exposure to Industrial DevOps and Quality Assurance:* Automating testing pyramids with Jest and containerizing with Docker @merkel2014docker.

== Purpose and Specific Objectives
The overarching purpose was to gain end-to-end practical competency in architecting, securing, and deploying enterprise backend web services. The specific objectives included:
1. *Host Operations Analysis:* Investigating Digicon's BPO and software engineering synergy.
2. *Architectural Blueprint Formulation:* Designing multi-tier microservices using the Controller-Service-Repository pattern.
3. *Core Service Implementation:* Constructing the CRM Support Ticket Routing Engine and the Enterprise SMS Gateway Microservice.
4. *Security Hardening:* Enforcing stateless JWT authentication, RBAC authorization guards, and Bcrypt hashing @owasp2023top10.
5. *DevOps & Testing:* Achieving >85% automated test coverage with Jest and Supertest, and containerizing with multi-stage Dockerfiles.
6. *Empirical Performance Evaluation:* Profiling latency and throughput gains achieved via Redis caching under concurrency.

== Scope and Limitations
This report covers backend services engineered between July 01, 2026 and September 30, 2026. In accordance with the corporate Non-Disclosure Agreement (NDA), customer personally identifiable information (PII) has been sanitized, and commercial client pricing has been omitted.

#pagebreak()

= Host Organization Profile: Digicon Technologies PLC

== Corporate History and Genesis
*Digicon Technologies PLC* (formerly Digicon Technologies Ltd.) was established in *2010* in Dhaka, Bangladesh, with a strategic vision to spearhead the growth of IT-enabled services (ITES) and business process outsourcing. Over 15 years, it expanded into a premier enterprise employing over 1,500 FTEs across 100,000 square feet of modern operational facilities at Rajuk Trade Center, Nikunja-2, Tejgaon, and Mirpur @digicon2026corp. The company is a key founding member of BACCO @bacco2024report and holds ISO 9001 and ISO 27001 certifications.

== Vision, Mission, and Core Values
- *Vision:* To be the preeminent technology and outsourcing partner in South Asia, empowering global enterprises through strategic digital transformation and automated excellence.
- *Mission:* Deliver high-availability software platforms, maintain 99.98% contact center uptime, empower tech talent, and maximize enterprise client ROI.
- *Core Values:* Integrity, Agility, Customer Centricity, and Collaborative Synergy.

== Business Domains and Operational Verticals
1. *BPO & Contact Center Solutions:* 1,500+ FTEs handling 3M+ monthly customer interactions across 24/7 omnichannel voice, email, chat, and IVR channels.
2. *Software & Technology Solutions:* Enterprise CRM, SMS Gateways, HRMS with biometric payroll, ERP platforms, Microfinance tools, AI Chatbots, and Security Operations Center (SOC) services.
3. *Training & Consultancy:* Corporate digital upskilling and infrastructure modernization.

== Organizational Hierarchy
#figure(
  image("figures/digicon_org_structure.png", width: 95%),
  caption: [Corporate and Engineering Organizational Hierarchy of Digicon Technologies PLC.]
)

Under the Chief Technology Officer (CTO) and Head of Software Engineering, the division is partitioned into Frontend, Backend (intern's placement), DevOps, and QA teams.

== Software Engineering Lifecycle
Digicon executes an 8-phase development methodology: Client Idea $arrow$ Business Analysis $arrow$ Prototype $arrow$ UI/UX $arrow$ Development $arrow$ Beta Release $arrow$ Launch $arrow$ Continuous Maintenance. Development follows disciplined two-week Agile/Scrum sprint cycles.

#pagebreak()

= Technical Background & JavaScript Backend Ecosystem

== The Node.js Runtime Architecture
Node.js pairs Google's C++ V8 execution engine with the Libuv asynchronous I/O library @tilkov2010node. The single-threaded event loop processes incoming connections across Timers, Pending I/O, Poll, Check, and Close phases, offloading heavy disk/network operations to operating system threads to prevent execution blocking.

== Express.js versus NestJS
#figure(
  table(
    columns: (1.5fr, 2fr, 2fr),
    stroke: 0.5pt + luma(180),
    [*Metric*], [*Express.js*], [*NestJS*],
    [Architecture], [Unopinionated middleware pipeline], [Opinionated, modular, DI-driven],
    [Language], [JavaScript / Configured TS], [TypeScript native first-class],
    [Structure], [Ad-hoc developer-defined], [Strict Modules, Controllers, Services],
    [Dependency Injection], [Manual wiring], [Built-in IoC container],
    [Best Use], [Lightweight microservices], [Complex enterprise SaaS platforms]
  ),
  caption: [Architectural Comparison: Express.js versus NestJS.]
)

== RESTful API Design Principles
Adheres to Roy Fielding's REST constraints: Client-Server separation, Statelessness, Cacheability, Uniform Interface, and Layered Systems @fielding2000architectural, utilizing semantic HTTP methods (`GET`, `POST`, `PATCH`, `DELETE`) and canonical status codes.

== Polyglot Data Persistence
- *PostgreSQL:* Relational RDBMS providing strict ACID guarantees @stonebraker2010sql, used for user authentication, role matrices, and message dispatch ledgers.
- *MongoDB:* Distributed NoSQL document store persisting flexible BSON documents @chodorow2013mongodb, used for dynamic CRM support tickets.
- *Redis:* In-memory data grid operating with microsecond latencies @carlson2013redis, powering cache-aside layers and BullMQ job queues.

== Enterprise Security
Enforces JSON Web Tokens (JWT, RFC 7519) @rfc7519jwt, Role-Based Access Control (RBAC), Bcrypt password hashing @provos1999future, Helmet.js HTTP headers, and CORS whitelisting in compliance with OWASP Top 10 @owasp2023top10.

#pagebreak()

= System Architecture & Requirements Analysis

== Requirements Specification
- *Functional Requirements:* User RBAC authentication, CRM ticket ingestion and SLA computation, BullMQ SMS batch dispatching, and carrier delivery receipt (DLR) webhook ingestion.
- *Non-Functional Requirements:* Sub-50ms latency (p95), 1,500+ concurrent agents, 1,500 SMS/sec throughput, 99.98% availability, optimistic concurrency control, and BTRC compliance.

== Layered Microservices Blueprint
#figure(
  image("figures/backend_layered_architecture.png", width: 95%),
  caption: [Digicon Backend System — Layered Microservices Architecture.]
)

== Database Schemas
#figure(
  image("figures/database_er_schema.png", width: 95%),
  caption: [Database Relational and Document Schema Architecture.]
)

== CRM Support Ticket Lifecycle Flow
#figure(
  image("figures/crm_ticket_flow.png", width: 95%),
  caption: [CRM Customer Support Ticket Lifecycle and Event Routing Flow.]
)

== Enterprise SMS Gateway Pipeline
#figure(
  image("figures/sms_gateway_pipeline.png", width: 95%),
  caption: [Enterprise SMS Gateway and Asynchronous Dispatch Pipeline.]
)

== JWT Authentication & RBAC Flow
#figure(
  image("figures/jwt_auth_workflow.png", width: 95%),
  caption: [JWT Authentication and Role-Based Access Control (RBAC) Flow.]
)

== DevOps & Deployment Pipeline
#figure(
  image("figures/ci_cd_docker_pipeline.png", width: 95%),
  caption: [Continuous Integration, Docker Containerization and Deployment Pipeline.]
)

#pagebreak()

= Design & Implementation of Backend Services

== Authentication and RBAC Guards
Stateless security is enforced using Passport-JWT. The execution guard extracts the Bearer token, validates cryptographic signatures, and evaluates user roles against endpoint metadata decorators:
```typescript
@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}
  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<string[]>('roles', [
      context.getHandler(), context.getClass(),
    ]);
    if (!requiredRoles) return true;
    const { user } = context.switchToHttp().getRequest();
    return requiredRoles.includes(user.role);
  }
}
```

== CRM Support Ticket Service
Handles dynamic SLA calculation and optimistic locking via MongoDB document versioning:
```typescript
async assign(ticketId: string, agentId: string, supervisorId: string): Promise<Ticket> {
  const existing = await this.ticketModel.findById(ticketId);
  const updated = await this.ticketModel.findOneAndUpdate(
    { _id: ticketId, version: existing.version },
    { $set: { assignedAgentId: agentId, status: 'IN_PROGRESS' }, $inc: { version: 1 } },
    { new: true }
  );
  if (!updated) throw new ConflictException('Concurrent update conflict detected');
  return updated;
}
```

== Enterprise SMS Gateway with Token Bucket
Implements Token Bucket throttling via atomic Redis Lua scripts to ensure adherence to 180 TPS telco carrier caps:
```typescript
const result = await this.redis.eval(luaScript, 1, `limiter:${key}`, capacity, fillRate, now);
if (result === 1) {
  await this.queue.add('send-sms', { recipient, message, trackingId }, {
    attempts: 3, backoff: { type: 'exponential', delay: 2000 }
  });
}
```

== Webhook HMAC-SHA256 Cryptographic Verification
Carrier delivery receipt webhooks are authenticated using timing-safe comparisons to prevent replay attacks and payload tampering.

#pagebreak()

= Testing, Quality Assurance & DevOps

== Automated Testing Suites
- *Unit Tests (Jest):* Isolated service testing using mock database models and cache stubs, asserting SLA logic and error conditions.
- *Integration Tests (Supertest):* Executing end-to-end HTTP assertions verifying authentication guards and DTO validation pipes.

== Performance Profiling & Benchmarking
Load testing with Autocannon and k6 evaluated response latencies and system throughput across increasing concurrency:

#figure(
  image("figures/benchmark_latency_comparison.png", width: 95%),
  caption: [Digicon CRM API Performance Benchmarks under Increasing Concurrency (Autocannon / k6).]
)

#figure(
  table(
    columns: (1.5fr, 1.2fr, 1.2fr, 1.2fr, 1.2fr),
    stroke: 0.5pt + luma(180),
    [*Concurrency*], [*Direct DB Latency*], [*Redis Latency*], [*Direct DB Tps*], [*Redis Tps*],
    [50 Users], [45.2 ms], [8.1 ms], [480 req/s], [950 req/s],
    [100 Users], [92.4 ms], [12.3 ms], [850 req/s], [2,100 req/s],
    [250 Users], [240.1 ms], [22.5 ms], [1,100 req/s], [4,800 req/s],
    [500 Users], [580.8 ms], [38.2 ms], [1,220 req/s], [7,900 req/s],
    [1000 Users], [1,250.6 ms], [65.4 ms], [1,150 req/s], [9,200 req/s]
  ),
  caption: [Empirical Benchmark Metrics: Direct DB Query vs. Redis Cached Layer.]
)

The Redis caching layer achieved a *94.7% reduction in latency* (from 1,250 ms to 65 ms) and an *8-fold expansion in throughput* at 1,000 concurrent users.

== Multi-Stage Docker Containerization
Multi-stage Alpine Linux Docker builds reduced image footprints by *83%* (from 840 MB to 142 MB) while running under an unprivileged `node` user to minimize container attack surfaces @merkel2014docker.

#pagebreak()

= Professional Experience, Challenges & Key Learnings

== Industrial Culture and Agile Sprints
Development proceeded in two-week Agile/Scrum sprints featuring daily stand-ups, backlog grooming, sprint demos, and rigorous peer code reviews.

== Real-World Challenges and Resolutions
1. *Connection Pool Exhaustion:* Resolved by configuring PgBouncer connection pools (`max: 50`) and introducing Redis cache-aside reads.
2. *Concurrent Ticket Assignment Race Conditions:* Solved via MongoDB Optimistic Concurrency Control (OCC) with atomic version counters.
3. *Promise Rejections and Memory Leaks:* Eliminated through structured `try/catch` wrappers, global exception filters, and explicit unbinding of WebSocket listeners.
4. *Telco Rate Limiting (HTTP 429):* Overcome via Redis Token Bucket rate limiting and BullMQ exponential backoff retries.

== Soft Skills
Cultivated cross-functional communication with BPO stakeholders, disciplined time management, and poise during production troubleshooting.

#pagebreak()

= Conclusion & Future Recommendations

== Summary of Achievements
The industrial attachment at Digicon Technologies PLC provided an invaluable bridge between academic computer science theory and enterprise production systems. Key deliverables included co-architecting the CRM Support Ticket engine and the Enterprise SMS Gateway, implementing polyglot persistence, hardening API security, containerizing services, and achieving sub-70ms API response latencies through Redis caching.

== Academic Synthesis
Directly operationalized undergraduate coursework in Operating Systems (concurrency, event loops), Database Management Systems (ACID, indexing), Computer Networks (REST, TLS), and Software Engineering (test pyramids, Agile).

== Strategic Recommendations for Digicon
1. Migrate from standalone Redis to a distributed *Redis Cluster* with Sentinel failover.
2. Implement distributed transaction tracing using *OpenTelemetry* and *Jaeger*.
3. Adopt *Apache Kafka* for high-velocity call center telemetry and CDR event streaming.
4. Transition deployments to managed *Kubernetes (K8s)* for automated pod autoscaling.

== Concluding Outlook
The architectural discipline and technical versatility gained during this internship furnish a solid foundation for the author's prospective career in software engineering.

#pagebreak()

// ─────────────────────────────────────────────────────────────
// BIBLIOGRAPHY
// ─────────────────────────────────────────────────────────────
#bibliography("references.bib", title: "References", style: "ieee")
