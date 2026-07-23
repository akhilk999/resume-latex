# Resume Workflow

Operating manual for the resume optimization pipeline: extract context, structure accomplishments, generate bullets, and compose role-targeted variants from a single source of truth.

This document describes the **intended** process. Implementation may currently live partly under `resume/` (e.g. `extraction_docs/`, `bullets/`, `variants/`); the long-term model is documented in [CAREER_KNOWLEDGE_BASE.md](./CAREER_KNOWLEDGE_BASE.md).

---

## Extraction Phase

Before writing resume bullets, complete extraction for the experience. Prompt order and rules: [prompts/README.md](../prompts/README.md).

### 1. Create / fill `*_CONTEXT.md`

Write Overview (what / why / who), Personal Ownership, Constraints, and Important Instructions. This file is the ownership source of truth for every later prompt. Do not skip it.

### 2. Analyze project context (`prompts/extract/analyze_project_context.md`)

Confirm product workflows, technical overview, and separate confirmed vs unknown vs assumptions needing verification.

### 3. Analyze repositories (`prompts/extract/analyze_repository.md`)

Identify services, languages, frameworks, infra, and integration points. Prefer README, architecture docs, and module boundaries over guessing from file names alone.

### 4. Review documentation

Read design docs, tickets, RFCs, runbooks, and demos. Documentation often contains metrics and decision rationale that never appear in casual recall.

### 5. Review Git history only when ownership is reliable

Use commits and PRs to confirm scope and timeline **when authorship maps clearly to your work**. Do not claim volume of commits as impact. Never assume Git history represents ownership if `*_CONTEXT.md` says otherwise.

### 6. Extract accomplishments (`prompts/extract/extract_accomplishments.md`)

Turn raw context into discrete records: What I Built, Technical Implementation, Engineering Challenge, Impact, Evidence, Tags. Prefer a complete accomplishment database over resume-ready prose.

### 7. Identify metrics (`prompts/document/create_metrics.md`)

Find numbers with provenance. Record Technical Metrics, Business Metrics, Awards / Recognition, and Metrics To Avoid in `METRICS.md`. Never invent numbers.

### 8. Tag accomplishments

Tag for targeting (Backend, Frontend, AI, Cloud, Database, Security, DevOps, Robotics, Product, Leadership). Tags drive variant selection and job matching later.

---

## Accomplishment Database

The accomplishment database is the structured store of what happened—typically under `experiences/<name>/` and/or staging docs—before bullets are polished for LaTeX.

Collect for each accomplishment:

| Field | What to capture |
|-------|-----------------|
| **Project overview** | Problem, product context, and scope of the work |
| **Ownership** | Solo, primary, shared, or supporting; what you decided vs executed |
| **Technical architecture** | Components, data flow, and notable design choices |
| **Engineering complexity** | Hard parts: scale, concurrency, reliability, ambiguity, constraints |
| **Metrics** | Defensible quantitative results and measurement method |
| **Business impact** | User, revenue, cost, risk, or operational effect |
| **Skills demonstrated** | Technologies and competencies shown *through* the work |

Accomplishments are reusable building blocks. Resume bullets, interview stories, and portfolio blurbs all read from this layer—they should not invent a separate narrative.

---

## Supporting documentation (after accomplishments)

Run in order (see [prompts/README.md](../prompts/README.md)):

1. `create_system_design.md` → `*_SYSTEM_DESIGN.md`
2. `create_metrics.md` → `METRICS.md`
3. `create_interview_guide.md` → `*_INTERVIEW_GUIDE.md`

Do not generate resume bullets before accomplishments exist.

---

## Bullet Generation

Use `prompts/resume/generate_bullet_bank.md`. Group candidates under Backend SWE, Full Stack SWE, AI/ML, Robotics, and Product.

### Formula

Prefer the impact formula:

> **Accomplished X as measured by Y by doing Z.**

- **X** — outcome or capability delivered  
- **Y** — metric or concrete evidence (when truthful)  
- **Z** — technical or process approach that makes the claim credible  

When a precise metric is unavailable, keep X and Z concrete; do not invent Y.

### Rules

1. **Prioritize impact** — lead with what changed for users, systems, or the business.
2. **Use metrics when truthful** — numbers must be backed by `METRICS.md` or equivalent evidence.
3. **Avoid vague descriptions** — “helped improve the platform” is not a bullet; state the change.
4. **Avoid technology lists** — tools support the story; they are not the story. Name tech only when it clarifies how Z worked.
5. **Highlight ownership** — make clear what you drove versus what the team did collectively.
6. **Do not invent metrics or exaggerate ownership.**

Style details (length, verbs, bolding, ATS) live in [RESUME_STYLE_GUIDE.md](./RESUME_STYLE_GUIDE.md).

---

## Resume Variants

All variants draw from the **same** accomplishment database and bullet library. A variant is a **selection and emphasis** configuration, not a fork of content.

### Master Resume

Broadest truthful inventory of strong experiences and bullets. Reference for what exists; not always the best application-specific PDF. Use to audit coverage and to copy selections into targeted variants.

### Backend / Full Stack SWE Resume

Emphasizes APIs, services, data stores, reliability, performance, and end-to-end feature delivery. Prefer bullets with system ownership, production impact, and backend/fullstack complexity. De-emphasize pure product or robotics-only work unless it strengthens the backend story.

### AI / ML Resume

Emphasizes models, data pipelines, evaluation, inference, RAG/agents, or ML-adjacent product systems. Prefer bullets with measurable model or pipeline outcomes and clear technical depth. Include supporting backend work when it shows productionization of ML.

### Robotics Resume

Emphasizes perception, control, hardware/software integration, real-time constraints, and robotics stack experience. Prefer domain-specific accomplishments; keep general SWE bullets only when they show transferable systems skill.

### Product / Solutions Resume

Emphasizes customer outcomes, problem framing, cross-functional delivery, demos, and translating technical capability into value. Prefer impact and stakeholder language; keep enough technical credibility for Solutions Engineer or technical PM-adjacent roles.

### How selection works

```
Accomplishment database
        ↓
Tagged / ranked bullets
        ↓
Variant includes a subset (+ skills emphasis)
        ↓
Compiled PDF
```

Do not rewrite accomplishment history per variant. Change **which** bullets appear, **order**, and **skills section** emphasis—not the underlying facts.

For JD-driven selection, see [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md).

---

## Pipeline summary

```
Experience folder + *_CONTEXT.md
        ↓
analyze_project_context → analyze_repository
        ↓
extract_accomplishments → *_ACCOMPLISHMENTS.md
        ↓
system design + metrics + interview guide
        ↓
generate_bullet_bank → *_BULLETS.md
        ↓
Variant selection (+ JD prompts as needed)
        ↓
LaTeX compile → PDF
```

Document new work while it is fresh. Backfilling after months loses ownership nuance and metrics provenance.
