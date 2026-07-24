# Teaching Assistant — System Design

> Process / tooling design for instructional support roles — **not** a product architecture.  
> Sources: `TEACHING_ASSISTANT_CONTEXT.md`, `TEACHING_ASSISTANT_ACCOMPLISHMENTS.md`.  
> SWE-relevant framing: mentoring workflows, grading pipeline, lab support path.

# Overview

Akhil served as an **Undergraduate Peer Teacher** for **ENGR 102** (Python, Fall 2025) and **PHYS 216** (physics + some Python, Spring 2026) at Texas A&M, and has an **accepted CSCE 120 TA** role (Go, starts ~Aug 2026).

The “system” is the weekly loop: **in-class help → lab (PHYS) → office hours → async Discord/email → grading on Canvas/Gradescope**.

# Architecture

```
Students
   │
   ├─► In-class / lab help (Peer Teacher on duty)
   ├─► Office hours (Akhil-owned blocks)
   ├─► Discord / email (/ Campuswire for CSCE — planned)
   │
   ▼
Assignment / quiz / lab / exam submissions
   │
   ▼
Canvas + Gradescope grading
   │  (rubrics when missing; criteria-focused review)
   ▼
Feedback / scores returned to students
```

PHYS lab branch:

```
Physics lab activity on NVIDIA Jetson table
   → Python (likely) data capture (camera → files)
   → Linux VM connectivity
   → copy .csv / .mp4 to student laptop (esp. Mac)
   → graphs / lab report
```

# Components

| Component | Role |
|-----------|------|
| In-class support | Live help on assignments/activities |
| Office hours | Owned weekly deep-help block |
| Async channels | Discord, email (Campuswire planned for CSCE) |
| Grading stack | Canvas + Gradescope |
| Dev environment | VS Code to reproduce student code |
| PHYS lab hardware | NVIDIA Jetson tables + Linux VM file workflows |
| Peer Teacher team | Shared coverage; uneven reliability → coordination |

# Data Flow

### Student help request

```
Stuck on code/lab → ask in class / OH / Discord/email
→ PT reproduces issue (VS Code / Jetson)
→ guide debug (prints, dry-run) or fix connectivity/files
→ student continues assignment
```

### Grading

```
Submission lands on Canvas/Gradescope
→ apply rubric (existing or Akhil-created)
→ check key criteria / critical lines
→ score + feedback
```

# Database Design

**N/A** (institutional LMS is opaque; Akhil did not design it).

# APIs

**N/A.**

# Authentication/Security

**N/A** beyond normal handling of student work on institutional Canvas/Gradescope accounts. No custom auth work claimed.

# Infrastructure

| Layer | Tools |
|-------|--------|
| LMS / grading | Canvas, Gradescope |
| Chat | Discord, email; Campuswire (CSCE planned) |
| Compute (student labs) | NVIDIA Jetson + Linux VM (PHYS) |
| Local | VS Code, Python installs on student machines |

# Automation

**Minimal.** Manual grading with process optimizations (rubrics, criteria checks). No custom autograder ownership claimed.

# AI Systems

**N/A.** Owner framing contrasts teaching real language knowledge vs AI-only coding.

# Engineering Decisions

1. **Own office hours** even when in-class/grading was shared — dedicated deep-help channel  
2. **Create rubrics** when faculty didn’t provide them — consistency + speed  
3. **Criteria-based grading** over full line-by-line reads — throughput at 100+ submissions/week  
4. **Teach debug process** (prints + dry-run) over only giving fixed code  
5. **Adapt explanations** to experience level and metaphor fit  
6. **Talk through PT load imbalance** rather than silently absorbing work  

# Tradeoffs

| Choice | Upside | Downside |
|--------|--------|----------|
| Criteria-focused grading | Faster, sustainable | Risk of missing subtle issues if criteria incomplete |
| Shared PT model | Coverage | Irresponsible peers create uneven load |
| Jetson lab design (course) | Real data capture | Connectivity/file-transfer support burden on PTs |
| Claiming Python now, Go later | Honest | Resume must not imply completed Go TA yet |

# Future Improvements

- After CSCE 120 starts: document Go lab patterns, actual hours, grading load  
- Optional: track personal grading turnaround time if useful for metrics  
- Keep Jetson claims soft unless deeper technical ownership appears  

# Ownership note

- **Akhil:** OH ownership, ENGR Python mentoring, PHYS lecture grading lean, PHYS lab second half, rubrics/process, PT coordination conversations  
- **Faculty:** curriculum, exams, overall course design  
- **Other PTs:** shared ENGR help/grading; PHYS lab first half  
