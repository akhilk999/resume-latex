# Job Description Analysis

How to analyze job descriptions so resume variants and bullet selection become data-driven instead of ad hoc.

Representative job descriptions are acceptable. Internship and full-time postings in the same category often repeat the same keywords, stacks, and responsibility patterns. Store samples under `job_descriptions/` and annotate them; you do not need every posting you ever apply to.

---

## Target categories

Track requirements separately for each category you actively pursue:

| Category | Folder | Typical focus |
|----------|--------|----------------|
| Backend SWE | `backend/` | Services, APIs, data, reliability, scale |
| Full Stack SWE | `full_stack/` | End-to-end features, UI + API, product delivery |
| AI Engineer | `ai/` | Models, data, eval, inference, ML systems |
| Robotics Engineer | `robotics/` | Perception, control, embedded/real-time, HW/SW |
| Product Management | `product/` | Outcomes, prioritization, users, cross-functional |
| Solutions Engineer | `solutions/` | Customer problems, demos, technical storytelling |
| Quant / Trading SWE | `quant/` | Low-latency/trading systems, market data, quant infra, Python/C++ on Linux |
| Forward Deployed | `forward_deployed/` | Embed with customers, ambiguity, outcome ownership, travel |
| Infra / Platform | `infra/` | IaC, K8s, cloud platforms, production infrastructure, reliability |

A single posting may blend categories (e.g. Full Stack + AI, or Quant + Infra). Record the primary category and any secondary tags.

**Resume variants:** Map Quant → `backend` (systems/Python), Forward Deployed → **`fdse`** (eng-forward stakeholder shipping; `product` for PM/solutions-shaped posts), Infra → `backend` with reliability/CI emphasis.

---

## What to track per category

For each category (and optionally per stored JD), maintain notes on:

### Common keywords

Role nouns and verbs that recur: *distributed systems, microservices, ownership, production, stakeholder, roadmap, SLAs, RAG, ROS, Go-to-market*, etc. These inform skills-section wording and bullet phrasing—without stuffing.

### Technologies

Languages, frameworks, infra, and tools named repeatedly. Map each to accomplishments you actually have; note gaps honestly.

### Responsibilities

What the role *does day to day*: design APIs, own on-call, partner with PMs, ship demos, evaluate models. Match bullets that prove you have done analogous work.

### Expected impact

How success is framed: latency, revenue, customer adoption, safety, reliability, shipping speed. Prefer bullets whose Y (metrics) align with that framing.

### Recurring requirements

Must-haves that appear across many JDs in the category (e.g. “production Python services,” “experience with LLM apps,” “comfortable with customer-facing technical discussions”). Use these as a checklist for variant readiness.

---

## Analysis workflow

```
Job Description
      ↓
Keyword Extraction
      ↓
Experience Matching
      ↓
Bullet Selection
      ↓
Resume Variant
```

### 1. Job Description

Paste or save the posting (or a representative sample). Note company, level, and category tags.

### 2. Keyword Extraction

Pull:

- Required vs preferred skills  
- Domain terms  
- Soft/ownership language that signals seniority  
- Impact language (scale, customers, metrics)

Cluster into: technologies, responsibilities, impact themes.

### 3. Experience Matching

Map clusters to `experiences/` records and tagged accomplishments:

- Strong match — direct evidence in accomplishments  
- Partial match — adjacent work; may need careful wording  
- Gap — do not fabricate; optionally note for learning roadmap  

### 4. Bullet Selection

From the shared bullet library, enable bullets that best cover strong matches. Order by JD relevance within each role. Disable off-target or redundant bullets to preserve one-page signal.

### 5. Resume Variant

Choose or adjust a variant:

| If JD is primarily… | Prefer variant |
|---------------------|----------------|
| Backend / services | Backend / Full Stack SWE |
| UI + API product engineering | Backend / Full Stack SWE (fullstack emphasis) |
| ML / LLM / data / AI platform | AI / ML |
| Robotics / embedded / autonomy | Robotics |
| PM or Solutions / customer technical | Product / Solutions |
| Quant / trading SWE or quant-dev | Backend (systems/Python; C++ from robotics only if honest) |
| Forward deployed / applied eng | Forward Deployed (`fdse`) |
| Infra / platform / cloud | Backend (reliability, CI/CD, ops emphasis) |

Compile, then spot-check against [RESUME_STYLE_GUIDE.md](./RESUME_STYLE_GUIDE.md) and missing-keyword notes.

---

## Lightweight JD note template

Use the canonical template:

[`job_descriptions/_templates/JD_ANALYSIS_TEMPLATE.md`](../job_descriptions/_templates/JD_ANALYSIS_TEMPLATE.md)

Copy it into a category folder (`backend/`, `full_stack/`, `ai/`, `robotics/`, `product/`, `solutions/`, `quant/`, `forward_deployed/`, `infra/`). See [`job_descriptions/README.md`](../job_descriptions/README.md).

---

## Principles for JD-driven resumes

- Match **truthful** experience; do not mirror JD language you cannot defend in interview.
- Keywords belong in real bullets and skills—not as a hidden dump.
- One strong matched story beats five shallow keyword hits.
- Reuse category-level notes so each new JD is incremental analysis, not a cold start.

See also: [RESUME_WORKFLOW.md](./RESUME_WORKFLOW.md), [job_descriptions/README.md](../job_descriptions/README.md), [AUTOMATION_ROADMAP.md](./AUTOMATION_ROADMAP.md), [prompts/README.md](../prompts/README.md) (`analyze_job_description.md`, `compare_resume_to_job.md`).
