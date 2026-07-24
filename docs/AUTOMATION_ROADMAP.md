# Automation Roadmap

Future tooling plan for the Career Knowledge Base. Nothing here is required to exist yet; this document prioritizes scripts and commands once the documentation and content model in [CAREER_KNOWLEDGE_BASE.md](./CAREER_KNOWLEDGE_BASE.md) are in place.

Intended home: [`scripts/`](../scripts/) (plus Makefile or CLI entry points as needed). That folder exists with a placeholder README only — **no automation implemented yet** (QoL later). Until then, compile via `resume/` and run pipelines via `prompts/`.

---

## Resume Generation

Automate compiling role-targeted PDFs from the shared LaTeX pipeline so variant selection is a command, not a manual checklist.

### Commands (target UX)

| Command | Behavior |
|---------|----------|
| **Generate Backend Resume** | Apply backend/fullstack bullet flags and skills emphasis; compile `backend.pdf` |
| **Generate AI Resume** | Apply AI/ML selection; compile `ai.pdf` |
| **Generate Robotics Resume** | Apply robotics selection; compile `robotics.pdf` |
| **Generate Product Resume** | Apply product/solutions selection; compile `product.pdf` |

Optional later:

- Generate Master Resume  
- Generate custom variant from a JD analysis artifact  
- Clean aux files / open PDF after build  

Today’s manual equivalent may already be `make` targets under `resume/`; automation should wrap the same single source of truth, not duplicate TeX.

---

## Job Matching

Assist the workflow in [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md).

### Commands (target UX)

| Command | Behavior |
|---------|----------|
| **Analyze Job Description** | Extract keywords, technologies, responsibilities, impact themes; emit a structured note |
| **Find Missing Keywords** | Diff JD keywords against skills section + enabled bullets for a chosen variant |
| **Recommend Resume Variant** | Score category fit; suggest backend / AI / robotics / product / quant / forward_deployed / infra (or blend) |
| **Suggest Relevant Bullets** | Rank accomplishment/bullet IDs by match strength for enabling in the variant |

Inputs: JD text or file under `job_descriptions/`. Outputs: markdown or JSON consumed by humans (and later by generators).

---

## Resume Quality Checks

Lint the bullet library and compiled structure before sending a PDF.

### Automations

| Check | Intent |
|-------|--------|
| **Detect bullets without metrics** | Flag bullets that claim impact but lack numbers (warning, not always error) |
| **Detect weak verbs** | Flag openers like *Helped*, *Worked on*, *Responsible for* |
| **Check bullet length** | Flag likely wrap / overly long bullets |
| **Check formatting consistency** | Dates, dashes, punctuation, bold patterns |
| **Validate hyperlinks** | HTTP(S) reachability or allowlisted offline check |
| **Ensure required sections exist** | Education, Experience/Projects, Skills present per variant |

Wire as `scripts/lint_resume.py` (or similar) and optionally as a pre-commit or CI job on documentation/TeX changes.

---

## Career Analytics

Longer-horizon features once `experiences/` and tags are populated.

### Potential features

| Feature | Value |
|---------|--------|
| **Track skills gained over time** | Timeline of skills/tags first evidenced by accomplishments |
| **Track technology exposure** | Heatmap or inventory of languages, infra, domains |
| **Track experience growth** | Ownership level, scope, and impact maturity across roles |
| **Identify resume gaps** | Category requirements (from JD corpus) not covered by any strong bullet |

Analytics should read structured data (tags, metrics, dates)—not scrape PDF text as the primary source.

---

## Suggested build order

1. **Generation wrappers** — reliable one-command variant PDFs  
2. **Quality lints** — catch weak verbs, length, dead links early  
3. **JD analyze + missing keywords** — speed up applications  
4. **Bullet recommendations** — connect matching to variant flags  
5. **Career analytics** — after experience folders and tags are consistent  

---

## Design constraints for automation

- Automations **select and report**; they do not invent accomplishments or metrics.
- Prefer reading `experiences/`, `bullets/`, and `job_descriptions/` over brittle PDF parsing.
- Keep prompts for LLM-assisted steps in `prompts/` (versioned); scripts orchestrate, prompts instruct.
- Fail loudly on missing evidence rather than silently padding resumes.

---

## Related documents

- [CAREER_KNOWLEDGE_BASE.md](./CAREER_KNOWLEDGE_BASE.md) — system architecture  
- [RESUME_WORKFLOW.md](./RESUME_WORKFLOW.md) — human pipeline these tools accelerate  
- [RESUME_STYLE_GUIDE.md](./RESUME_STYLE_GUIDE.md) — rules encoded by linters  
- [JOB_DESCRIPTION_ANALYSIS.md](./JOB_DESCRIPTION_ANALYSIS.md) — matching semantics  
