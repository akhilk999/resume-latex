# Resume Optimization Workflow

This document defines the long-term system for maintaining, optimizing, and tailoring a technical resume. It is a career management workflow, not a one-time resume-writing guide.

## Philosophy

Treat the resume like a software project:

- **Single source of truth.** Shared content lives once and is reused across targets.
- **Separation of concerns.** Accomplishments are stored separately from resume variants. Variants select and emphasize; they do not rewrite history.
- **Composition over rewriting.** Generate targeted resumes by selecting relevant accomplishments rather than rewriting everything for each application.
- **Optimization criteria.** Optimize for truthfulness, measurable impact, and alignment with job requirements—never for invented claims.

The goal is a durable knowledge base that makes each future application faster and more accurate.

---

# Repository Architecture

```
resume/
│
├── main.tex
├── resume.cls
│
├── extraction_docs/
│   ├── konfhub.md
│   ├── csapoints.md
│   └── …
│
├── bullets/
│   ├── broadaxis.tex
│   ├── konfhub.tex
│   ├── robotics.tex
│   ├── csa.tex
│   ├── ta.tex
│   ├── securesimple.tex
│   └── foodono.tex
│
├── variants/
│   ├── master.tex
│   ├── backend.tex
│   ├── ai.tex
│   ├── robotics.tex
│   └── product.tex
│
├── sections/
│   ├── education.tex
│   ├── skills.tex
│   └── shared_components/
│
└── RESUME_WORKFLOW.md
```

## Folder purposes

| Path | Purpose |
|------|---------|
| `main.tex` | Shared document body. Defines overall structure; variants drive compilation. |
| `resume.cls` | Styling, layout, fonts, margins, and helper macros. |
| `extraction_docs/` | Detailed source documents for each experience and project. Full context to be parsed into accomplishments—not resume-ready text. |
| `bullets/` | Accomplishment bullet library. One file per experience or project. Source of selectable content for all variants. |
| `variants/` | Compilable entry points. Each file selects which bullets, sections, and emphases apply to a target role. |
| `sections/` | Structural resume sections (education, skills, experience headers, projects). Separates layout/headers from bullet content. |
| `sections/shared_components/` | Reusable section fragments and macros shared across variants. |
| `RESUME_WORKFLOW.md` | This workflow document—the operating manual for the system. |

**Design rule:** Capture raw detail in `extraction_docs/`. Distill into `bullets/`. Select and emphasize in `variants/`. Do not duplicate bullet text across variants.

---

# Master Accomplishment Database

Before writing resume bullets, every experience must go through an extraction process. Raw context is converted into structured accomplishments; bullets are derived from that database.

## Role of `extraction_docs/`

`extraction_docs/` holds the in-depth source material for each experience and project—architecture notes, ownership breakdowns, metrics, decisions, links, and supporting evidence. These documents are the input to parsing; they are not submitted as resume content.

Conventions:

- One primary markdown file per experience or project (e.g. `konfhub.md`, `csapoints.md`).
- Prefer thorough, structured notes over polish.
- Update the extraction doc when new facts, metrics, or decisions become available.
- Only promote verified claims into `bullets/` after extraction and tagging.

Never invent metrics. Prefer fewer strong, verifiable claims over padded numbers.

## Project Overview

For each experience, capture:

- What was built
- Why it was built
- Who used it
- Previous workflow / problem being solved

## Ownership

Clarify personal contribution:

- Features personally implemented
- Systems designed
- Technical decisions made
- Problems solved

Distinguish individual ownership from team outcomes. Credit collaboration accurately without erasing personal impact.

## Technical Architecture

Document the stack and systems involved:

- Frontend
- Backend
- APIs
- Databases
- Cloud
- Authentication
- Infrastructure
- AI/ML systems
- Integrations

## Engineering Complexity

Capture the hard parts of the work:

- Scalability
- Reliability
- Security
- Performance
- Automation
- Architecture decisions
- Tradeoffs

Complexity is evidence of engineering judgment. Record *why* a approach was chosen when it strengthens a later bullet or interview story.

## Metrics

Track measurable outcomes when they exist:

| Category | Examples |
|----------|----------|
| Users | Active users, adoption, retention |
| Scale | Requests, records, devices, throughput |
| APIs | Endpoints, latency, reliability |
| Databases | Size, query performance, consistency |
| Performance | Speedups, resource reductions |
| Time savings | Hours saved, cycle-time reductions |
| Awards | Competitions, recognition, rankings |
| Business impact | Revenue, cost, conversion, operational outcomes |

If a metric cannot be verified, omit it or state the qualitative outcome without a number.

---

# Experience Extraction Workflow

Recommended sequence for each role or project:

1. **Gather all project context.** Notes, demos, tickets, designs, stakeholder feedback—store the durable write-up in `extraction_docs/`.
2. **Analyze source code / repositories.** What was actually shipped; ownership signals in structure and commits.
3. **Analyze documentation.** READMEs, design docs, ADRs, runbooks, postmortems.
4. **Analyze Git history when available.** Contributions, timelines, refactors, incident responses.
5. **Extract accomplishments.** Parse `extraction_docs/` into structured entries covering overview, ownership, architecture, complexity, and metrics.
6. **Tag accomplishments.** Apply the tagging system so variants can select content.
7. **Convert accomplishments into resume bullets.** Write verified bullets into `bullets/` using the X-Y-Z formula and review checklist.

Resume bullets should be created **after** the extraction document and accomplishment database exist. Writing bullets first encourages shallow claims and missing metrics.

---

# Accomplishment Tagging System

Tags determine which bullets appear in each resume variant. An accomplishment may carry multiple tags.

## Software Engineering

- Backend
- Frontend
- Full Stack
- APIs
- Databases
- Cloud
- DevOps
- Security
- Testing

## AI Engineering

- LLMs
- Agents
- Prompt Engineering
- RAG
- Vector Databases
- Evaluation
- Automation

## Robotics

- C++
- Embedded Systems
- Sensors
- Controls
- Localization
- Motion Planning

## Product

- User Impact
- Requirements
- Stakeholders
- Business Value
- Operations

**Selection rule:** Variants filter by tag relevance and strength. Prefer the strongest matching bullets over filling space with weak matches.

---

# Resume Variants

Each variant is a targeted composition of the shared library.

## Master Resume

**Purpose:** Complete internal version.

- Contains all accomplishments
- Serves as inventory and reference
- Not necessarily submitted externally

Use the master resume to audit coverage, find gaps, and source bullets for targeted variants.

## Backend / Full Stack SWE

**Prioritize:**

- APIs
- Databases
- Cloud
- Architecture
- Scalability
- Automation

## AI / ML Engineer

**Prioritize:**

- LLM systems
- Agents
- Prompt engineering
- AI automation
- Model integration

## Robotics Engineer

**Prioritize:**

- C++
- Algorithms
- Sensors
- Autonomous systems
- Embedded engineering

## Product Management / Solutions Roles

**Prioritize:**

- Users
- Workflows
- Business impact
- Requirements
- Leadership

Variants change **emphasis and selection**, not underlying facts.

---

# Job Description Analysis Workflow

Resumes should be optimized against representative job descriptions—not rewritten from scratch for every posting.

1. Collect 5–10 representative job descriptions for the target role family.
2. Extract:
   - Technical keywords
   - Responsibilities
   - Preferred technologies
   - Repeated phrases
   - Desired impact
3. Compare against the accomplishment database.
4. Identify matching experiences.
5. Select the strongest bullets.
6. Adjust emphasis, not facts.

Job descriptions do not need to be currently open. Recurring internship and full-time roles usually share stable requirement patterns. Representative historical postings are sufficient for keyword and emphasis calibration.

---

# Resume Bullet Writing Rules

Use the **X-Y-Z** formula:

> Accomplished **X** as measured by **Y** by doing **Z**.

| Element | Meaning |
|---------|---------|
| X | Outcome or capability delivered |
| Y | Metric or evidence of impact (when available) |
| Z | Method, system, or technical approach |

## Rules

- Lead with impact.
- Include metrics when available.
- Mention technologies naturally inside the accomplishment.
- Avoid technology lists that read like skill dumps.
- Avoid vague verbs:
  - worked on
  - helped
  - assisted
  - contributed

## Prefer strong verbs

- Built
- Designed
- Developed
- Automated
- Reduced
- Improved
- Optimized
- Implemented

Every bullet should stand alone as a clear claim of ownership and result.

---

# Bullet Review Checklist

Every bullet should answer:

1. What did I accomplish?
2. Why did it matter?
3. How was it measured?
4. What engineering skills did it demonstrate?
5. Is it truthful?
6. Is it relevant to the target role?

If any answer is weak or missing, revise the bullet or demote it from the target variant (it may still belong in the master inventory).

---

# Updating Workflow

Whenever a new experience is added:

1. Add a detailed source document under `extraction_docs/` (context, links, artifacts, metrics).
2. Run accomplishment extraction (overview → ownership → architecture → complexity → metrics).
3. Add accomplishments to the bullet library under `bullets/`.
4. Tag accomplishments for variant selection.
5. Update relevant resume variants.
6. Review against target job descriptions for keyword and emphasis fit.

Treat this as a recurring pipeline, not a special event. Small updates after each project beat large rewrite sessions before applications.

---

# Long-Term Career System

This repository should become a career knowledge base containing:

- Detailed experience/project documents (`extraction_docs/`)
- Resume bullets (`bullets/`)
- Project documentation
- Interview stories
- Technical decisions
- Metrics
- Awards
- Links
- Portfolio information

**Outcome:** Future resume writing becomes selection and emphasis—not excavation. Interview prep reuses the same source of truth in `extraction_docs/`. Career narrative stays consistent across applications, portfolios, and conversations.

Maintain the system continuously. The resume is a generated view of a living accomplishment database.
