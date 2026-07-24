# Teaching Assistant — Interview Guide

> Sources: `TEACHING_ASSISTANT_CONTEXT.md`, `TEACHING_ASSISTANT_ACCOMPLISHMENTS.md`, `TEACHING_ASSISTANT_SYSTEM_DESIGN.md`, `METRICS.md`  
> Rule: Peer Teacher for ENGR/PHYS completed; CSCE 120 Go TA accepted but not started. No fake learning-outcome %.

# Project Summary

**Undergraduate Peer Teacher** at Texas A&M for **ENGR 102** (Python, Fall 2025, ~60 students, ~7 hrs/week) and **PHYS 216** (physics + some Python, Spring 2026, ~30 lab / ~60 lecture, ~10–11 hrs/week). **Accepted CSCE 120 TA** (Go, ~25 lab expected, up to 10 hrs/week) starting ~Aug 2026.

Work: in-class help, owned office hours, Discord/email, Canvas/Gradescope grading at **100+ submissions/week** (conservative), PHYS Jetson lab connectivity support, rubrics + criteria-based grading, mentoring via print-debug and dry-runs.

### Elevator pitch (30–60s)

> I’ve been an undergraduate Peer Teacher at A&M supporting intro engineering and physics courses. In ENGR 102 I helped about sixty students with Python—class time, Discord, and office hours I owned—and graded on Canvas and Gradescope. In PHYS 216 I took on most of the lecture grading, ran the second half of Jetson-based labs where students pulled CSV and video off Linux VMs, and again owned office hours. The through-line isn’t that I built a product—it’s that I got better at teaching people with totally different backgrounds, debugging with them instead of for them, and staying consistent under a hundred-plus submissions a week. I’ve accepted a CSCE 120 TA role in Go starting next month, so I’m not claiming that experience yet.

# My Role

| Level | Scope |
|-------|--------|
| **Confirmed** | ENGR Python mentoring; owned OH both courses; PHYS lecture grading lean; PHYS lab 2nd half; rubrics; criteria grading; PT coordination talks |
| **Shared** | ENGR in-class/grading with 3 PTs; PHYS lab 1st half with 2 PTs |
| **Upcoming** | CSCE 120 Go TA (accepted) |
| **Do not claim** | Course design; Jetson embedded ownership; grade lifts; completed Go TA |

# Technical Challenges

## Challenge 1 — Teaching across huge experience gaps

### Situation

Same ENGR Python section mixed lifelong coders and absolute beginners.

### Problem

One explanation style doesn’t stick; bad metaphors confuse.

### Solution

Diagnose background quickly; adapt depth and analogies; avoid forced pop-culture references.

### Tradeoffs

Slower per-student than a canned answer; higher teaching quality.

### Result

Core lesson of the role; qualitative only.

---

## Challenge 2 — Grading volume without burning out

### Situation

On the order of 100+ submissions/week while TAing ENGR or PHYS.

### Problem

Line-by-line grading and missing rubrics don’t scale; flaky PTs add load.

### Solution

Write rubrics when missing; grade key criteria; renegotiate PT splits verbally.

### Tradeoffs

Criteria grading can miss edge issues if rubric is thin.

### Result

Sustainable weekly cadence; exact hours saved unmeasured.

---

## Challenge 3 — PHYS Jetson lab unblocking

### Situation

Students capture lab data on Jetsons and must get `.csv`/`.mp4` onto laptops (Mac pain).

### Problem

Connectivity / Linux VM / copy failures block reports.

### Solution

Help with connection and Linux file transfer; practice improved speed.

### Tradeoffs

Looks “NVIDIA/Jetson” on a resume if oversold — real work was support ops.

### Result

Students unblocked; no systems design claim.

---

## Challenge 4 — Mentoring debugging skill, not answers

### Situation

Students stuck on syntax/logic after env setup.

### Problem

Fixing code for them doesn’t transfer.

### Solution

Teach print-debugging and dry-runs.

### Tradeoffs

Longer OH interactions initially.

### Result

Best concrete mentoring story for interviews.

# Debugging Stories

| Story | Punchline |
|-------|-----------|
| Print + dry-run mentoring | Teach the method, not the patch |
| Python install/packages | Env setup is the first bug |
| Jetson to Mac file copy | Connectivity debugging under lab time pressure |

# Architecture Decisions

(Process architecture)

1. Own OH as the deep-help tier  
2. LMS stack = Canvas + Gradescope (given)  
3. Rubric + criteria pipeline for throughput  
4. Async Discord/email as overflow  

# Lessons Learned

- Adaptivity beats a single teaching script  
- Metaphors fail across culture/experience — choose carefully  
- Process (rubrics, criteria) beats heroically absorbing others’ work  
- Be honest about upcoming roles (Go/CSCE)  

# Behavioral Stories

| Prompt | Angle |
|--------|--------|
| Mentorship | Print-debug / dry-run teaching |
| Conflict / teamwork | Irresponsible PTs to direct rebalance talk |
| Working under load | 100+ submissions/week + rubric process |
| Communication | Adjusting to beginner vs experienced students |
| Integrity | Not claiming CSCE/Go or Jetson systems yet |

# Potential Interview Questions

1. What’s the difference between Peer Teacher and TA in your case?  
2. Walk me through how you help a student who’s stuck.  
3. How did you grade 100+ submissions a week without being sloppy?  
4. Tell me about a time a teammate wasn’t pulling their weight.  
5. What did you actually do with the Jetsons?  
6. Why should we trust you know Python beyond ChatGPT?  
7. Are you a Go TA already?  
8. Did student grades improve because of you?  
9. What did you own vs share?  
10. How would you TA a course whose language you just learned?

**Red flags to avoid**

- “I built the Jetson lab system.”  
- “I improved average grades by X%.”  
- “I’ve been teaching Go in CSCE 120” (before start).  
- “I designed the course.”  
