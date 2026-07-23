# KonfHub — Metrics

Never invent numbers. Prefer provenance.

- **Repo-confirmed:** from `resume/extraction_docs/konfhub.md` (code/artifacts).
- **Observed (internship):** from Akhil’s evaluation while iterating prompts/pipelines/Canva MCP during the unpaid internship — not checked into a formal metrics harness, but approved as claimable in `KONFHUB_CONTEXT.md`.

# Technical Metrics

## Code / delivery (repo-confirmed)

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Python source files | 18 | files | Extraction §6 | |
| Approx. Python LOC | ~1,283 | lines | Extraction §6 | Approximate |
| Markdown LOC (docs) | ~322 | lines | Extraction §6 | |
| Git commits on `main` | 105 | commits | Extraction §6 | Volume ≠ impact |
| Merged PRs | 8 | PRs | Extraction Appendix B | #1–#8 |
| Top-level project modules | 4 | packages | Extraction | llm-testing, strands-agent-testing, flask-testing, jira-form-testing |
| Repo activity window | 2025-06-19 → 2025-07-29 | dates | Extraction | Aligns with Jun–Jul 2025 internship |
| Custom model classes (final OOP) | 3 (+ abstract base) | classes | Extraction §6 | |
| Agent classes | 2 | agents | Extraction | DescriptionAgent, PosterAgent |
| Custom Strands tools | 4 | tools | Extraction | |
| Built-in strands tools wired | 5 | tools | Extraction | |
| Flask API operations | 4 | HTTP ops | Extraction | GET/PUT/PATCH/DELETE |
| Jira API operations exercised | 5 | HTTP ops | Extraction | |
| Agent test scenarios | 5 | scenarios | Extraction | |
| Style parameters | 3 | styles | Extraction | professional, trendy, minimalistic |

## AI / artifacts (repo-confirmed)

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Models with recorded bake-off text outputs | 23 | models | Extraction §3 / §6 | Same event prompt |
| Total PNG artifacts | 124 | images | Extraction §6 | Includes references |
| LLM-pipeline posters | 98 | PNGs | Extraction §6 | |
| — Gemini 2 Flash | 42 | PNGs | Extraction §6 | |
| — SD 3.5 Large | 47 | PNGs | Extraction §6 | |
| — Stable Image Core | 3 | PNGs | Extraction §6 | |
| — Stable Image Ultra | 1 | PNGs | Extraction §6 | |
| — Titan v1 | 1 | PNGs | Extraction §6 | |
| — Canva reference folder | 4 | PNGs | Extraction §6 | Committed references under `canvas/`; separate from observed 20+ Canva MCP designs |
| Agent-generated images | 14 | PNGs | Extraction §6 | |
| Agent-generated posters | 12 | PNGs | Extraction §6 | |
| Sliding window size | 10 | turns | Extraction §3 | Conversation manager |
| Image-prompt length target | ≤200 | characters | Extraction §3 | Final prompt constraint |
| Description maxTokens (direct) | 600 | tokens | Extraction | |
| Agent max_tokens | 4096 | tokens | Extraction | Description/Poster agents |

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
