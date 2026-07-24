# Career Knowledge Base

Design document for a long-term, engineering-style career management system.

This repository is not only a place to store a resume. It is the single system for documenting experiences, generating targeted resumes, preparing for interviews, analyzing job descriptions, and tracking career growth over time.

**Start here for agents/humans new to the repo:** [../README.md](../README.md)  
**How to run extraction prompts:** [../prompts/README.md](../prompts/README.md)

---

# Purpose

## Career management as software engineering

A career accumulates artifacts the same way a codebase accumulates features: experiences, decisions, metrics, skills, and stories. Without structure, those artifacts live in memory, scattered notes, and one-off resume edits that diverge and decay.

Treating career management like software engineering means:

- **Version control** for accomplishments, prompts, and interview material
- **Single source of truth** instead of copy-pasted variants
- **Modular composition** — resume bullets, interview stories, and portfolio write-ups derive from the same experience records
- **Pipelines** — extract → structure → select → generate, rather than rewrite from scratch for every application
- **Automation** where repetition is mechanical (variant generation, quality checks, keyword matching) — later QoL; see [AUTOMATION_ROADMAP.md](./AUTOMATION_ROADMAP.md)

The goal is a maintainable system that compounds: each new internship, project, or interview makes the next application faster and more accurate.

## Why a single source of truth

Manually maintaining multiple resumes creates drift:

- The same accomplishment is worded differently (or incorrectly) across files
- Metrics get outdated or inconsistently applied
- Weak bullets linger in one variant after being improved in another
- Interview prep and resume content stop agreeing

A single source of truth means experiences and accomplishments are documented once. Resumes, interview guides, and portfolio pages **select and emphasize** — they do not invent parallel histories.

## Why everything should derive from the same data

| Artifact | Derives from |
|----------|--------------|
| Resume bullets | Structured accomplishments + metrics |
| Resume variants | Bullet selection for a target role |
| STAR / behavioral stories | Same ownership, impact, and decisions |
| System design interview prep | Architecture notes from the experience |
| Portfolio write-ups | Project overview + technical depth |
| Job matching | Skills and tags on accomplishments |

When interview answers contradict the resume, credibility suffers. When portfolio posts invent new claims, truthfulness erodes. Shared underlying data keeps all career surfaces consistent.

---

# Repository Architecture

Current layout (repository root):

```
├── README.md                 # Repo entrypoint
├── docs/                     # System manuals
├── experiences/              # Canonical experience records (present)
├── prompts/                  # Versioned AI prompts (present)
├── resume/                   # LaTeX compile / variants (present)
├── job_descriptions/         # JD notes — next active workflow step
├── interviews/               # Cross-cutting interview distillations (scaffolded)
├── scripts/                  # Automation home (QoL later; README only for now)
└── portfolio/                # Future public write-ups (not created yet)
```

## Directory status

| Path | Status | Notes |
|------|--------|--------|
| `docs/` | Active | Architecture, workflow, style, JD method, automation roadmap |
| `experiences/` | Active | Source of truth for facts / ownership / metrics |
| `prompts/` | Active | Runbook: [prompts/README.md](../prompts/README.md) |
| `resume/` | Active | PDF generation; bullets are *derived* |
| `job_descriptions/` | Active scaffold | Next step: analyze JDs into notes |
| `interviews/` | Scaffolded | Populate after experiences + as JD targeting clarifies stories |
| `scripts/` | Placeholder | Implement later per AUTOMATION_ROADMAP |
| `portfolio/` | Not created | Optional later |

## Directory purposes

### `docs/`

System design and operating manuals. Architecture, workflow, style rules, job-analysis process, and automation roadmap. Humans and agents read these before changing content or adding tooling.

### `resume/`

LaTeX resume generation pipeline: shared body, bullet banks, section headers, and role-targeted variants. Compiles PDFs; does not own the full narrative of each experience. See [resume/README.md](../resume/README.md).

| Path | Purpose |
|------|---------|
| `main.tex` | Shared document body and section order hooks |
| `variants/` | Compilable entry points; each selects bullets and emphasis for a target |
| `bullets/` | Resume-ready bullet library distilled from experience docs |
| `sections/` | Headers and structural sections (education, skills, experience shells) |

### `experiences/`

Canonical documentation for each major role or project. One folder per experience. Rich context lives here; resume bullets and interview material are derived from it.

### `interviews/`

Cross-cutting interview preparation distilled from `experiences/*_INTERVIEW_GUIDE.md`: STAR stories, technical decisions, system design talking points, behavioral themes. Do not invent claims here.

### `job_descriptions/`

Stored and annotated job descriptions (or representative samples) for keyword mining, variant recommendation, and gap analysis. See [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md) and [`job_descriptions/README.md`](../job_descriptions/README.md).

### `prompts/`

Version-controlled AI prompts for extraction, analysis, bullet generation, JD analysis, and interview-guide creation. Prompts are part of the system, not disposable chat history.

### `scripts/`

Future automation: build variants, lint resume quality, match JDs to bullets, career analytics. Placeholder README only until QoL work begins. See [AUTOMATION_ROADMAP.md](./AUTOMATION_ROADMAP.md).

### `portfolio/`

Long-form or public-facing write-ups derived from the same experience records (future).

---

# Experience Documentation Model

Every major experience gets its own folder under `experiences/`. Required files and pipeline order are defined in [prompts/README.md](../prompts/README.md).

Example:

```
experiences/broadaxis/
├── BROADAXIS_CONTEXT.md
├── BROADAXIS_ACCOMPLISHMENTS.md
├── BROADAXIS_SYSTEM_DESIGN.md
├── BROADAXIS_INTERVIEW_GUIDE.md
├── BROADAXIS_BULLETS.md
├── METRICS.md
├── ARCHITECTURE/
└── REFERENCES/
```

Use a consistent short-slug prefix within each folder (e.g. `BROADAXIS_`).

## File and folder roles

### `*_CONTEXT.md`

Project-specific instructions written **before** extraction prompts. Overview (what/why/who), personal ownership boundaries, constraints (team, timeline, tech), and hard rules. **Source of truth for ownership**; every later prompt reads this file.

### `*_ACCOMPLISHMENTS.md`

Structured accomplishment database. Per accomplishment: What I Built, Technical Implementation, Engineering Challenge, Impact, Evidence, Tags. Not polished resume prose.

### `*_SYSTEM_DESIGN.md`

Interview-ready architecture. Only technically supported information.

### `*_INTERVIEW_GUIDE.md`

Spoken prep: Project Summary, My Role, Technical Challenges, Debugging Stories, Architecture Decisions, Lessons Learned, Behavioral Stories, Potential Interview Questions.

### `*_BULLETS.md`

Resume bullet **candidates** (staging). Promote into `resume/bullets/` for PDFs.

### `METRICS.md`

Technical Metrics, Business Metrics, Awards / Recognition, Metrics To Avoid. Never invent numbers.

### `ARCHITECTURE/` / `REFERENCES/`

Diagrams and evidence links.

---

# Prompts Directory

Authoritative usage order: [prompts/README.md](../prompts/README.md).

```
prompts/
├── README.md
├── extract/
│   ├── analyze_project_context.md
│   ├── analyze_repository.md
│   ├── analyze_documents.md
│   ├── interview_project_context.md
│   └── extract_accomplishments.md
├── document/
│   ├── create_system_design.md
│   ├── create_metrics.md
│   └── create_interview_guide.md
├── resume/
│   ├── generate_bullet_bank.md
│   └── tailor_resume_variant.md
├── jobs/
│   ├── analyze_job_description.md
│   └── compare_resume_to_job.md
├── maintenance/
│   ├── add_new_experience.md
│   └── update_career_timeline.md
└── other/
    └── agent_interview.md          # domain example; prefer interview_project_context.md
```

Prompts implement the workflows in [RESUME_WORKFLOW.md](./RESUME_WORKFLOW.md) and [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md); they do not replace those docs. **Step order lives in prompts/README.md.**

---

# Design Principles

1. **Single source of truth** — document each fact once; derive artifacts from it.
2. **Do not duplicate information** — variants select; they do not fork parallel content trees.
3. **Evidence over memory** — prefer repos, metrics files, and references over recollection.
4. **Truthfulness over exaggeration** — never invent ownership, impact, or numbers.
5. **Modular documentation** — experiences, bullets, interviews, and prompts are separate modules.
6. **Resume generation instead of manual editing** — prefer selection and compilation over one-off PDF edits.
7. **Preserve technical decisions** — capture *why*, not only *what*, for interview depth.
8. **Document accomplishments immediately** — write while context is fresh; backfill is lossy.
9. **Build career assets that compound over time** — each experience should leave reusable docs, bullets, and stories.

---

# Related documents

| Document | Focus |
|----------|--------|
| [RESUME_WORKFLOW.md](./RESUME_WORKFLOW.md) | Human pipeline: extract → bullets → variants |
| [RESUME_STYLE_GUIDE.md](./RESUME_STYLE_GUIDE.md) | Formatting and quality bar for resume text |
| [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md) | JD → keywords → matching → variant |
| [AUTOMATION_ROADMAP.md](./AUTOMATION_ROADMAP.md) | Scripts and analytics (later QoL) |
| [prompts/README.md](../prompts/README.md) | Prompt library workflow (runbook SoT) |
