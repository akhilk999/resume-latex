# Career Knowledge Base

Design document for a long-term, engineering-style career management system.

This repository is not only a place to store a resume. It is the single system for documenting experiences, generating targeted resumes, preparing for interviews, analyzing job descriptions, and tracking career growth over time.

---

# Purpose

## Career management as software engineering

A career accumulates artifacts the same way a codebase accumulates features: experiences, decisions, metrics, skills, and stories. Without structure, those artifacts live in memory, scattered notes, and one-off resume edits that diverge and decay.

Treating career management like software engineering means:

- **Version control** for accomplishments, prompts, and interview material
- **Single source of truth** instead of copy-pasted variants
- **Modular composition** — resume bullets, interview stories, and portfolio write-ups derive from the same experience records
- **Pipelines** — extract → structure → select → generate, rather than rewrite from scratch for every application
- **Automation** where repetition is mechanical (variant generation, quality checks, keyword matching)

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

Intended long-term layout (target state). The current `resume/` tree is the working resume pipeline; directories below such as `experiences/`, `interviews/`, and `prompts/` are the designed expansion of this knowledge base.

```
career/   # or repository root as the system matures
│
├── docs/
│   ├── CAREER_KNOWLEDGE_BASE.md
│   ├── RESUME_WORKFLOW.md
│   ├── RESUME_STYLE_GUIDE.md
│   ├── JOB_DESCRIPTION_ANALYSIS.md
│   └── AUTOMATION_ROADMAP.md
│
├── resume/
│   ├── main.tex
│   ├── variants/
│   ├── bullets/
│   ├── sections/
│   └── templates/
│
├── experiences/
│   ├── broadaxis/
│   ├── konfhub/
│   ├── csa/
│   ├── robotics/
│   ├── teaching_assistant/
│   ├── securesimple/
│   └── foodono/
│
├── interviews/
│   ├── STAR_STORIES.md
│   ├── TECHNICAL_DECISIONS.md
│   ├── SYSTEM_DESIGN.md
│   └── BEHAVIORAL.md
│
├── job_descriptions/
│
├── prompts/
│
├── scripts/
│
└── portfolio/
```

## Directory purposes

### `docs/`

System design and operating manuals. Architecture, workflow, style rules, job-analysis process, and automation roadmap. Humans and agents read these before changing content or adding tooling.

### `resume/`

LaTeX resume generation pipeline: shared body, bullet banks, section headers, and role-targeted variants. Compiles PDFs; does not own the full narrative of each experience.

| Path | Purpose |
|------|---------|
| `main.tex` | Shared document body and section order hooks |
| `variants/` | Compilable entry points; each selects bullets and emphasis for a target |
| `bullets/` | Resume-ready bullet library distilled from experience docs |
| `sections/` | Headers and structural sections (education, skills, experience shells) |
| `templates/` | Reusable LaTeX fragments and future template variants |

### `experiences/`

Canonical documentation for each major role or project. One folder per experience. Rich context lives here; resume bullets and interview material are derived from it.

### `interviews/`

Cross-cutting interview preparation distilled from experiences: STAR stories, technical decision write-ups, system design talking points, and behavioral themes. Links back to experience folders for evidence.

### `job_descriptions/`

Stored and annotated job descriptions (or representative samples) used for keyword mining, variant recommendation, and gap analysis. Prefer structured notes over one-off sticky notes.

### `prompts/`

Version-controlled AI prompts for extraction, analysis, bullet generation, JD analysis, and interview-guide creation. Prompts are part of the system, not disposable chat history.

### `scripts/`

Automation: build variants, lint resume quality, match JDs to bullets, and (later) career analytics. See [AUTOMATION_ROADMAP.md](./AUTOMATION_ROADMAP.md).

### `portfolio/`

Long-form or public-facing write-ups derived from the same experience records. Keeps portfolio claims aligned with resume and interview material.

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

Use a consistent short-slug prefix within each folder (e.g. `BROADAXIS_`). Do not invent parallel bare names (`ACCOMPLISHMENTS.md`) once prefixes are established.

## File and folder roles

### `*_CONTEXT.md`

Project-specific instructions written **before** extraction prompts. Overview (what/why/who), personal ownership boundaries, constraints (team, timeline, tech), and hard rules (e.g. git history inaccurate, do not attribute Branding). Source of truth for ownership; every later prompt reads this file.

### `*_ACCOMPLISHMENTS.md`

Structured accomplishment database from `prompts/extract/extract_accomplishments.md`. Per accomplishment: What I Built, Technical Implementation, Engineering Challenge, Impact, Evidence, Tags. Primary input to bullets, metrics, and job matching. Not polished resume prose.

### `*_SYSTEM_DESIGN.md`

Interview-ready architecture from `prompts/document/create_system_design.md`: Overview, Architecture, Components, Data Flow, Database Design, APIs, Authentication/Security, Infrastructure, Automation, AI Systems, Engineering Decisions, Tradeoffs, Future Improvements. Only technically supported information.

### `*_INTERVIEW_GUIDE.md`

Spoken prep from `prompts/document/create_interview_guide.md`: Project Summary, My Role, Technical Challenges (Situation / Problem / Solution / Tradeoffs / Result), Debugging Stories, Architecture Decisions, Lessons Learned, Behavioral Stories, Potential Interview Questions.

### `*_BULLETS.md`

Resume bullet candidates from `prompts/resume/generate_bullet_bank.md`, grouped by target: Backend SWE, Full Stack SWE, AI/ML, Robotics, Product. Formula: Accomplished X as measured by Y by doing Z. Staging before LaTeX in `resume/bullets/`.

### `METRICS.md`

Measurable facts from `prompts/document/create_metrics.md`: Technical Metrics, Business Metrics, Awards / Recognition, Metrics To Avoid. Never invent numbers.

### `ARCHITECTURE/`

Diagrams, ADRs, schema sketches, sequence notes, and other technical artifacts too large for a single markdown file.

### `REFERENCES/`

Links to repos, PRs, tickets, docs, demos, and external evidence. Supports “evidence over memory.”

---

# Prompts Directory

Reusable AI prompts live under `prompts/` and are version-controlled with the knowledge base. Authoritative usage order: [prompts/README.md](../prompts/README.md).

```
prompts/
├── README.md
├── extract/
│   ├── analyze_project_context.md
│   ├── analyze_repository.md
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
└── maintenance/
    ├── add_new_experience.md
    └── update_career_timeline.md
```

## Why version-control prompts

- **Reproducibility** — the same extraction or bullet-generation process can be re-run months later
- **Improvement** — prompt fixes are reviewable diffs, not lost chat experiments
- **Shared conventions** — agents and humans follow the same instructions as the workflow docs
- **Auditability** — when a bullet looks wrong, you can see which prompt produced the draft

Prompts implement the workflows in [RESUME_WORKFLOW.md](./RESUME_WORKFLOW.md) and [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md); they do not replace those docs.

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
| [RESUME_WORKFLOW.md](./RESUME_WORKFLOW.md) | Extraction → accomplishment DB → bullets → variants |
| [RESUME_STYLE_GUIDE.md](./RESUME_STYLE_GUIDE.md) | Formatting and quality bar for resume text |
| [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md) | JD → keywords → matching → variant |
| [AUTOMATION_ROADMAP.md](./AUTOMATION_ROADMAP.md) | Scripts, checks, and analytics to build later |
| [prompts/README.md](../prompts/README.md) | Prompt library workflow and experience file checklist |
