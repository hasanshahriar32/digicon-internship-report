#!/usr/bin/env python3
"""
generate_extra_figures.py
Generates 9 new high-resolution (300 DPI) publication-quality diagrams
for the Internship Report to expand visual depth and reduce raw code verbosity.
"""

import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np

OUTPUT_DIR = os.path.join(os.path.dirname(__file__), "..", "figures")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Color Palette
DARK_BLUE = "#0C2C56"
PRIMARY_BLUE = "#184C78"
ACCENT_PURPLE = "#6019D1"
ACCENT_TEAL = "#00AEEF"
BG_LIGHT = "#F8F9FA"
BORDER_GRAY = "#DCE0E6"
TEXT_DARK = "#232230"
TEXT_MUTED = "#555555"
SUCCESS_GREEN = "#1B7837"
ACCENT_ORANGE = "#E66101"
ACCENT_RED = "#D95F02"

plt.rcParams['font.sans-serif'] = 'DejaVu Sans'
plt.rcParams['font.family'] = 'sans-serif'

# 1. Event Loop Architecture
def create_event_loop_figure():
    fig, ax = plt.subplots(figsize=(10, 7.5), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.96, "Node.js Libuv Asynchronous Event Loop Architecture", 
            ha='center', va='center', fontsize=14, fontweight='bold', color=DARK_BLUE)
    ax.text(0.5, 0.92, "Sequential Tick Phases, Microtask Interleaving & Libuv Thread Pool", 
            ha='center', va='center', fontsize=10, color=TEXT_MUTED)

    # Center circle: Event Loop Core
    circle = plt.Circle((0.5, 0.5), 0.28, fill=False, color=PRIMARY_BLUE, linestyle='--', linewidth=2.5, zorder=1)
    ax.add_patch(circle)

    # 6 Phases around the circle
    phases = [
        ("1. Timers", "setTimeout()\nsetInterval()", 0.5, 0.80, ACCENT_PURPLE),
        ("2. Pending I/O", "Deferred system\ncallbacks", 0.76, 0.65, PRIMARY_BLUE),
        ("3. Idle, Prepare", "Libuv internal\nroutines", 0.76, 0.35, PRIMARY_BLUE),
        ("4. Poll", "Retrieve new I/O;\nexecute callbacks", 0.5, 0.20, DARK_BLUE),
        ("5. Check", "setImmediate()\ncallbacks", 0.24, 0.35, PRIMARY_BLUE),
        ("6. Close Callbacks", "socket.on('close')\ncleanup", 0.24, 0.65, ACCENT_PURPLE),
    ]

    for title, desc, x, y, col in phases:
        rect = patches.FancyBboxPatch((x - 0.11, y - 0.055), 0.22, 0.11,
                                      boxstyle="round,pad=0.015,rounding_size=0.03",
                                      facecolor=col, edgecolor=DARK_BLUE, linewidth=1.5, zorder=3)
        ax.add_patch(rect)
        ax.text(x, y + 0.02, title, ha='center', va='center', fontsize=9.5, fontweight='bold', color='white', zorder=4)
        ax.text(x, y - 0.022, desc, ha='center', va='center', fontsize=7.5, color='#F0F4F8', zorder=4)

    # Microtask queue in center
    rect_center = patches.FancyBboxPatch((0.36, 0.44), 0.28, 0.12,
                                         boxstyle="round,pad=0.015,rounding_size=0.03",
                                         facecolor='#FFF3CD', edgecolor='#FFEBAA', linewidth=1.5, zorder=3)
    ax.add_patch(rect_center)
    ax.text(0.5, 0.52, "Microtask Queues", ha='center', va='center', fontsize=9.5, fontweight='bold', color='#856404', zorder=4)
    ax.text(0.5, 0.47, "process.nextTick() & Promises", ha='center', va='center', fontsize=8, fontweight='bold', color='#856404', zorder=4)
    ax.text(0.5, 0.43, "(Executed after EVERY phase transition)", ha='center', va='center', fontsize=7.2, style='italic', color='#856404', zorder=4)

    # Left: OS Kernel
    rect_os = patches.FancyBboxPatch((0.02, 0.38), 0.14, 0.24,
                                     boxstyle="round,pad=0.015,rounding_size=0.02",
                                     facecolor='#E2E3E5', edgecolor='#D6D8DB', linewidth=1.2, zorder=2)
    ax.add_patch(rect_os)
    ax.text(0.09, 0.56, "OS Kernel\nAsynchronous", ha='center', va='center', fontsize=8.5, fontweight='bold', color=TEXT_DARK)
    ax.text(0.09, 0.46, "• epoll (Linux)\n• kqueue (macOS)\n• Sockets I/O", ha='center', va='center', fontsize=7.5, color=TEXT_MUTED)

    # Right: Libuv Worker Threads
    rect_threads = patches.FancyBboxPatch((0.84, 0.38), 0.14, 0.24,
                                          boxstyle="round,pad=0.015,rounding_size=0.02",
                                          facecolor='#E2E3E5', edgecolor='#D6D8DB', linewidth=1.2, zorder=2)
    ax.add_patch(rect_threads)
    ax.text(0.91, 0.56, "Libuv Thread\nPool (Default: 4)", ha='center', va='center', fontsize=8.5, fontweight='bold', color=TEXT_DARK)
    ax.text(0.91, 0.46, "• File I/O (fs)\n• DNS lookup\n• Crypto hashing", ha='center', va='center', fontsize=7.5, color=TEXT_MUTED)

    # Connecting arrows
    ax.annotate("", xy=(0.20, 0.50), xytext=(0.16, 0.50), arrowprops=dict(arrowstyle="<->", color=PRIMARY_BLUE, lw=1.5))
    ax.annotate("", xy=(0.84, 0.50), xytext=(0.80, 0.50), arrowprops=dict(arrowstyle="<->", color=PRIMARY_BLUE, lw=1.5))

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "node_event_loop_flow.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated node_event_loop_flow.png")

# 2. Scrum Sprint Lifecycle
def create_scrum_sprint_figure():
    fig, ax = plt.subplots(figsize=(11, 4.2), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.94, "Digicon Technologies PLC — 2-Week Agile/Scrum Development & Code Review Lifecycle", 
            ha='center', va='center', fontsize=12, fontweight='bold', color=DARK_BLUE)

    steps = [
        ("1. Sprint Planning", "Backlog refinement\n& Story estimation"),
        ("2. Daily Scrum", "15-min blocker\nstand-up meetings"),
        ("3. Implementation", "Feature branch &\nclean architecture"),
        ("4. Automated CI", "Lint, Jest tests &\nDocker build check"),
        ("5. Code Review", "Senior Architect PR\nreview & approval"),
        ("6. Staging / Release", "UAT verification &\nproduction deploy")
    ]

    x_coords = np.linspace(0.08, 0.92, len(steps))
    y = 0.50
    w, h = 0.13, 0.32

    for i, (title, desc) in enumerate(steps):
        col = DARK_BLUE if i in [0, 5] else PRIMARY_BLUE if i in [1, 2] else ACCENT_PURPLE
        rect = patches.FancyBboxPatch((x_coords[i] - w/2, y - h/2), w, h,
                                      boxstyle="round,pad=0.015,rounding_size=0.03",
                                      facecolor=col, edgecolor='none')
        ax.add_patch(rect)
        ax.text(x_coords[i], y + 0.08, title, ha='center', va='center', fontsize=8.5, fontweight='bold', color='white')
        ax.text(x_coords[i], y - 0.04, desc, ha='center', va='center', fontsize=7.2, color='#E9F2FA')

        if i < len(steps) - 1:
            ax.annotate("", xy=(x_coords[i+1] - w/2 - 0.005, y), xytext=(x_coords[i] + w/2 + 0.005, y),
                        arrowprops=dict(arrowstyle="->", color=ACCENT_TEAL, lw=2.0))

    # Bottom feedback loop arrow
    ax.annotate("Sprint Retrospective & Continuous Process Improvement",
                xy=(x_coords[0], y - h/2 - 0.04), xytext=(x_coords[-1], y - h/2 - 0.04),
                ha='center', va='top', fontsize=8, fontweight='bold', color=TEXT_MUTED,
                arrowprops=dict(arrowstyle="->", color=ACCENT_ORANGE, lw=1.5, connectionstyle="arc3,rad=-0.15"))

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "scrum_sprint_lifecycle.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated scrum_sprint_lifecycle.png")

# 3. Redis Cache-Aside Flow
def create_redis_cache_aside_figure():
    fig, ax = plt.subplots(figsize=(10, 5.0), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.95, "Redis Cache-Aside Pattern with TTL & Invalidation Protocol", 
            ha='center', va='center', fontsize=12, fontweight='bold', color=DARK_BLUE)

    def draw_box(x, y, w, h, title, sub, color=PRIMARY_BLUE):
        r = patches.FancyBboxPatch((x - w/2, y - h/2), w, h, boxstyle="round,pad=0.015,rounding_size=0.03",
                                   facecolor=color, edgecolor='none')
        ax.add_patch(r)
        ax.text(x, y + 0.02, title, ha='center', va='center', fontsize=9, fontweight='bold', color='white')
        ax.text(x, y - 0.025, sub, ha='center', va='center', fontsize=7.5, color='#F0F4F8')

    draw_box(0.12, 0.65, 0.16, 0.16, "Client Request", "GET /api/v1/tickets/:id", DARK_BLUE)
    draw_box(0.40, 0.65, 0.18, 0.16, "NestJS Service", "Cache-Aside Interceptor", PRIMARY_BLUE)
    draw_box(0.72, 0.78, 0.20, 0.16, "Redis Cache", "In-Memory RAM (TTL: 300s)", SUCCESS_GREEN)
    draw_box(0.72, 0.42, 0.20, 0.16, "Primary Database", "PostgreSQL / MongoDB", ACCENT_ORANGE)

    # Arrows
    # 1. Client to Service
    ax.annotate("1. Query", xy=(0.31, 0.65), xytext=(0.20, 0.65),
                arrowprops=dict(arrowstyle="->", color=DARK_BLUE, lw=1.5), fontsize=7.5, va='bottom', ha='center')

    # 2. Service to Redis
    ax.annotate("2. Check Cache", xy=(0.62, 0.78), xytext=(0.49, 0.72),
                arrowprops=dict(arrowstyle="->", color=SUCCESS_GREEN, lw=1.5), fontsize=7.5, va='bottom', ha='center')

    # 3. Cache HIT
    ax.annotate("3a. Cache HIT\n(Return <10ms)", xy=(0.49, 0.68), xytext=(0.62, 0.74),
                arrowprops=dict(arrowstyle="->", color=SUCCESS_GREEN, lw=1.5, linestyle="--"),
                fontsize=7.2, va='bottom', ha='center', color=SUCCESS_GREEN, fontweight='bold')

    # 4. Cache MISS
    ax.annotate("3b. Cache MISS", xy=(0.62, 0.46), xytext=(0.49, 0.58),
                arrowprops=dict(arrowstyle="->", color=ACCENT_ORANGE, lw=1.5), fontsize=7.5, va='top', ha='center')

    # 5. Populate Cache
    ax.annotate("4. Populate Key with TTL", xy=(0.72, 0.70), xytext=(0.72, 0.50),
                arrowprops=dict(arrowstyle="->", color=PRIMARY_BLUE, lw=1.5, linestyle=":"),
                fontsize=7.2, va='center', ha='left', color=PRIMARY_BLUE)

    # 6. Response to client
    ax.annotate("5. Final Response Payload", xy=(0.12, 0.45), xytext=(0.40, 0.45),
                arrowprops=dict(arrowstyle="->", color=DARK_BLUE, lw=1.5), fontsize=7.5, va='bottom', ha='center')

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "redis_cache_aside_flow.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated redis_cache_aside_flow.png")

# 4. Controller-Service-Repository (CSR) Pattern
def create_crm_csr_figure():
    fig, ax = plt.subplots(figsize=(10.5, 4.5), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.93, "Controller-Service-Repository (CSR) Layered Backend Architecture", 
            ha='center', va='center', fontsize=12, fontweight='bold', color=DARK_BLUE)

    tiers = [
        ("HTTP Client", "Mobile / Web Agent\nWorkspace (React)", 0.10, DARK_BLUE),
        ("Controller Tier", "Route mapping, DTO\nvalidation pipes & Guards", 0.32, PRIMARY_BLUE),
        ("Service Tier", "Business logic, SLA\ncomputation, events", 0.58, ACCENT_PURPLE),
        ("Repository Tier", "Data abstraction,\nMongoose & Prisma ORM", 0.84, DARK_BLUE)
    ]

    for title, desc, x, col in tiers:
        rect = patches.FancyBboxPatch((x - 0.10, 0.32), 0.20, 0.42,
                                      boxstyle="round,pad=0.02,rounding_size=0.03",
                                      facecolor=col, edgecolor='none')
        ax.add_patch(rect)
        ax.text(x, 0.64, title, ha='center', va='center', fontsize=9.5, fontweight='bold', color='white')
        ax.text(x, 0.48, desc, ha='center', va='center', fontsize=8, color='#EDF3F9')

    # Arrows
    ax.annotate("HTTP Request\n(JSON Payload)", xy=(0.22, 0.56), xytext=(0.20, 0.56),
                arrowprops=dict(arrowstyle="->", color=DARK_BLUE, lw=1.8), fontsize=7.5, va='bottom', ha='center')
    ax.annotate("DTO Execution\n(Injected Service)", xy=(0.48, 0.56), xytext=(0.42, 0.56),
                arrowprops=dict(arrowstyle="->", color=PRIMARY_BLUE, lw=1.8), fontsize=7.5, va='bottom', ha='center')
    ax.annotate("Atomic Query\n(Transactions)", xy=(0.74, 0.56), xytext=(0.68, 0.56),
                arrowprops=dict(arrowstyle="->", color=ACCENT_PURPLE, lw=1.8), fontsize=7.5, va='bottom', ha='center')

    # Return arrows
    ax.annotate("Response DTO", xy=(0.10, 0.22), xytext=(0.84, 0.22),
                arrowprops=dict(arrowstyle="->", color=SUCCESS_GREEN, lw=1.8, linestyle="--"),
                fontsize=8, fontweight='bold', color=SUCCESS_GREEN, va='center', ha='center')

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "crm_csr_pattern.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated crm_csr_pattern.png")

# 5. Token Bucket Algorithm
def create_token_bucket_figure():
    fig, ax = plt.subplots(figsize=(10, 4.8), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.94, "Token Bucket Rate Limiting Architecture for SMS Dispatch", 
            ha='center', va='center', fontsize=12, fontweight='bold', color=DARK_BLUE)

    # 1. Token Generator
    r_gen = patches.FancyBboxPatch((0.05, 0.40), 0.20, 0.32, boxstyle="round,pad=0.02,rounding_size=0.03",
                                   facecolor=PRIMARY_BLUE, edgecolor='none')
    ax.add_patch(r_gen)
    ax.text(0.15, 0.62, "Token Generator", ha='center', va='center', fontsize=9.5, fontweight='bold', color='white')
    ax.text(0.15, 0.50, "Continuous Clock\nTicker: Refills at\nr = 1,500 tokens/sec", ha='center', va='center', fontsize=8, color='#EDF3F9')

    # Arrow to bucket
    ax.annotate("+1 Token", xy=(0.33, 0.56), xytext=(0.25, 0.56),
                arrowprops=dict(arrowstyle="->", color=PRIMARY_BLUE, lw=2.0), fontsize=8, va='bottom', ha='center')

    # 2. Token Bucket
    r_bkt = patches.FancyBboxPatch((0.33, 0.32), 0.22, 0.48, boxstyle="round,pad=0.02,rounding_size=0.03",
                                   facecolor='#FFF3CD', edgecolor='#856404', linewidth=1.5)
    ax.add_patch(r_bkt)
    ax.text(0.44, 0.72, "Token Bucket", ha='center', va='center', fontsize=10, fontweight='bold', color='#856404')
    ax.text(0.44, 0.62, "Capacity C = 1,500", ha='center', va='center', fontsize=8.5, fontweight='bold', color='#856404')
    ax.text(0.44, 0.48, "• Tokens accumulate up to C\n• Overflow tokens discarded\n• Stored in Redis in-memory", ha='center', va='center', fontsize=7.5, color='#856404')

    # Inbound SMS requests
    ax.annotate("Inbound SMS\nRequest (1 SMS)", xy=(0.44, 0.22), xytext=(0.44, 0.08),
                arrowprops=dict(arrowstyle="->", color=DARK_BLUE, lw=2.0), fontsize=8, va='center', ha='center', fontweight='bold')

    # Decision Diamond (represented as box for clean layout)
    r_dec = patches.FancyBboxPatch((0.63, 0.40), 0.16, 0.32, boxstyle="round,pad=0.02,rounding_size=0.03",
                                   facecolor=DARK_BLUE, edgecolor='none')
    ax.add_patch(r_dec)
    ax.text(0.71, 0.60, "Evaluate Tokens", ha='center', va='center', fontsize=9, fontweight='bold', color='white')
    ax.text(0.71, 0.48, "tokens >= 1 ?", ha='center', va='center', fontsize=9.5, fontweight='bold', color='#FFD700')

    ax.annotate("1 Token Taken", xy=(0.63, 0.56), xytext=(0.55, 0.56),
                arrowprops=dict(arrowstyle="->", color=DARK_BLUE, lw=2.0), fontsize=7.5, va='bottom', ha='center')

    # Branches
    # YES -> Telco
    ax.annotate("YES\n(Dispatched)", xy=(0.85, 0.68), xytext=(0.79, 0.68),
                arrowprops=dict(arrowstyle="->", color=SUCCESS_GREEN, lw=2.0), fontsize=7.5, va='bottom', ha='center')
    r_yes = patches.FancyBboxPatch((0.85, 0.58), 0.12, 0.20, boxstyle="round,pad=0.015,rounding_size=0.02",
                                   facecolor=SUCCESS_GREEN, edgecolor='none')
    ax.add_patch(r_yes)
    ax.text(0.91, 0.70, "Telecom Carrier", ha='center', va='center', fontsize=8, fontweight='bold', color='white')
    ax.text(0.91, 0.62, "200 OK Delivered", ha='center', va='center', fontsize=7, color='#EAF7ED')

    # NO -> 429
    ax.annotate("NO\n(Rate Limited)", xy=(0.85, 0.38), xytext=(0.79, 0.38),
                arrowprops=dict(arrowstyle="->", color=ACCENT_RED, lw=2.0), fontsize=7.5, va='top', ha='center')
    r_no = patches.FancyBboxPatch((0.85, 0.28), 0.12, 0.20, boxstyle="round,pad=0.015,rounding_size=0.02",
                                  facecolor=ACCENT_RED, edgecolor='none')
    ax.add_patch(r_no)
    ax.text(0.91, 0.40, "HTTP 429", ha='center', va='center', fontsize=8, fontweight='bold', color='white')
    ax.text(0.91, 0.32, "Queued / Rejected", ha='center', va='center', fontsize=7, color='#FDEDED')

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "token_bucket_algorithm.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated token_bucket_algorithm.png")

# 6. BullMQ Job Lifecycle
def create_bullmq_job_figure():
    fig, ax = plt.subplots(figsize=(10.5, 4.2), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.94, "BullMQ / Redis Distributed Job Lifecycle & Dead Letter Queue (DLQ)", 
            ha='center', va='center', fontsize=12, fontweight='bold', color=DARK_BLUE)

    states = [
        ("Waiting", "Job queued in Redis\nwaiting for worker", 0.12, PRIMARY_BLUE),
        ("Active", "Worker processing\nHTTP carrier payload", 0.38, DARK_BLUE),
        ("Completed", "Carrier acknowledged;\nDLR logged", 0.65, SUCCESS_GREEN),
        ("Dead Letter (DLQ)", "Exhausted 5 retries;\nOps alerted", 0.90, ACCENT_RED)
    ]

    for title, desc, x, col in states:
        r = patches.FancyBboxPatch((x - 0.09, 0.42), 0.18, 0.32, boxstyle="round,pad=0.015,rounding_size=0.03",
                                   facecolor=col, edgecolor='none')
        ax.add_patch(r)
        ax.text(x, 0.64, title, ha='center', va='center', fontsize=9, fontweight='bold', color='white')
        ax.text(x, 0.50, desc, ha='center', va='center', fontsize=7.2, color='#F0F4F8')

    # Transitions
    ax.annotate("Worker picks up", xy=(0.29, 0.58), xytext=(0.21, 0.58),
                arrowprops=dict(arrowstyle="->", color=DARK_BLUE, lw=1.8), fontsize=7.5, va='bottom', ha='center')
    ax.annotate("Success", xy=(0.56, 0.62), xytext=(0.47, 0.62),
                arrowprops=dict(arrowstyle="->", color=SUCCESS_GREEN, lw=1.8), fontsize=7.5, va='bottom', ha='center')

    # Delayed / Retry loop
    ax.annotate("Transient Failure (503/Timeout)\nExponential Backoff (2^n + jitter)",
                xy=(0.12, 0.38), xytext=(0.38, 0.38),
                arrowprops=dict(arrowstyle="->", color=ACCENT_ORANGE, lw=1.5, connectionstyle="arc3,rad=-0.2"),
                fontsize=7.2, va='top', ha='center', color=ACCENT_ORANGE, fontweight='bold')

    # Failure to DLQ
    ax.annotate("Retries Exhausted\n(attempt > 5)", xy=(0.81, 0.58), xytext=(0.47, 0.52),
                arrowprops=dict(arrowstyle="->", color=ACCENT_RED, lw=1.8, linestyle="--"),
                fontsize=7.2, va='bottom', ha='center', color=ACCENT_RED, fontweight='bold')

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "bullmq_job_lifecycle.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated bullmq_job_lifecycle.png")

# 7. Optimistic Concurrency Control Sequence
def create_optimistic_locking_figure():
    fig, ax = plt.subplots(figsize=(10, 5.2), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.95, "Optimistic Concurrency Control (OCC) Preventing Race Conditions", 
            ha='center', va='center', fontsize=12, fontweight='bold', color=DARK_BLUE)

    # Lifelines
    actors = [
        ("Supervisor A", 0.20, PRIMARY_BLUE),
        ("MongoDB Cluster", 0.50, DARK_BLUE),
        ("Supervisor B", 0.80, ACCENT_PURPLE)
    ]

    for title, x, col in actors:
        r = patches.FancyBboxPatch((x - 0.10, 0.82), 0.20, 0.08, boxstyle="round,pad=0.01,rounding_size=0.02",
                                   facecolor=col, edgecolor='none')
        ax.add_patch(r)
        ax.text(x, 0.86, title, ha='center', va='center', fontsize=9, fontweight='bold', color='white')
        ax.plot([x, x], [0.82, 0.10], color=BORDER_GRAY, linestyle='--', lw=1.5, zorder=1)

    def draw_msg(x1, x2, y, text, color=TEXT_DARK, style="-", res=False):
        ax.annotate("", xy=(x2, y), xytext=(x1, y),
                    arrowprops=dict(arrowstyle="->" if not res else "->", color=color, lw=1.4, linestyle=style))
        ax.text((x1 + x2)/2, y + 0.02, text, ha='center', va='bottom', fontsize=7.5, color=color, fontweight='bold')

    # Step 1: Both read Ticket v=1
    draw_msg(0.20, 0.50, 0.74, "1. Read Ticket #101", PRIMARY_BLUE)
    draw_msg(0.50, 0.20, 0.68, "Return { id: 101, version: 1 }", PRIMARY_BLUE, style="--")

    draw_msg(0.80, 0.50, 0.62, "2. Read Ticket #101", ACCENT_PURPLE)
    draw_msg(0.50, 0.80, 0.56, "Return { id: 101, version: 1 }", ACCENT_PURPLE, style="--")

    # Step 2: Sup A commits first
    draw_msg(0.20, 0.50, 0.46, "3. Update: Assign Agent A (WHERE version == 1)", SUCCESS_GREEN)
    draw_msg(0.50, 0.20, 0.40, "Success: version updated to 2", SUCCESS_GREEN, style="--")

    # Step 3: Sup B commits stale
    draw_msg(0.80, 0.50, 0.30, "4. Update: Assign Agent B (WHERE version == 1)", ACCENT_RED)
    draw_msg(0.50, 0.80, 0.22, "Conflict: 0 records updated! (version mismatch)", ACCENT_RED, style="--")

    # Annotation box
    r_ann = patches.FancyBboxPatch((0.25, 0.10), 0.50, 0.07, boxstyle="round,pad=0.01,rounding_size=0.02",
                                   facecolor='#FFF3CD', edgecolor='#856404', lw=1.0)
    ax.add_patch(r_ann)
    ax.text(0.50, 0.135, "Result: Silent overwrites prevented; Supervisor B notified via 409 Conflict",
            ha='center', va='center', fontsize=8, fontweight='bold', color='#856404')

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "optimistic_locking_sequence.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated optimistic_locking_sequence.png")

# 8. Software Test Pyramid
def create_test_pyramid_figure():
    fig, ax = plt.subplots(figsize=(9, 5.0), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.95, "Digicon Backend Quality Assurance Testing Pyramid", 
            ha='center', va='center', fontsize=12, fontweight='bold', color=DARK_BLUE)

    # Pyramid tiers (from top to bottom)
    # Tier 1: E2E (Top)
    p_top = patches.Polygon([[0.40, 0.65], [0.60, 0.65], [0.50, 0.85]], closed=True,
                            facecolor=ACCENT_RED, edgecolor='white', lw=2)
    ax.add_patch(p_top)
    ax.text(0.50, 0.72, "E2E & Stress\n(10%)", ha='center', va='center', fontsize=8, fontweight='bold', color='white')

    # Tier 2: Integration (Middle)
    p_mid = patches.Polygon([[0.30, 0.42], [0.70, 0.42], [0.60, 0.65], [0.40, 0.65]], closed=True,
                            facecolor=PRIMARY_BLUE, edgecolor='white', lw=2)
    ax.add_patch(p_mid)
    ax.text(0.50, 0.53, "API Integration Tests (20%)\nSupertest, Testcontainers", ha='center', va='center', fontsize=8.5, fontweight='bold', color='white')

    # Tier 3: Unit Tests (Base)
    p_base = patches.Polygon([[0.18, 0.15], [0.82, 0.15], [0.70, 0.42], [0.30, 0.42]], closed=True,
                             facecolor=DARK_BLUE, edgecolor='white', lw=2)
    ax.add_patch(p_base)
    ax.text(0.50, 0.28, "Unit Testing Suite (70%)\nJest, Isolated Service & Controller Mocks\n>85% Code Coverage Target", 
            ha='center', va='center', fontsize=9, fontweight='bold', color='white')

    # Callouts
    ax.text(0.72, 0.75, "← Autocannon & k6\n   (Concurrency load testing)", fontsize=8, color=TEXT_MUTED, va='center')
    ax.text(0.75, 0.53, "← Route & DB verification\n   (Stateless integration specs)", fontsize=8, color=TEXT_MUTED, va='center')
    ax.text(0.85, 0.28, "← Algorithm math, SLA timers\n   & HMAC signature verification", fontsize=8, color=TEXT_MUTED, va='center')

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "software_test_pyramid.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated software_test_pyramid.png")

# 9. Docker Multi-Stage Build
def create_docker_multistage_figure():
    fig, ax = plt.subplots(figsize=(12, 6.0), dpi=300)
    ax.set_facecolor(BG_LIGHT)
    fig.patch.set_facecolor('white')
    ax.axis('off')

    ax.text(0.5, 0.95, "Multi-Stage Docker Container Build Optimization (83.1% Size Reduction)", 
            ha='center', va='center', fontsize=13, fontweight='bold', color=DARK_BLUE)
    ax.text(0.5, 0.89, "Decoupling Development Toolchain from Lean, Production-Hardened Runtime Environment",
            ha='center', va='center', fontsize=9.5, color=TEXT_MUTED)

    # Stage 1: Build Image Box
    r1 = patches.FancyBboxPatch((0.04, 0.08), 0.30, 0.74, boxstyle="round,pad=0.015,rounding_size=0.03",
                                facecolor='#FDEDEC', edgecolor=ACCENT_RED, lw=1.8)
    ax.add_patch(r1)
    ax.text(0.19, 0.77, "Stage 1: Development Builder", ha='center', va='center', fontsize=11, fontweight='bold', color=ACCENT_RED)
    ax.text(0.19, 0.72, "Base Image: node:20-alpine (as builder)", ha='center', va='center', fontsize=8.5, fontstyle='italic', color=TEXT_DARK)
    
    # Divider line
    ax.plot([0.07, 0.31], [0.68, 0.68], color='#E6B0AA', lw=1.0)

    s1_text = (
        "• Full devDependencies installed\n"
        "• TypeScript Compiler (tsc) & type defs\n"
        "• NestJS CLI & source code maps\n"
        "• Uncompiled raw .ts source files\n"
        "• Build caches & temporary objects\n"
        "• Compilation: npm run build -> /dist"
    )
    ax.text(0.065, 0.49, s1_text, ha='left', va='center', fontsize=8.2, color=TEXT_DARK, linespacing=1.65)

    # Stage 1 Footer Badge
    r1_foot = patches.FancyBboxPatch((0.06, 0.12), 0.26, 0.10, boxstyle="round,pad=0.012,rounding_size=0.02",
                                    facecolor='#FADBD8', edgecolor=ACCENT_RED, lw=1.2)
    ax.add_patch(r1_foot)
    ax.text(0.19, 0.17, "Intermediate Image Footprint: ~840 MB\n(Full Build Tooling & devDeps)", 
            ha='center', va='center', fontsize=8.2, fontweight='bold', color=ACCENT_RED)

    # Middle Bridge: Extraction & Filtering
    # Transfer Box (Above)
    trans_badge = patches.FancyBboxPatch((0.39, 0.52), 0.22, 0.20, boxstyle="round,pad=0.012,rounding_size=0.02",
                                         facecolor='#EBF5FB', edgecolor=PRIMARY_BLUE, lw=1.6)
    ax.add_patch(trans_badge)
    ax.text(0.50, 0.67, "ARTIFACT EXTRACTION", ha='center', va='center', fontsize=8.2, fontweight='bold', color=DARK_BLUE)
    ax.text(0.50, 0.60, "COPY --from=builder\n/app/dist   --->   ./dist", ha='center', va='center', 
            fontsize=7.8, family='monospace', fontweight='bold', color=DARK_BLUE)
    ax.text(0.50, 0.54, "(Only Compiled JS Retained)", ha='center', va='center', fontsize=7.2, fontstyle='italic', color=PRIMARY_BLUE)

    # Arrow 1: Stage 1 -> Transfer Box
    ax.annotate("", xy=(0.385, 0.62), xytext=(0.345, 0.62),
                arrowprops=dict(arrowstyle="->", lw=2.2, color=DARK_BLUE))

    # Arrow 2: Transfer Box -> Stage 2
    ax.annotate("", xy=(0.655, 0.62), xytext=(0.615, 0.62),
                arrowprops=dict(arrowstyle="->", lw=2.2, color=DARK_BLUE))

    # Discard Badge (Below)
    discard_badge = patches.FancyBboxPatch((0.39, 0.12), 0.22, 0.31, boxstyle="round,pad=0.012,rounding_size=0.02",
                                           facecolor='#FFF9E6', edgecolor=ACCENT_ORANGE, linestyle='--', lw=1.5)
    ax.add_patch(discard_badge)
    ax.text(0.50, 0.38, "EXCLUDED FROM RELEASE", ha='center', va='center', fontsize=8.0, fontweight='bold', color=ACCENT_ORANGE)
    ax.plot([0.41, 0.59], [0.35, 0.35], color='#F5CBA7', lw=0.8)
    
    discard_text = (
        "✖ ~700 MB Tooling Bloat\n"
        "✖ TypeScript Compiler (tsc)\n"
        "✖ devDependencies Suite\n"
        "✖ Raw Source Files (.ts)\n"
        "✖ Build Cache & CLI Tools"
    )
    ax.text(0.50, 0.24, discard_text, ha='center', va='center', fontsize=7.5, color='#935116', linespacing=1.45)

    # Downward arrow: Transfer step discards non-dist bloat
    ax.annotate("", xy=(0.50, 0.445), xytext=(0.50, 0.505),
                arrowprops=dict(arrowstyle="->", lw=1.8, color=ACCENT_ORANGE, linestyle='--'))
    ax.text(0.515, 0.475, "Stripped", ha='left', va='center', fontsize=7.2, fontweight='bold', color=ACCENT_ORANGE)

    # Stage 2: Production Runner Box
    r2 = patches.FancyBboxPatch((0.66, 0.08), 0.30, 0.74, boxstyle="round,pad=0.015,rounding_size=0.03",
                                facecolor='#EAFAF1', edgecolor=SUCCESS_GREEN, lw=1.8)
    ax.add_patch(r2)
    ax.text(0.81, 0.77, "Stage 2: Production Runtime", ha='center', va='center', fontsize=11, fontweight='bold', color=SUCCESS_GREEN)
    ax.text(0.81, 0.72, "Base Image: node:20-alpine (clean release)", ha='center', va='center', fontsize=8.5, fontstyle='italic', color=TEXT_DARK)

    # Divider line
    ax.plot([0.69, 0.93], [0.68, 0.68], color='#A9DFBF', lw=1.0)

    s2_text = (
        "• Production deps only (npm ci --omit=dev)\n"
        "• Pre-compiled /dist JavaScript files\n"
        "• Hardened non-root user (USER node)\n"
        "• Drastically minimized CVE attack surface\n"
        "• Minimal OS & memory overhead\n"
        "• Fast deployment push/pull times"
    )
    ax.text(0.685, 0.49, s2_text, ha='left', va='center', fontsize=8.2, color=TEXT_DARK, linespacing=1.65)

    # Stage 2 Footer Badge
    r2_foot = patches.FancyBboxPatch((0.68, 0.12), 0.26, 0.10, boxstyle="round,pad=0.012,rounding_size=0.02",
                                    facecolor='#D5F5E3', edgecolor=SUCCESS_GREEN, lw=1.2)
    ax.add_patch(r2_foot)
    ax.text(0.81, 0.17, "Optimized Release Footprint: ~142 MB\n(83.1% Image Size Reduction)", 
            ha='center', va='center', fontsize=8.2, fontweight='bold', color=SUCCESS_GREEN)

    plt.tight_layout()
    fig.savefig(os.path.join(OUTPUT_DIR, "docker_multistage_build.png"), bbox_inches='tight')
    plt.close(fig)
    print("[+] Generated docker_multistage_build.png")

if __name__ == "__main__":
    create_event_loop_figure()
    create_scrum_sprint_figure()
    create_redis_cache_aside_figure()
    create_crm_csr_figure()
    create_token_bucket_figure()
    create_bullmq_job_figure()
    create_optimistic_locking_figure()
    create_test_pyramid_figure()
    create_docker_multistage_figure()
    print("[✓] All 9 new figures generated successfully.")
