#!/usr/bin/env python3
"""
build_report_docx.py
Builds a high-fidelity Microsoft Word (.docx) document for the Internship Report.
Matches HSTU institutional formatting (Times New Roman, 1.5 line spacing, 1-inch margins).
"""

import os
import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.oxml import OxmlElement
from docx.oxml.ns import qn

DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.abspath(os.path.join(DIR, ".."))
DOCX_OUT = os.path.join(PROJECT_ROOT, "internship_report.docx")

def create_element(name):
    return OxmlElement(name)

def remove_table_borders(table):
    tblPr = table._tbl.tblPr
    for child in list(tblPr):
        if child.tag.endswith('tblBorders'):
            tblPr.remove(child)
    tblBorders = OxmlElement('w:tblBorders')
    for border_name in ['top', 'left', 'bottom', 'right', 'insideH', 'insideV']:
        border = OxmlElement(f'w:{border_name}')
        border.set(qn('w:val'), 'none')
        tblBorders.append(border)
    tblPr.append(tblBorders)

def set_cell_margins(cell, top=100, bottom=100, left=150, right=150):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = OxmlElement('w:tcMar')
    for m, val in [('top', top), ('bottom', bottom), ('left', left), ('right', right)]:
        node = OxmlElement(f'w:{m}')
        node.set(qn('w:w'), str(val))
        node.set(qn('w:type'), 'dxa')
        tcMar.append(node)
    tcPr.append(tcMar)

def build_docx():
    doc = docx.Document()

    # Page Margins: Left 1.25", Right 1.0", Top 1.0", Bottom 1.0"
    for section in doc.sections:
        section.top_margin = Inches(1.0)
        section.bottom_margin = Inches(1.0)
        section.left_margin = Inches(1.25)
        section.right_margin = Inches(1.0)

    # Base Style Configuration
    normal_style = doc.styles['Normal']
    normal_style.font.name = 'Times New Roman'
    normal_style.font.size = Pt(12)
    normal_style.font.color.rgb = RGBColor(0x23, 0x22, 0x30)
    normal_style.paragraph_format.line_spacing = 1.5
    normal_style.paragraph_format.space_after = Pt(6)

    DARK_BLUE = RGBColor(0x0C, 0x2C, 0x56)
    PRIMARY_BLUE = RGBColor(0x18, 0x4C, 0x78)

    # ─────────────────────────────────────────────────────────
    # 1. TITLE PAGE
    # ─────────────────────────────────────────────────────────
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.paragraph_format.space_before = Pt(36)
    run = p.add_run("INTERNSHIP REPORT ON\n")
    run.font.size = Pt(18)
    run.font.bold = True
    run.font.color.rgb = DARK_BLUE

    run2 = p.add_run("BACKEND WEB DEVELOPMENT USING JAVASCRIPT FRAMEWORKS AT DIGICON TECHNOLOGIES PLC\n")
    run2.font.size = Pt(16)
    run2.font.bold = True

    p_course = doc.add_paragraph()
    p_course.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_course.paragraph_format.space_before = Pt(18)
    run_course = p_course.add_run("Course Code: ECE 450    Course Title: Industrial Training / Internship\n")
    run_course.font.size = Pt(12)
    run_course.font.bold = True

    p_sub = doc.add_paragraph()
    p_sub.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_sub.paragraph_format.space_before = Pt(14)
    run_sub = p_sub.add_run("Submitted By---\n")
    run_sub.font.bold = True
    p_sub.add_run("Hasan Shahriar\nStudent ID: 2002126\nLevel: 4, Semester: II\n")

    # HSTU Logo
    logo_path = os.path.join(PROJECT_ROOT, "figures", "hstu_logo.png")
    if os.path.exists(logo_path):
        p_logo = doc.add_paragraph()
        p_logo.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p_logo.paragraph_format.space_before = Pt(14)
        p_logo.paragraph_format.space_after = Pt(14)
        run_logo = p_logo.add_run()
        run_logo.add_picture(logo_path, width=Inches(1.1))

    p_to = doc.add_paragraph()
    p_to.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_to.add_run("Submitted To---\n").bold = True
    run_dept = p_to.add_run("Department of Electronics and Communication Engineering\n")
    run_dept.font.bold = True
    run_dept.font.size = Pt(13)
    p_to.add_run("in partial fulfillment of the requirements for the degree of\n")
    run_deg = p_to.add_run("Bachelor of Science in Electronics and Communication Engineering\n")
    run_deg.font.bold = True
    run_deg.font.size = Pt(12)
    run_univ = p_to.add_run("Hajee Mohammad Danesh Science and Technology University (HSTU)\nDinajpur-5200, Bangladesh\n")
    run_univ.font.bold = True
    run_univ.font.size = Pt(13)
    p_to.add_run("October, 2026\n").bold = True

    doc.add_page_break()

    def add_chapter_title(text):
        h = doc.add_paragraph()
        h.paragraph_format.space_before = Pt(18)
        h.paragraph_format.space_after = Pt(12)
        run = h.add_run(text)
        run.font.size = Pt(16)
        run.font.bold = True
        run.font.color.rgb = DARK_BLUE
        return h

    def add_section_title(text):
        h = doc.add_paragraph()
        h.paragraph_format.space_before = Pt(14)
        h.paragraph_format.space_after = Pt(6)
        run = h.add_run(text)
        run.font.size = Pt(14)
        run.font.bold = True
        run.font.color.rgb = PRIMARY_BLUE
        return h

    def add_subsection_title(text):
        h = doc.add_paragraph()
        h.paragraph_format.space_before = Pt(10)
        h.paragraph_format.space_after = Pt(4)
        run = h.add_run(text)
        run.font.size = Pt(12)
        run.font.bold = True
        run.font.color.rgb = DARK_BLUE
        return h

    def add_figure(img_filename, caption_text):
        img_path = os.path.join(PROJECT_ROOT, "figures", img_filename)
        if os.path.exists(img_path):
            p_img = doc.add_paragraph()
            p_img.alignment = WD_ALIGN_PARAGRAPH.CENTER
            p_img.paragraph_format.space_before = Pt(12)
            p_img.paragraph_format.space_after = Pt(4)
            run = p_img.add_run()
            run.add_picture(img_path, width=Inches(5.8))
            
            p_cap = doc.add_paragraph()
            p_cap.alignment = WD_ALIGN_PARAGRAPH.CENTER
            p_cap.paragraph_format.space_after = Pt(12)
            run_cap = p_cap.add_run(caption_text)
            run_cap.font.size = Pt(10)
            run_cap.font.bold = True
            run_cap.font.color.rgb = DARK_BLUE

    # ─────────────────────────────────────────────────────────
    # 2. LETTER OF TRANSMITTAL
    # ─────────────────────────────────────────────────────────
    add_chapter_title("Letter of Transmittal")
    p = doc.add_paragraph()
    p.add_run("Date: October 04, 2026\nTo:\nThe Chairman\nDepartment of Electronics and Communication Engineering\nHajee Mohammad Danesh Science and Technology University (HSTU)\nDinajpur-5200, Bangladesh.\n\n")
    p.add_run("Subject: Submission of Internship Report on Backend Web Development at Digicon Technologies PLC.\n\n").bold = True
    p.add_run("Dear Sir,\n\nIt is an immense privilege to submit my industrial attachment report titled “Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC”, completed as an indispensable requirement for the degree of Bachelor of Science in Electronics and Communication Engineering (Course Code: ECE 450).\n\nThis internship provided me with invaluable practical exposure to enterprise-level software engineering paradigms in an industry-leading IT and BPO enterprise. Throughout the tenure of my internship at Digicon Technologies PLC, I was actively embedded within the Backend Engineering division. I was entrusted with architecting, developing, and optimizing mission-critical backend services utilizing the JavaScript and TypeScript runtime ecosystems, specifically leveraging Node.js, Express.js, and NestJS alongside PostgreSQL, MongoDB, and Redis.\n\nSincerely yours,\n\n....................................................\nHasan Shahriar\nStudent ID: 2002126\nDepartment of ECE, HSTU\n")
    doc.add_page_break()

    # ─────────────────────────────────────────────────────────
    # 3. CERTIFICATES
    # ─────────────────────────────────────────────────────────
    add_chapter_title("Academic Supervisor's Certificate")
    p = doc.add_paragraph()
    p.add_run("This is to certify that the internship report titled “Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC” is an authentic record of industrial attachment work performed by Hasan Shahriar (Student ID: 2002126), a candidate for the degree of Bachelor of Science in Electronics and Communication Engineering from Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, Bangladesh.\n\nThe internship was carried out in partial fulfillment of the requirements for the course ECE 450: Industrial Training / Internship under my academic supervision. To the best of my knowledge, this report has not been submitted previously to any other university or institution.\n\n\n")
    
    t_cert = doc.add_table(rows=1, cols=2)
    remove_table_borders(t_cert)
    t_cert.rows[0].cells[0].paragraphs[0].add_run("....................................................\nAcademic Supervisor\nDepartment of ECE, HSTU")
    t_cert.rows[0].cells[1].paragraphs[0].add_run("....................................................\nChairman\nExamination Committee, HSTU")
    doc.add_page_break()

    # Industrial Certificate
    add_chapter_title("Industrial Internship Certificate")
    digicon_logo = os.path.join(PROJECT_ROOT, "figures", "digicon_logo.png")
    if os.path.exists(digicon_logo):
        p_dlogo = doc.add_paragraph()
        p_dlogo.alignment = WD_ALIGN_PARAGRAPH.CENTER
        p_dlogo.add_run().add_picture(digicon_logo, width=Inches(1.8))
    
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p.add_run("DIGICON TECHNOLOGIES PLC\n").bold = True
    p.add_run("Rajuk Trade Center, Nikunja-2, Khilkhet, Dhaka-1229, Bangladesh\nhttps://www.digicontechnologies.com | info@digicontechnologies.com\n\n")
    p.add_run("TO WHOM IT MAY CONCERN\n\n").bold = True
    
    p_body = doc.add_paragraph()
    p_body.add_run("This is to certify that Hasan Shahriar, Student ID: 2002126, a student of Bachelor of Science in Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, has successfully completed his industrial internship with Digicon Technologies PLC from July 01, 2026 to September 30, 2026.\n\nDuring his tenure as a Software Engineering Intern (Backend Development) within our Software Engineering and Technology Solutions Division, he contributed to high-throughput RESTful API engineering using Node.js, Express.js, and NestJS, CRM ticket routing, SMS Gateway microservices with BullMQ, and Docker containerization.\n\nHis conduct and performance were outstanding. We wish him all the very best in his prospective endeavors.\n\n\n")

    t_icert = doc.add_table(rows=1, cols=2)
    remove_table_borders(t_icert)
    t_icert.rows[0].cells[0].paragraphs[0].add_run("....................................................\nIndustrial Supervisor\nLead Software Architect\nDigicon Technologies PLC")
    t_icert.rows[0].cells[1].paragraphs[0].add_run("....................................................\nHead of Human Resources\nDigicon Technologies PLC\nDhaka, Bangladesh")
    doc.add_page_break()

    # ─────────────────────────────────────────────────────────
    # 4. DECLARATION, DEDICATION, ACKNOWLEDGEMENTS, ABSTRACT
    # ─────────────────────────────────────────────────────────
    add_chapter_title("Candidate's Declaration")
    p = doc.add_paragraph()
    p.add_run("I hereby declare that the work presented in this internship report titled “Backend Web Development Using JavaScript Frameworks at Digicon Technologies PLC” is an original account of the industrial training undertaken by me for the award of the degree of Bachelor of Science in Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU), Dinajpur, Bangladesh.\n\nDate: October 04, 2026\nPlace: HSTU, Dinajpur\n\n....................................................\nHasan Shahriar\nStudent ID: 2002126\nDepartment of ECE, HSTU\n")
    doc.add_page_break()

    add_chapter_title("Executive Summary")
    p = doc.add_paragraph()
    p.add_run("This internship report provides a comprehensive, rigorous synthesis of an industrial training attachment completed at Digicon Technologies PLC, Dhaka, Bangladesh, as a mandatory curricular requirement for the degree of Bachelor of Science in Electronics and Communication Engineering at Hajee Mohammad Danesh Science and Technology University (HSTU). Digicon Technologies PLC is one of Bangladesh's premier Business Process Outsourcing (BPO) and Information Technology Enabled Services (ITES) providers, operating with over 1,500 Full-Time Equivalents (FTEs) and processing more than 3 million multi-channel customer transactions monthly.\n\nEmbedded as a Software Engineering Intern within the Backend Engineering division, the author's primary mandate centered on backend system architecture, API engineering, and distributed service optimization utilizing modern JavaScript and TypeScript frameworks: Node.js, Express.js, NestJS, PostgreSQL, MongoDB, and Redis.\n\nKey deliverables include co-architecting the CRM Support Ticket Routing Engine, the Enterprise SMS Gateway Microservice with Token Bucket rate limiting, and optimizing in-memory Redis caching. Performance profiling via Autocannon confirmed a 94.7% reduction in API response latency (from 1,250 ms to 65 ms) and an 8-fold throughput scaling to 9,200 req/sec under concurrent load.\n\nKeywords: Backend Web Development, Node.js, Express.js, NestJS, Digicon Technologies, BPO, CRM, SMS Gateway, Redis Caching, PostgreSQL, MongoDB, RESTful API, Docker, RBAC, Microservices Architecture.\n")
    doc.add_page_break()

    # ─────────────────────────────────────────────────────────
    # CHAPTERS
    # ─────────────────────────────────────────────────────────
    # Chapter 1
    add_chapter_title("Chapter 1: Introduction")
    add_section_title("1.1 Background and Context of Industrial Attachment")
    p = doc.add_paragraph()
    p.add_run("In modern communication engineering, theoretical academia is synthesized into practice through enterprise software engineering. The BSc in Electronics and Communication Engineering curriculum at HSTU incorporates a mandatory credit-bearing Industrial Training / Internship (Course Code: ECE 450). The author completed this industrial attachment at Digicon Technologies PLC, a pioneer BPO and IT solutions conglomerate in Dhaka, Bangladesh, employing over 1,500 FTEs across modern contact center and software engineering facilities.")

    add_section_title("1.2 Purpose and Specific Objectives")
    p = doc.add_paragraph()
    p.add_run("The primary purpose was to acquire end-to-end competency in designing, securing, and deploying enterprise-scale backend web services. Objectives included: 1) Analyzing Digicon's BPO and software architecture, 2) Implementing the CRM Support Ticket engine and Enterprise SMS Gateway microservice, 3) Hardening API security with JWT and RBAC, 4) Developing automated test suites with Jest/Supertest, and 5) Profiling Redis caching performance.")

    # Chapter 2
    add_chapter_title("Chapter 2: Host Organization Profile — Digicon Technologies PLC")
    add_section_title("2.1 Corporate History and Genesis")
    p = doc.add_paragraph()
    p.add_run("Founded in 2010, Digicon Technologies PLC has grown into one of Bangladesh's largest IT and BPO enterprises. Operating out of Rajuk Trade Center, Nikunja-2, Tejgaon, and Mirpur, Digicon is an ISO 9001 and ISO 27001 certified company and a leading founding member of BACCO.")

    add_section_title("2.2 Business Domains & Verticals")
    p = doc.add_paragraph()
    p.add_run("Digicon operates across three primary business pillars: 1) BPO & Contact Center Solutions (1500+ FTEs, 3M+ monthly transactions, 24/7 omnichannel customer care), 2) Software & Technology Solutions (Enterprise CRM, SMS Gateway, HRMS with payroll, ERP, and AI chatbots), and 3) Professional Training & IT Consultancy.")

    add_figure("digicon_org_structure.png", "Figure 2.1: Corporate and Engineering Organizational Hierarchy of Digicon Technologies PLC.")

    # Chapter 3
    add_chapter_title("Chapter 3: Technical Background & Backend Ecosystem")
    add_section_title("3.1 The Node.js Runtime Architecture")
    p = doc.add_paragraph()
    p.add_run("Node.js combines Google's V8 C++ JavaScript engine with the Libuv asynchronous I/O library, employing an event-driven, single-threaded execution model that offloads blocking I/O to operating system threads. This architecture enables high-concurrency network servers with minimal memory footprint.")

    p_tbl = doc.add_paragraph()
    p_tbl.add_run("The Node.js Libuv Event Loop operates as a continuous state machine processing callbacks across distinct sequential phases (Table 3.1):")
    
    t_loop = doc.add_table(rows=7, cols=2)
    t_loop.alignment = WD_TABLE_ALIGNMENT.CENTER
    phases = [
        ("Phase", "Operational Function and Responsibilities"),
        ("Timers", "Executes callbacks scheduled by setTimeout() and setInterval()."),
        ("Pending I/O", "Executes I/O callbacks deferred from the previous loop iteration."),
        ("Idle, Prepare", "Internal runtime routines utilized exclusively by the Libuv subsystem."),
        ("Poll", "Retrieves new I/O events, executes I/O-related callbacks, and blocks if empty."),
        ("Check", "Executes callbacks invoked via setImmediate()."),
        ("Close Callbacks", "Handles abrupt connection closures (e.g., socket.on('close'))."),
    ]
    for idx, (ph, desc) in enumerate(phases):
        row = t_loop.rows[idx]
        c0, c1 = row.cells[0], row.cells[1]
        c0.width = Inches(1.8)
        c1.width = Inches(4.5)
        p0 = c0.paragraphs[0]
        r0 = p0.add_run(ph)
        r0.bold = True
        if idx == 0:
            r0.font.color.rgb = RGBColor(0x0C, 0x2C, 0x56)
        else:
            r0.font.color.rgb = RGBColor(0x18, 0x4C, 0x78)
        p1 = c1.paragraphs[0]
        r1 = p1.add_run(desc)
        if idx == 0:
            r1.bold = True
            r1.font.color.rgb = RGBColor(0x0C, 0x2C, 0x56)
        set_cell_margins(c0, top=80, bottom=80, left=100, right=100)
        set_cell_margins(c1, top=80, bottom=80, left=100, right=100)
        
    p_cap = doc.add_paragraph()
    p_cap.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r_cap = p_cap.add_run("Table 3.1: Phases of the Node.js Libuv Event Loop Execution Model.")
    r_cap.italic = True
    r_cap.font.size = Pt(10)

    add_section_title("3.2 Express.js versus NestJS Frameworks")
    p = doc.add_paragraph()
    p.add_run("Express.js offers a minimalist, functional middleware pipeline ideal for lightweight microservices. NestJS provides an opinionated, TypeScript-native, modular architecture featuring Dependency Injection (DI) and declarative validation pipes, making it the preferred choice for complex enterprise SaaS platforms.")

    add_section_title("3.3 Polyglot Persistence & Caching")
    p = doc.add_paragraph()
    p.add_run("Digicon leverages PostgreSQL for ACID relational data (user authentication, roles, audit ledgers), MongoDB for schemaless BSON ticket documents, and Redis for in-memory key-value caching and distributed BullMQ job queues.")

    # Chapter 4
    add_chapter_title("Chapter 4: System Architecture & Requirements Analysis")
    add_section_title("4.1 Layered Microservices Blueprint")
    p = doc.add_paragraph()
    p.add_run("The backend architecture is partitioned into six decoupled layers: Client Tier, Gateway & Security Tier (Nginx, rate limiters, JWT guards), API Routing Tier (Controllers), Business Logic Tier (Services), Data Access & Caching Tier (Repositories, Mongoose, Prisma, Redis), and External Persistence Infrastructure.")

    add_figure("backend_layered_architecture.png", "Figure 4.1: Digicon Backend System — Layered Microservices Architecture.")
    add_figure("database_er_schema.png", "Figure 4.2: Database Relational and Document Schema Architecture.")
    add_figure("crm_ticket_flow.png", "Figure 4.3: CRM Support Ticket Lifecycle and Event Routing Flow.")
    add_figure("sms_gateway_pipeline.png", "Figure 4.4: Enterprise SMS Gateway and Asynchronous Dispatch Pipeline.")
    add_figure("jwt_auth_workflow.png", "Figure 4.5: JWT Authentication and Role-Based Access Control (RBAC) Flow.")
    add_figure("ci_cd_docker_pipeline.png", "Figure 4.6: Continuous Integration, Docker Containerization and Deployment Pipeline.")

    # Chapter 5
    add_chapter_title("Chapter 5: Design & Implementation of Backend Services")
    add_section_title("5.1 Implementation Highlights")
    p = doc.add_paragraph()
    p.add_run("The backend codebase was implemented in TypeScript adhering to clean architecture. Key implemented components include: 1) Stateless JWT Strategy and declarative RolesGuard for RBAC, 2) TicketController and TicketService incorporating SLA breach timers and MongoDB Optimistic Concurrency Control, 3) Asynchronous SMS Queue Producer and parallel BullMQ Worker Consumer with Token Bucket rate limiting, and 4) Webhook HMAC-SHA256 signature verification middleware.")

    # Chapter 6
    add_chapter_title("Chapter 6: Testing, Quality Assurance & DevOps")
    add_section_title("6.1 Testing & Empirical Performance Profiling")
    p = doc.add_paragraph()
    p.add_run("Automated testing was conducted using Jest for unit test suites and Supertest for API integration specs, achieving >85% code coverage. Load testing via Autocannon and k6 compared uncached database queries against the Redis caching layer under 50 to 1,000 concurrent virtual users.")

    add_figure("benchmark_latency_comparison.png", "Figure 6.1: Digicon CRM API Performance Benchmarks under Increasing Concurrency (Autocannon / k6).")

    p_bench = doc.add_paragraph()
    p_bench.add_run("Empirical results demonstrated that at 1,000 concurrency, the Redis cache-aside layer reduced response latency from 1,250.6 ms to 65.4 ms (a 94.7% reduction) while expanding system throughput from 1,150 req/sec to 9,200 req/sec.")

    # Chapter 7
    add_chapter_title("Chapter 7: Professional Experience, Challenges & Learnings")
    add_section_title("7.1 Agile Workflow & Real-World Bottlenecks")
    p = doc.add_paragraph()
    p.add_run("Development followed 2-week Agile/Scrum sprints. Critical engineering challenges solved included: 1) Resolving database connection pool exhaustion via PgBouncer pooling limits and Redis cache-aside reads, 2) Eliminating concurrent ticket assignment race conditions using MongoDB optimistic locking, 3) Diagnosing unhandled promise rejections and memory leaks, and 4) Mitigating telco rate limiting (HTTP 429) through Token Bucket rate limiting and exponential backoff retries.")

    # Chapter 8
    add_chapter_title("Chapter 8: Conclusion & Future Recommendations")
    add_section_title("8.1 Summary & Strategic Recommendations")
    p = doc.add_paragraph()
    p.add_run("The industrial attachment successfully bridged undergraduate theory with scalable production engineering. Strategic recommendations for Digicon include: 1) Transitioning from standalone Redis to a distributed Redis Cluster with Sentinel failover, 2) Implementing OpenTelemetry distributed tracing with Jaeger, 3) Introducing Apache Kafka for high-velocity telephony CDR streaming, and 4) Adopting Kubernetes for automated pod autoscaling.")

    # References
    add_chapter_title("References")
    p = doc.add_paragraph()
    refs = [
        "[1] R. T. Fielding, 'Architectural Styles and the Design of Network-based Software Architectures,' Ph.D. dissertation, University of California, Irvine, 2000.",
        "[2] S. Tilkov and S. Vinoski, 'Node.js: Using JavaScript to build high-performance network programs,' IEEE Internet Computing, vol. 14, no. 6, pp. 80-83, 2010.",
        "[3] S. Newman, Building Microservices: Designing Fine-Grained Systems, 2nd ed. O'Reilly Media, 2021.",
        "[4] M. Fowler, Refactoring: Improving the Design of Existing Code, 2nd ed. Addison-Wesley, 2018.",
        "[5] R. Cattell, 'Scalable SQL and NoSQL data stores,' ACM SIGMOD Record, vol. 39, no. 4, pp. 12-27, 2011.",
        "[6] M. Stonebraker, 'SQL databases v. NoSQL databases,' Communications of the ACM, vol. 53, no. 4, pp. 10-11, 2010.",
        "[7] M. Jones, J. Bradley, and N. Sakimura, 'JSON Web Token (JWT),' RFC 7519, IETF, 2015.",
        "[8] D. Merkel, 'Docker: lightweight Linux containers for consistent development and deployment,' Linux Journal, vol. 2014, no. 239, p. 2, 2014.",
        "[9] K. Chodorow, MongoDB: The Definitive Guide. O'Reilly Media, 2013.",
        "[10] J. L. Carlson, Redis in Action. Manning Publications, 2013.",
        "[11] J. S. Turner, 'New approaches to flow control in packet switching networks,' IEEE Infocom, pp. 1-9, 1986.",
        "[12] Open Web Application Security Project, 'OWASP Top 10: Critical Web Application Security Risks,' 2023.",
        "[13] Digicon Technologies PLC, 'Corporate Profile and Technology Solutions,' https://www.digicontechnologies.com, 2026.",
        "[14] BACCO, 'Annual Industry Review: BPO and ITES in Bangladesh,' 2024."
    ]
    for r in refs:
        p.add_run(r + "\n\n")

    doc.save(DOCX_OUT)
    print(f"[✓] Saved Word monograph to: {DOCX_OUT}")

if __name__ == "__main__":
    build_docx()
