# KonfHub — Metrics

Never invent numbers. Prefer provenance.

- **Repo-confirmed:** counts from internship repo `akhilk999/konfhub-internship` (code/artifacts), recorded here and bounded by `KONFHUB_CONTEXT.md`.
- **Observed (internship):** from Akhil’s evaluation while iterating prompts/pipelines/Canva MCP during the unpaid internship — not checked into a formal metrics harness, but approved as claimable in `KONFHUB_CONTEXT.md`.

# Technical Metrics

## Code / delivery (repo-confirmed)

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Python source files | 18 | files | Repo / CONTEXT | |
| Approx. Python LOC | ~1,283 | lines | Repo / CONTEXT | Approximate |
| Markdown LOC (docs) | ~322 | lines | Repo / CONTEXT | |
| Git commits on `main` | 105 | commits | Repo / CONTEXT | Volume ≠ impact |
| Merged PRs | 8 | PRs | Repo / CONTEXT (PRs) | #1–#8 |
| Top-level project modules | 4 | packages | Repo / CONTEXT | llm-testing, strands-agent-testing, flask-testing, jira-form-testing |
| Repo activity window | 2025-06-19 → 2025-07-29 | dates | Repo / CONTEXT | Aligns with Jun–Jul 2025 internship |
| Custom model classes (final OOP) | 3 (+ abstract base) | classes | Repo / CONTEXT | |
| Agent classes | 2 | agents | Repo / CONTEXT | DescriptionAgent, PosterAgent |
| Custom Strands tools | 4 | tools | Repo / CONTEXT | |
| Built-in strands tools wired | 5 | tools | Repo / CONTEXT | |
| Flask API operations | 4 | HTTP ops | Repo / CONTEXT | GET/PUT/PATCH/DELETE |
| Jira API operations exercised | 5 | HTTP ops | Repo / CONTEXT | |
| Agent test scenarios | 5 | scenarios | Repo / CONTEXT | |
| Style parameters | 3 | styles | Repo / CONTEXT | professional, trendy, minimalistic |

## AI / artifacts (repo-confirmed)

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Models with recorded bake-off text outputs | 23 | models | Repo / CONTEXT | Same event prompt |
| Total PNG artifacts | 124 | images | Repo / CONTEXT | Includes references |
| LLM-pipeline posters | 98 | PNGs | Repo / CONTEXT | |
| — Gemini 2 Flash | 42 | PNGs | Repo / CONTEXT | |
| — SD 3.5 Large | 47 | PNGs | Repo / CONTEXT | |
| — Stable Image Core | 3 | PNGs | Repo / CONTEXT | |
| — Stable Image Ultra | 1 | PNGs | Repo / CONTEXT | |
| — Titan v1 | 1 | PNGs | Repo / CONTEXT | |
| — Canva reference folder | 4 | PNGs | Repo / CONTEXT | Committed references under `canvas/`; separate from observed 20+ Canva MCP designs |
| Agent-generated images | 14 | PNGs | Repo / CONTEXT | |
| Agent-generated posters | 12 | PNGs | Repo / CONTEXT | |
| Sliding window size | 10 | turns | Repo / CONTEXT | Conversation manager |
| Image-prompt length target | ≤200 | characters | Repo / CONTEXT | Final prompt constraint |
| Description maxTokens (direct) | 600 | tokens | Repo / CONTEXT | |
| Agent max_tokens | 4096 | tokens | Repo / CONTEXT | Description/Poster agents |

## Quality evaluation (observed — internship)

| Name | Value | Unit | Measurement method | Confidence | Source | Notes |
|------|-------|------|--------------------|------------|--------|-------|
| Content accuracy improvement | ~65 | % relative improvement | Iterative qualitative evaluation of generated descriptions/keywords while optimizing parameterized prompts and multi-turn prompt chaining | Observed | `KONFHUB_CONTEXT.md` (Akhil) | Claimable on resume; say “observed during internship eval,” not a published study |
| Formatting error rate (before → after) | ~25 → ~3 | % of outputs with formatting issues | Manual review of generated structured outputs during prompt iteration | Observed | `KONFHUB_CONTEXT.md` (Akhil) | Attribute to prompt/chaining optimization |
| Branded designs via Canva MCP | 20+ | designs | Count of designs produced during Canva MCP experimentation / integration work | Observed | `KONFHUB_CONTEXT.md` (Akhil) | Compatible with later de-scope of MCP as primary automated path due to Connect API AI limits |

# Business Metrics

| Name | Value | Unit | Measurement method | Confidence | Source | Notes |
|------|-------|------|--------------------|------------|--------|-------|
| Manual design time reduction | ~70 | % | Appears on current resume TeX | **Unconfirmed in CONTEXT** | resume TeX only | Do not promote until Akhil reconfirms observation method |

No adoption, conversion, revenue, or production organizer counts for this POC.

Company marketing site claims (e.g. 10,000+ events hosted annually) describe **KonfHub the product**, not this internship POC.

# Awards / Recognition

None recorded for this internship in available sources.

# Metrics To Avoid

| Claim | Why not claim |
|-------|----------------|
| **70%** manual design time reduction | Still **unconfirmed** in CONTEXT after this update — reconfirm before using |
| Production deployment into KonfHub event UX | Not evidenced; CONTEXT says POC intent only |
| User / organizer counts using this feature | Unknown / not shipped |
| Formal published BLEU / preference study / latency SLOs | Not in repo; observed % above are internship eval, not a paper |
| Commit count as impact | Supporting timeline evidence only |
| Ownership of KonfHub live AI features (networking, photo gallery, face check-in) | Separate product features; not this POC |
| Implying Canva MCP remained the **shipped primary** generator | Observed 20+ designs OK; production de-scope / Connect API limits still true |
