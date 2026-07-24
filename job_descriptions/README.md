# Job Descriptions

Store and annotate job descriptions (or representative samples) for keyword mining, variant recommendation, and gap analysis.

**Methodology:** [docs/JOB_DESCRIPTION_ANALYSIS.md](../docs/JOB_DESCRIPTION_ANALYSIS.md)  
**Prompts:** [prompts/jobs/analyze_job_description.md](../prompts/jobs/analyze_job_description.md), [prompts/jobs/compare_resume_to_job.md](../prompts/jobs/compare_resume_to_job.md)  
**Template:** [_templates/JD_ANALYSIS_TEMPLATE.md](_templates/JD_ANALYSIS_TEMPLATE.md)

This is the **next active workflow step** after experience documentation.

---

## Layout

```
job_descriptions/
├── README.md
├── _templates/
│   └── JD_ANALYSIS_TEMPLATE.md
├── backend/
├── full_stack/
├── ai/
├── robotics/
├── product/
└── solutions/
```

Put each analysis note in the **primary** category folder. If a posting blends categories, pick one primary and tag secondary categories inside the note.

Suggested filename: `Company_Role_YYYY-MM.md` (or `Company_Role_sample.md` for evergreen representatives).

---

## How to add a JD

1. Copy `_templates/JD_ANALYSIS_TEMPLATE.md` into the right category folder; rename it.
2. Paste or link the posting; fill keywords, technologies, responsibilities, impact themes.
3. Map to `experiences/` (strong / partial / gap) — **do not fabricate matches**.
4. Optionally run the job prompts to refine matching and bullet selection.
5. Record recommended variant + bullets to enable in `resume/variants/`.

---

## Principles

- Representative samples are enough; you do not need every posting you apply to.
- Match **truthful** experience only.
- One strong matched story beats five shallow keyword hits.
- Reuse category-level patterns so each new JD is incremental.
