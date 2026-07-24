# Career Knowledge Base Prompt Library

## Purpose

This folder contains reusable AI prompts for maintaining the Career Knowledge Base.

The goal is to ensure every experience follows the same documentation pipeline.

The workflow is:

```
Experience
↓
Context Collection
  (manual | interview_project_context | analyze_documents)
↓
Evidence Analysis
  (analyze_repository and/or analyze_documents)
↓
Accomplishment Extraction
↓
System Documentation
↓
Metrics Extraction
↓
Interview Preparation
↓
Resume Bullet Generation
↓
Resume Variants
↓
Job Matching
```

Evidence is not only git. Use whatever exists for the experience:

| Source | Prompt | When to use |
|--------|--------|-------------|
| Owner memory / discussion | `extract/interview_project_context.md` | Sparse recall; need structured CONTEXT before extraction |
| Engineering documents | `extract/analyze_documents.md` | Reports, decks, design docs, notebooks, competition writeups |
| Software repository | `extract/analyze_repository.md` | Code, PRs, commits (supporting evidence only — CONTEXT owns ownership) |

Many experiences use **more than one** source (e.g. docs + interview, or repo + CONTEXT).

---

# Adding a New Experience Workflow

When adding a new internship, project, or leadership experience:

## Step 1: Create Experience Folder

Create:

```
experiences/<experience_name>/
```

Example:

```
experiences/broadaxis/
```

Create:

- `<NAME>_CONTEXT.md`
- `<NAME>_ACCOMPLISHMENTS.md`
- `<NAME>_SYSTEM_DESIGN.md`
- `<NAME>_INTERVIEW_GUIDE.md`
- `<NAME>_BULLETS.md`
- `METRICS.md`

---

## Step 2: Fill Out Context File

Before extraction, create:

```
<NAME>_CONTEXT.md
```

Include:

### Overview

- What was built
- Why it was built
- Who used it

### Personal Ownership

- Features personally built
- Areas owned
- Areas not worked on

### Constraints

- Team size
- Timeline
- Technologies
- Known inaccuracies

### Important Instructions

Examples:

- Git history is inaccurate
- Do not attribute Branding work
- Focus on Event and CRM ownership

This file provides project-specific instructions to every future analysis.

### Ways to build CONTEXT

Pick one primary path (combine if useful):

1. **Manual** — owner drafts CONTEXT directly  
2. **Interview** — run `extract/interview_project_context.md` (one question at a time; write CONTEXT only when done)  
3. **Documents** — run `extract/analyze_documents.md` on reports/decks/design docs to draft CONTEXT, then owner corrects ownership gaps  

`prompts/other/agent_interview.md` is a robotics-specific example of the interview style; prefer the templated `interview_project_context.md` for new experiences.

---

## Step 3: Run Extraction Prompts

Run in this order:

1. `analyze_project_context.md` — understand CONTEXT before extracting  
2. Evidence analysis (run all that apply):  
   - `analyze_repository.md` — if a code repo exists  
   - `analyze_documents.md` — if you still need structured pulls from docs, or did not use it in Step 2  
3. `extract_accomplishments.md`

Outputs:

```
<NAME>_ACCOMPLISHMENTS.md
```

Notes:

- If Step 2 already ran `analyze_documents.md` into CONTEXT, Step 3 document analysis is optional — do not duplicate; use CONTEXT as source of truth.  
- No repo does **not** block the pipeline: documents and/or interview are enough to proceed.  
- Git history is supporting evidence only. Never infer ownership from git alone.

---

## Step 4: Generate Supporting Documentation

Run:

```
create_system_design.md
```

Output:

```
<NAME>_SYSTEM_DESIGN.md
```

Run:

```
create_metrics.md
```

Output:

```
METRICS.md
```

Run:

```
create_interview_guide.md
```

Output:

```
<NAME>_INTERVIEW_GUIDE.md
```

For weak or course-only projects, still run these — they clarify what **not** to claim and keep the CKB honest before stronger experiences are added.

---

## Step 5: Generate Resume Material

Run:

```
generate_bullet_bank.md
```

Output:

```
<NAME>_BULLETS.md
```

Do not directly edit resume files yet.

Resume bullets should always originate from the bullet bank.

Bullet bank sections (`Backend SWE`, `Full Stack SWE`, `AI/ML`, `Robotics`, `Product`) match target roles. Leave sections empty or mark N/A when the experience does not support them — do not force-fit.

---

## Step 6: Resume Tailoring

For a specific job:

1. Add a JD note under [`job_descriptions/`](../job_descriptions/) (copy `_templates/JD_ANALYSIS_TEMPLATE.md` into a category folder).  
2. Run `analyze_job_description.md`.  
3. Run `compare_resume_to_job.md`.  
4. Select relevant bullets.  
5. Update resume variant.

Methodology: [docs/JOB_DESCRIPTION_ANALYSIS.md](../docs/JOB_DESCRIPTION_ANALYSIS.md). Cross-cutting interview distillations (later): [`interviews/`](../interviews/).

---

# Prompt Usage Rules

## Never:

- Generate resume bullets before extracting accomplishments.  
- Invent metrics.  
- Assume Git history represents ownership.  
- Delete technical details during extraction.  
- Skip document/interview sources just because there is no repo.

## Always:

- Preserve evidence.  
- Separate facts from assumptions.  
- Document engineering decisions.  
- Store outputs in the experience folder.  
- Prefer CONTEXT as ownership authority over git or marketing copy in docs.

---

# Output Philosophy

The Career Knowledge Base should become:

- Resume source of truth  
- Interview preparation system  
- Portfolio documentation  
- Technical growth record  

Resume PDFs are generated artifacts, not the source of truth.

Weak or non-production projects still belong in the CKB when analyzed honestly — they set a baseline and prevent overclaiming before stronger experiences are added.
