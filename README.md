# Career Knowledge Base

This repository is an engineering-style **career management system**, not only a place to keep a `.tex` resume.

Document each internship, project, and leadership role **once** under `experiences/`. From that record, derive:

- targeted resume variants (LaTeX → PDF)
- interview prep
- job-description matching
- (later) automation and portfolio write-ups

Truthfulness is the constraint: never invent metrics or ownership. PDFs and TeX bullets are **artifacts**; `experiences/` is the source of truth for facts.

---

## Quick links

| Need | Go here |
|------|---------|
| System architecture & principles | [docs/CAREER_KNOWLEDGE_BASE.md](docs/CAREER_KNOWLEDGE_BASE.md) |
| Human resume pipeline | [docs/RESUME_WORKFLOW.md](docs/RESUME_WORKFLOW.md) |
| Run extraction / AI prompts | [prompts/README.md](prompts/README.md) |
| Bullet style / ATS rules | [docs/RESUME_STYLE_GUIDE.md](docs/RESUME_STYLE_GUIDE.md) |
| Job description analysis | [docs/JOB_DESCRIPTION_ANALYSIS.md](docs/JOB_DESCRIPTION_ANALYSIS.md) · [job_descriptions/](job_descriptions/) |
| Experience records | [experiences/](experiences/) |
| Compile resume PDFs | [resume/README.md](resume/README.md) |
| Cross-cutting interview distillations | [interviews/](interviews/) |
| Automation (later QoL) | [docs/AUTOMATION_ROADMAP.md](docs/AUTOMATION_ROADMAP.md) · [scripts/](scripts/) |

---

## Workflow (short)

```
experiences/*_CONTEXT.md
        ↓
prompts (extract → document → bullet bank)
        ↓
experiences/*_BULLETS.md  →  promote →  resume/bullets/*.tex
        ↓
variants + (optional) job_descriptions/
        ↓
PDF
```

**Next focus:** fill [`job_descriptions/`](job_descriptions/) using the template, then use `prompts/jobs/*`. Populate [`interviews/`](interviews/) from experience interview guides as targeting clarifies. Implement [`scripts/`](scripts/) only when automation becomes worth it.
