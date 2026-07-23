# Resume Style Guide

Formatting and quality bar for resume bullets and sections. Complements the pipeline in [RESUME_WORKFLOW.md](./RESUME_WORKFLOW.md).

Optimize for clarity, truthfulness, and scannability—by both humans and ATS.

---

## Bullet length

- Aim for **one tight line** on the compiled PDF at normal margins (roughly **~100–140 characters**, depending on template).
- Prefer cutting filler over wrapping to a second line.
- If a second line is unavoidable, it must still be one logical bullet—not two ideas jammed together.

**One-line requirement:** Default to a single visual line. Multi-line bullets are exceptions for rare, high-impact items that cannot be shortened without losing a truthful metric.

---

## Action verbs

- Start with a strong past-tense verb (or present for current roles, used consistently).
- Prefer verbs that imply ownership and outcome: *Built, Designed, Reduced, Increased, Led, Shipped, Automated, Migrated*.
- Avoid weak openers: *Helped, Worked on, Responsible for, Assisted with, Participated in*.

| Prefer | Avoid |
|--------|--------|
| Reduced p95 latency by 40% by … | Helped improve API performance |
| Designed and shipped checkout retry flow … | Worked on checkout features |
| Led migration of billing jobs to … | Responsible for billing migration |

---

## Technology formatting

- Name technologies **inline only when they clarify the how** of the accomplishment.
- Do not end bullets with comma-separated tech piles: `… using Python, Docker, AWS, Redis, PostgreSQL, Kubernetes.`
- Match casing used by the product or ecosystem (`PostgreSQL`, `PyTorch`, `TypeScript`).
- Keep the skills section as the inventory; bullets demonstrate application.

**Bad:** Implemented features using React, Node.js, Express, MongoDB, and AWS.  
**Good:** Shipped real-time order status API (Node.js, PostgreSQL) that cut support tickets 25%.

---

## Metric formatting

- Use specific numbers: `40%`, `12ms`, `$8k/mo`, `3 services`, `10k DAU`.
- Prefer ranges or approximations only when exact figures are unknown and labeled honestly (`~`, `about`)—and still defensible.
- Place the metric near the outcome (X/Y), not buried at the end as an afterthought.
- Never invent or inflate metrics. If unsure, omit and keep the qualitative impact concrete.

**Bad:** Significantly improved performance of the system.  
**Good:** Cut p95 search latency from 800ms to 220ms by adding indexed filters and cache.

---

## Hyperlink rules

- Link company, product, or project names when the destination strengthens credibility (live product, repo, case study).
- Prefer one clear link per entry header—not every keyword linked.
- Ensure URLs are stable and professional; remove dead links in quality checks.
- Do not rely on links for critical claims; ATS and print may strip them.

---

## Bolding rules

- Bold sparingly: role-critical technologies, standout metrics, or product names—if the template uses bold at all.
- Do not bold entire bullets or long phrases; scanning fails when everything is emphasized.
- Stay consistent across a variant (same rules for every experience).

---

## Ordering rules

Within a role or project:

1. Strongest impact / most relevant to the variant first  
2. Clearest ownership next  
3. Supporting or narrower bullets last  

Across the resume:

1. Most relevant and recent experience first (within chronological norms for the section)  
2. Projects that best match the target role above weaker or off-target projects  
3. Drop or demote items that dilute the narrative for that variant  

---

## Project vs experience decisions

| Prefer **Experience** when | Prefer **Projects** when |
|----------------------------|---------------------------|
| Paid role, internship, or formal title | Independent, academic, or side initiative |
| Ongoing employment relationship | Discrete scoped build with clear end state |
| Team and org context matters | Personal ownership story is the point |

Do not list the same work twice under Experience and Projects. Choose one home; reference the other only if needed in interview docs, not on the PDF.

---

## When to remove weaker experiences

Remove or omit from a variant when:

- The bullet set is thin and cannot be strengthened with truthful detail
- The work conflicts with the target narrative (e.g. pure product bullets crowding a systems-heavy backend resume)
- Space is needed for stronger, more recent, or better-matched accomplishments
- The entry forces the resume past one page without adding signal

Master may retain more entries; targeted variants should be ruthless about signal density.

---

## ATS considerations

- Use standard section headings: Education, Experience, Projects, Skills (or close equivalents).
- Prefer text-based LaTeX/PDF that extracts cleanly; avoid text in images.
- Include keywords **naturally** via real accomplishments and a clear skills section—not keyword stuffing.
- Spell out uncommon acronyms once if the JD uses the full phrase heavily.
- Consistent dates, locations, and title formatting reduce parser confusion.

---

## Good and bad practices

### Impact vs vagueness

| Bad | Good |
|-----|------|
| Improved the backend for better scalability | Scaled event ingestion to 5k msg/s by partitioning consumers and backpressure |
| Collaborated with team on AI features | Built evaluation harness for RAG answers; raised grounded accuracy 18% on golden set |

### Ownership

| Bad | Good |
|-----|------|
| Helped the team ship the robotics demo | Owned perception pipeline integration for demo day; stabilized detection under varying light |
| Participated in SecureSimple development | Implemented auth session hardening that blocked replay of stolen cookies in staging tests |

### Technology lists

| Bad | Good |
|-----|------|
| Used Python, FastAPI, Docker, AWS, CI/CD | Automated deploy pipeline for FastAPI service; cut release time from hours to minutes |

### Metrics honesty

| Bad | Good |
|-----|------|
| Increased engagement 10x overnight | Increased weekly active tutors 35% over 8 weeks after onboarding redesign |

---

## Checklist before shipping a PDF

- [ ] Bullets are one line when possible  
- [ ] Strong verbs; no “helped / worked on” openers  
- [ ] Metrics only where evidenced  
- [ ] No trailing tech laundry lists  
- [ ] Order matches variant target  
- [ ] No duplicate experience/project entries  
- [ ] Links live; formatting consistent  
- [ ] Skills and bullets tell the same story  
