#set document(title: "Internship Report: Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC", author: "Shahriar Hasan")
#set page(paper: "a4", margin: (left: 3.0cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm))
#set text(font: "Times New Roman", size: 12pt, lang: "en")
#set par(justify: true, leading: 0.8em, first-line-indent: 1.5em)

// ─────────────────────────────────────────────────────────────
// HEADING STYLING SPECIFICATIONS (HSTU Monograph Format)
// ─────────────────────────────────────────────────────────────
#show heading.where(level: 1): it => block(width: 100%)[
  #if it.numbering != none [
    #set align(left)
    #set text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))
    #v(12pt)
    Chapter #counter(heading).display() \
    #v(6pt)
    #it.body
    #v(18pt)
  ] else [
    #set align(center)
    #set text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))
    #v(10pt)
    #it.body
    #v(16pt)
  ]
]

#show heading.where(level: 2): it => block(width: 100%)[
  #set align(left)
  #set text(size: 14pt, weight: "bold", fill: rgb("#184C78"))
  #v(16pt)
  #if it.numbering != none [
    #counter(heading).display()
    #h(0.4em)
  ]
  #it.body
  #v(8pt)
]

#show heading.where(level: 3): it => block(width: 100%)[
  #set align(left)
  #set text(size: 12pt, weight: "bold", fill: rgb("#0C2C56"))
  #v(12pt)
  #if it.numbering != none [
    #counter(heading).display()
    #h(0.4em)
  ]
  #it.body
  #v(6pt)
]

#show heading.where(level: 4): it => block(width: 100%)[
  #set align(left)
  #set text(size: 12pt, weight: "regular", style: "italic", fill: rgb("#0C2C56"))
  #v(10pt)
  #if it.numbering != none [
    #counter(heading).display()
    #h(0.4em)
  ]
  #it.body
  #v(4pt)
]

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
  #text(size: 12pt, weight: "bold")[Shahriar Hasan] \
  #text(size: 11pt, weight: "bold")[Student ID: 2002138] \
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
#heading(level: 1, numbering: none)[Letter of Transmittal]
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

I sincerely hope that this report meets your expectations and adequately reflects the diligence and technical rigor invested during this industrial training. I would be honored to provide any further clarification or technical exposition you may require.

#v(1.2cm)
Sincerely yours, \
#v(0.8cm)
.................................................... \
*Shahriar Hasan* \
Student ID: 2002138 \
Level: 4, Semester: II \
Department of Electronics and Communication Engineering \
Hajee Mohammad Danesh Science and Technology University (HSTU) \
Dinajpur-5200, Bangladesh

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 3. CERTIFICATES
// ─────────────────────────────────────────────────────────────
#heading(level: 1, numbering: none)[Academic Supervisor's Certificate]
#v(0.6cm)

This is to certify that the internship report titled *"Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC"* is an authentic record of industrial attachment work performed by *Shahriar Hasan* (Student ID: *2002138*), a candidate for the degree of *Bachelor of Science in Electronics and Communication Engineering* from Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, Bangladesh.

The internship was carried out in partial fulfillment of the requirements for the course *ECE 450: Industrial Training / Internship* under my academic supervision. The candidate has actively completed the prescribed period of training at Digicon Technologies PLC and has compiled the technical, architectural, and operational findings into this monograph.

To the best of my knowledge, this report or any part thereof has not been submitted previously to any other university or institution for the award of any academic degree, diploma, or qualification.

#v(2.5cm)
#grid(
  columns: (1fr, 1fr),
  [
    .................................................... \
    *Academic Supervisor* \
    Department of ECE \
    Hajee Mohammad Danesh Science \
    and Technology University (HSTU)
  ],
  [
    .................................................... \
    *Chairman* \
    Examination Committee \
    Department of ECE \
    HSTU, Dinajpur-5200
  ]
)

#pagebreak()

// Industrial Certificate
#heading(level: 1, numbering: none)[Industrial Internship Certificate]
#v(0.3cm)

#align(center)[
  #image("figures/cert.png", width: 92%)
]

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 4. CANDIDATE'S DECLARATION
// ─────────────────────────────────────────────────────────────
#heading(level: 1, numbering: none)[Candidate's Declaration]
#v(0.6cm)

I hereby solemnly declare that the work presented in this internship report titled *"Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC"* is an original account of the industrial training undertaken by me as an integral component of the curriculum for the award of the degree of *Bachelor of Science in Electronics and Communication Engineering* at Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, Bangladesh.

#v(0.3cm)
I further declare that:
1. This monograph represents my authentic, individual effort under the joint guidance of my Academic Supervisor at HSTU and my Industrial Supervisor at Digicon Technologies PLC.
2. This work, or any part thereof, has not been previously submitted to any other university, institute, or examining body for the award of any degree, diploma, fellowship, or professional qualification.
3. All external ideas, technical documentations, code algorithms, architectural patterns, and academic papers referenced herein have been explicitly acknowledged and cited in compliance with international academic integrity and copyright conventions.
4. All proprietary information concerning Digicon Technologies PLC has been reported in compliance with corporate non-disclosure agreements, focusing exclusively on technical, architectural, and educational aspects of backend web development without divulging proprietary customer identities or confidential business credentials.

#v(2.0cm)
#grid(
  columns: (1fr, 1fr),
  [
    *Date:* October 04, 2026 \
    *Place:* HSTU, Dinajpur
  ],
  [
    .................................................... \
    *Shahriar Hasan* \
    Student ID: 2002138 \
    Level: 4, Semester: II \
    Department of Electronics and Communication Engineering \
    Hajee Mohammad Danesh Science and Technology University
  ]
)

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 5. DEDICATION & ACKNOWLEDGEMENTS
// ─────────────────────────────────────────────────────────────
#heading(level: 1, numbering: none)[Dedication]
#v(1fr)
#align(center)[
  #text(size: 12pt, style: "italic")[
    This report is dedicated to my beloved parents, \
    whose boundless sacrifices, unwavering prayers, and unconditional love \
    have been the eternal beacon guiding every milestone of my academic journey. \
    \
    #v(0.8cm)
    And to my respected teachers, mentors, and industry supervisors, \
    who nurtured my passion for computer science, software engineering, \
    and the pursuit of technological innovation.
  ]
]
#v(2fr)

#pagebreak()

#heading(level: 1, numbering: none)[Acknowledgements]
#v(0.4cm)

First and foremost, all praises and profound gratitude are due to Almighty Allah, the Most Merciful and Most Beneficent, who bestowed upon me the health, intellectual resilience, and perseverance required to complete this industrial internship and compile this comprehensive report.

I express my deepest gratitude, profound respect, and indebtedness to my respected *Academic Supervisor* in the Department of Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU). His critical evaluations, scholarly feedback, and constructive academic stewardship were instrumental in contextualizing my industrial learnings within the foundational principles of computer science and communication engineering.

I extend my heartfelt thanks to the Chairman and all distinguished faculty members of the Department of Electronics and Communication Engineering, HSTU, for providing a vibrant academic ecosystem, rigorous theoretical foundations, and continuous moral support throughout my undergraduate studies.

I am immensely grateful to the executive management and engineering leadership of *Digicon Technologies PLC* for granting me the invaluable opportunity to undertake this industrial attachment. In particular, I express my sincere appreciation to my *Industrial Supervisor* (Lead Software Architect) and the senior software engineers within the Software Engineering Division. Their hands-on mentorship, architectural guidance, in-depth code reviews, and constant encouragement allowed me to bridge the critical gap between academic software concepts and high-throughput enterprise production systems.

I would also like to thank the engineering team members, DevOps specialists, and Quality Assurance engineers at Digicon for their collegial camaraderie, technical discussions during daily Scrum stand-ups, and collaborative spirit.

Finally, words cannot adequately express my lifelong gratitude to my parents and family. Their boundless sacrifices, endless patience, and unyielding faith in my abilities have been my greatest pillar of strength. I also extend my warm appreciation to my batchmates and friends at HSTU for their camaraderie and support throughout my university life.

#v(1.5cm)
#align(right)[
  *Shahriar Hasan* \
  Student ID: 2002138 \
  HSTU, Dinajpur \
  October, 2026
]

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 6. EXECUTIVE SUMMARY / ABSTRACT
// ─────────────────────────────────────────────────────────────
#heading(level: 1, numbering: none)[Executive Summary]
#v(0.4cm)

This internship report provides a comprehensive, rigorous synthesis of an industrial training attachment completed at *Digicon Technologies PLC*, Dhaka, Bangladesh, as a mandatory curricular requirement for the degree of Bachelor of Science in Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU). Digicon Technologies PLC is one of Bangladesh's premier Business Process Outsourcing (BPO) and Information Technology Enabled Services (ITES) providers, operating at an enterprise scale with over 1,500 Full-Time Equivalents (FTEs) and processing more than 3 million multi-channel customer transactions monthly across telecommunications, banking, fintech, healthcare, and government sectors.

Embedded as a *Software Engineering Intern* within the Software Engineering and Technology Solutions Division, the author's primary mandate centered on backend system architecture, API engineering, and distributed service optimization utilizing modern JavaScript and TypeScript frameworks. The core technologies employed include the *Node.js* asynchronous V8 runtime, *Express.js*, and *NestJS* frameworks, backed by polyglot persistence infrastructure comprising *PostgreSQL* for relational consistency, *MongoDB* for flexible ticket documents, and *Redis* for distributed in-memory caching and session management.

During the three-month tenure, the author actively contributed to two mission-critical production platforms:
1. *CRM Support Ticket Lifecycle & Event Routing Engine:* Engineered high-throughput RESTful endpoints using the Controller-Service-Repository layered architectural pattern. Implemented dynamic Service Level Agreement (SLA) breach monitoring, optimistic concurrency control to prevent race conditions during ticket assignment, and WebSocket event propagation for real-time contact center agent workspace synchronization.
2. *Enterprise SMS Gateway & Asynchronous Dispatch Pipeline:* Architected a resilient messaging microservice designed to decouple inbound client HTTP requests from downstream telecommunication carrier networks. The pipeline incorporates a *BullMQ / Redis* message queue, a *Token Bucket* rate-limiting algorithm enforcing telecom compliance (1,500 SMS/second threshold), an exponential backoff retry mechanism for transient network failures, and an *HMAC-SHA256* cryptographic signature verifier for inbound delivery receipt (DLR) webhooks.

To ensure production robustness, security hardening was executed using *Helmet.js*, Cross-Origin Resource Sharing (CORS) whitelisting, and Role-Based Access Control (RBAC) via JSON Web Tokens (JWT). Automated unit and integration testing pipelines were established using *Jest* and *Supertest*, attaining upwards of 85% code coverage across core service layers. Furthermore, applications were packaged into lightweight production containers utilizing multi-stage *Docker* builds, reducing final image sizes by 83% (from 840 MB to 142 MB). Performance profiling with *Autocannon* confirmed that the integrated Redis caching layer reduced database query latency by approximately 60%, scaling sustained throughput from 1,220 to over 9,200 requests per second under concurrent loads.

This report documents the organizational landscape, technical foundations, architectural blueprints, concrete code implementations, DevOps pipelines, real-world engineering challenges, and qualitative professional reflections gained during this industrial immersion. The experience solidified the practical translation of university computing theory into scalable, fault-tolerant enterprise software engineering.

#v(0.8cm)
*Keywords:* Backend Web Development, Node.js, Express.js, NestJS, Digicon Technologies, BPO, CRM, SMS Gateway, Redis Caching, PostgreSQL, MongoDB, RESTful API, Docker, RBAC, Microservices Architecture.

#pagebreak()

// ─────────────────────────────────────────────────────────────
// 7. TABLE OF CONTENTS, LIST OF FIGURES, LIST OF TABLES
// ─────────────────────────────────────────────────────────────
#outline(title: "Table of Contents", depth: 3, indent: auto)
#pagebreak()

#outline(title: "List of Figures", target: figure.where(kind: image))
#pagebreak()

#outline(title: "List of Tables", target: figure.where(kind: table))
#pagebreak()

// ─────────────────────────────────────────────────────────────
// 8. LIST OF ACRONYMS AND ABBREVIATIONS
// ─────────────────────────────────────────────────────────────
#heading(level: 1, numbering: none)[List of Acronyms and Abbreviations]
#v(0.4cm)

#table(
  columns: (1fr, 3.2fr),
  stroke: (x, y) => if y == 0 { (top: 1.2pt + luma(0), bottom: 0.8pt + luma(0)) } else { (bottom: 0.5pt + luma(210)) },
  inset: (x: 6pt, y: 4pt),
  table.header([*Acronym*], [*Full Description*]),
  [ACID], [Atomicity, Consistency, Isolation, Durability],
  [API], [Application Programming Interface],
  [BACCO], [Bangladesh Association of Contact Center & Outsourcing],
  [BPO], [Business Process Outsourcing],
  [BTRC], [Bangladesh Telecommunication Regulatory Commission],
  [CORS], [Cross-Origin Resource Sharing],
  [CPU], [Central Processing Unit],
  [CRM], [Customer Relationship Management],
  [CRUD], [Create, Read, Update, Delete],
  [CSAT], [Customer Satisfaction Score],
  [DAO], [Data Access Object],
  [DBMS], [Database Management System],
  [DLR], [Delivery Receipt (Telecommunication Messaging)],
  [DNS], [Domain Name System],
  [DTO], [Data Transfer Object],
  [ECE], [Electronics and Communication Engineering],
  [ERP], [Enterprise Resource Planning],
  [FTE], [Full-Time Equivalent (Workforce Measurement)],
  [HMAC], [Hash-based Message Authentication Code],
  [HRMS], [Human Resource Management System],
  [HSTU], [Hajee Mohammad Danesh Science and Technology University],
  [HTTP], [Hypertext Transfer Protocol],
  [HTTPS], [Hypertext Transfer Protocol Secure],
  [I/O], [Input / Output],
  [IETF], [Internet Engineering Task Force],
  [IP], [Internet Protocol],
  [IT], [Information Technology],
  [ITES], [Information Technology Enabled Services],
  [IVR], [Interactive Voice Response],
  [JSON], [JavaScript Object Notation],
  [JWT], [JSON Web Token],
  [MVC], [Model-View-Controller],
  [NoSQL], [Not Only SQL (Non-relational distributed database)],
  [ODM], [Object-Document Mapper],
  [ORM], [Object-Relational Mapper],
  [OWASP], [Open Web Application Security Project],
  [PR], [Pull Request (Version Control)],
  [QA], [Quality Assurance],
  [RDBMS], [Relational Database Management System],
  [RBAC], [Role-Based Access Control],
  [REST], [Representational State Transfer],
  [RFC], [Request for Comments (Internet Standard)],
  [SDK], [Software Development Kit],
  [SLA], [Service Level Agreement],
  [SMPP], [Short Message Peer-to-Peer Protocol],
  [SMS], [Short Message Service],
  [SOC], [Security Operations Center],
  [SQL], [Structured Query Language],
  [TCP], [Transmission Control Protocol],
  [TPS], [Transactions / Telegrams Per Second],
  [TTL], [Time To Live (Cache Expiration)],
  [URI], [Uniform Resource Identifier],
  [URL], [Uniform Resource Locator],
  [UUID], [Universally Unique Identifier],
  [V8], [Google Open-Source High-Performance JavaScript & WebAssembly Engine],
  [VCS], [Version Control System]
)

#pagebreak()

// ─────────────────────────────────────────────────────────────
// MAIN CHAPTERS (Arabic page numbering)
// ─────────────────────────────────────────────────────────────
#set page(numbering: "1", number-align: center)
#counter(page).update(1)
#set heading(numbering: "1.1")

#include "typst_chapters/ch01_introduction.typ"
#pagebreak()

#include "typst_chapters/ch02_organization_profile.typ"
#pagebreak()

#include "typst_chapters/ch03_technical_foundations.typ"
#pagebreak()

#include "typst_chapters/ch04_system_architecture.typ"
#pagebreak()

#include "typst_chapters/ch05_backend_implementation.typ"
#pagebreak()

#include "typst_chapters/ch06_testing_deployment.typ"
#pagebreak()

#include "typst_chapters/ch07_professional_experience.typ"
#pagebreak()

#include "typst_chapters/ch08_conclusion_future_work.typ"
#pagebreak()

// ─────────────────────────────────────────────────────────────
// BIBLIOGRAPHY
// ─────────────────────────────────────────────────────────────
#bibliography("references.bib", title: "References", style: "ieee")
