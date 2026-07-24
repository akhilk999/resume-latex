# Resume Workflow

Operating manual for the resume optimization pipeline: document experiences once, extract accomplishments, generate bullet candidates, then compose role-targeted LaTeX variants.

**Canonical experience records:** `experiences/<name>/`  
**Prompt step order (source of truth for how to run agents):** [prompts/README.md](../prompts/README.md)  
**System architecture:** [CAREER_KNOWLEDGE_BASE.md](./CAREER_KNOWLEDGE_BASE.md)  
**Compile PDFs:** [resume/README.md](../resume/README.md)

This document explains the human pipeline and variant philosophy. It does not replace the prompts runbook.

---

## Source-of-truth layers

| Layer | Location | Role |
|-------|----------|------|
| Facts / ownership / metrics | `experiences/<name>/` | Career truth |
| Prompt procedure | `prompts/README.md` | How to extract and generate |
| Bullet candidates | `experiences/<name>/*_BULLETS.md` | Staging before LaTeX |
| PDF bullets | `resume/bullets/*.tex` | Derived surface (can drift — promote from bank) |
| Variants | `resume/variants/` | Selection + emphasis only |

Never invent metrics. Prefer fewer strong, verifiable claims.

---

## Extraction Phase

Before writing resume bullets, complete extraction for the experience. **Authoritative order and rules:** [prompts/README.md](../prompts/README.md).

Summary:

1. **Create the experience folder** and stub files under `experiences/<name>/`.
2. **Fill `*_CONTEXT.md`** (manual, interview, and/or document analysis) — ownership source of truth.
3. **Analyze evidence** that applies: repository and/or engineering documents (no repo does not block the pipeline).
4. **Extract accomplishments** → `*_ACCOMPLISHMENTS.md`.
5. **Supporting docs:** system design, metrics, interview guide.
6. **Generate bullet bank** → `*_BULLETS.md` (do not edit LaTeX yet).
7. **Promote** selected bullets into `resume/bullets/` and enable them in a variant.

Git history is supporting evidence only. Never assume commits represent ownership if CONTEXT says otherwise.

---

## Accomplishment Database

Structured store under `experiences/<name>/*_ACCOMPLISHMENTS.md` before bullets are polished for LaTeX.

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

Use `prompts/resume/generate_bullet_bank.md`. Group candidates under Backend SWE, Full Stack SWE, AI/ML, Robotics, and Product (match target roles; leave sections N/A when unsupported).

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

### Promoting to LaTeX

1. Copy/adapt candidates from `experiences/<name>/*_BULLETS.md` into `resume/bullets/<name>.tex`.
2. Wire flags in `resume/bullets/flags.tex` and section headers as needed.
3. Enable the experience in the target `resume/variants/*.tex`.

Do not treat `resume/bullets/*.tex` as the place to invent new facts — update CONTEXT/accomplishments/metrics first when claims change.

---

## Resume Variants

All variants draw from the **same** accomplishment database and bullet library. A variant is a **selection and emphasis** configuration, not a fork of content.

### Master Resume

Broadest truthful inventory of strong experiences and bullets. Reference for what exists; not always the best application-specific PDF.

### Backend / Full Stack SWE Resume

Emphasizes APIs, services, data stores, reliability, performance, and end-to-end feature delivery.

### AI / ML Resume

Emphasizes models, data pipelines, evaluation, inference, RAG/agents, or ML-adjacent product systems.

### Robotics Resume

Emphasizes perception, control, hardware/software integration, real-time constraints, and robotics stack experience.

### Product / Solutions Resume

Emphasizes customer outcomes, problem framing, cross-functional delivery, demos, and translating technical capability into value.

### How selection works

```
experiences/* (accomplishments + metrics + bullet bank)
        ↓
resume/bullets/*.tex (promoted candidates)
        ↓
Variant includes a subset (+ skills emphasis)
        ↓
Compiled PDF
```

Do not rewrite accomplishment history per variant. Change **which** bullets appear, **order**, and **skills section** emphasis—not the underlying facts.

For JD-driven selection, see [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md) and [`job_descriptions/`](../job_descriptions/).

---

## Pipeline summary

```
Context collection (manual | interview | documents)
        ↓
Evidence analysis (repository and/or documents)
        ↓
extract_accomplishments → *_ACCOMPLISHMENTS.md
        ↓
system design + metrics + interview guide
        ↓
generate_bullet_bank → *_BULLETS.md
        ↓
Promote to resume/bullets + variant selection (+ JD as needed)
        ↓
LaTeX compile → PDF
```

Document new work while it is fresh. Backfilling after months loses ownership nuance and metrics provenance.
