# KonfHub — Interview Guide

> **Sources:** `KONFHUB_CONTEXT.md`, `KONFHUB_ACCOMPLISHMENTS.md`, `KONFHUB_SYSTEM_DESIGN.md`, `METRICS.md`
> **Rule:** Do not invent experiences or metrics. Label POC vs production clearly.

# Project Summary

**Company:** KonfHub — AI-powered event management / ticketing platform (event sites, registrations, check-in, attendee engagement).

**Your project:** Unpaid SWE intern (Remote, Jun–Jul 2025). Built a **backend POC** so organizers’ event details can drive automatic generation of description, SEO keywords, and a thematic poster — intended to run right after event details are entered on KonfHub.

**What you actually shipped in the internship repo:** Local Python POCs (direct Bedrock/Gemini pipeline + Strands multi-agent path), plus Flask and Jira learning modules — **not** a proven production feature in the live KonfHub UX.

### Elevator pitch (30–60s)

> At KonfHub I built a backend proof of concept for automatic event marketing assets. Given structured event details, a prompt-chained pipeline generates a description, SEO keywords, and a no-text thematic poster using Amazon Bedrock and Gemini image models. Iterating prompts improved content accuracy about 65% and cut formatting errors from roughly 25% to 3% in my evaluations. I also built a Strands multi-agent path, produced 20+ branded designs via Canva MCP during experimentation, and later de-emphasized MCP as the primary automated path after Connect API AI limits. The goal was that when someone creates an event on KonfHub, the poster would generate immediately from the details they just entered.

# My Role

| Level | Scope |
|-------|--------|
| **Confirmed** | Sole committer on `konfhub-internship`: LLM poster/description POC, OOP generation layer, bake-off, Guardrails, Strands agents + tools, eval harness, Flask Video API, Jira Forms client, Canva MCP research/de-scope |
| **Do not claim** | Production KonfHub platform features (ticketing, AI networking, photo gallery, etc.); **70%** time saved until reconfirmed; implying Canva MCP shipped as KonfHub’s primary production generator |
| **Label clearly** | Flask/Jira as learning/onboarding modules vs core AI POC |

# Technical Challenges

## Challenge 1 — Killing text and faces in generative posters

### Situation

Early “poster” prompts produced typography and people in images — bad for clean event branding.

### Problem

Generate thematic 16:9 visuals that stay on-brand without readable text or faces.

### Solution

- Reframed prompts as photographic scenes (photographer persona) instead of “make a poster”
- Negative prompts for text/faces/watermarks/artifacts; style variants; aspect constraints
- Switched among SD 3.5, Gemini Flash Img, Titan, etc., and explored a dedicated no-text poster agent path

### Tradeoffs

No-text imagery improves brand control but looks less like a classic headline poster; more prompt/model iteration cost.

### Result

Large qualitative corpus of constrained posters; constraint became an explicit product requirement in prompts/agents.

---

## Challenge 2 — Unifying heterogeneous model APIs

### Situation

Bedrock Converse, Bedrock `invoke_model` (base64 images), and Gemini multimodal responses all differ.

### Problem

Experiment across providers without rewriting the pipeline each time.

### Solution

`BaseModel` inheritance + `Generator` façade normalizing generate / extract / save; refactor from procedural scripts and split text/image generators (PRs #5, #7).

### Tradeoffs

Abstraction cost early (“OOP is painful”) vs long-term swapability; `NotImplementedError` for unsupported modalities.

### Result

Single pipeline able to run Nova Micro text + Gemini/SD image backends.

---

## Challenge 3 — Making agents reliable on the filesystem

### Situation

Multi-agent flow must read JSON, write outputs, pick next poster index, copy files, clean temp dirs.

### Problem

Relying only on `python_repl` was brittle for operational steps.

### Solution

Four custom Strands tools: `read_description_keywords`, `find_poster_index`, `copy_poster`, `confirm_file_exists`; filesystem as durable inter-agent contract; sliding window memory.

### Tradeoffs

More tool code to maintain vs higher reliability; agents less deterministic than pure scripts.

### Result

DescriptionAgent → PosterAgent pipeline with indexed artifacts and validation.

---

## Challenge 4 — Canva MCP designs vs primary-path de-scope

### Situation

Wanted design-tool integration for poster workflows via Canva MCP.

### Problem

Demonstrate useful Canva MCP output while deciding whether MCP should be the long-term primary generator.

### Solution

- Wired Strands MCPClient; produced **20+ branded designs** during internship Canva MCP experimentation (observed)
- Documented Canva Connect API AI-generation limits on the MCP path
- De-emphasized/removed MCP as the **primary** automated path; kept Bedrock/Gemini as the main POC generator

### Tradeoffs

Can claim real Canva MCP design volume from experimentation; should not imply MCP remained the shipped primary engine inside KonfHub.

### Result

20+ designs from Canva MCP work (observed) plus a clear story about API limits and path selection.

---

## Challenge 5 — Evaluating generative systems without formal metrics

### Situation

No BLEU/preference harness or latency SLOs in the internship timeline.

### Problem

Still need a way to iterate prompts/models and discuss quality in interviews.

### Solution

23-model text bake-off on one shared prompt; 5 diverse agent scenarios; 124 PNG artifact corpus; style-parameter sweeps.

### Tradeoffs

Strong qualitative signal; internship-observed ~65% accuracy and ~25%→~3% formatting improvements are claimable with provenance (see `METRICS.md`). Do not invent additional percentages. **70%** time saved still needs reconfirmation.

### Result

Evidence-backed engineering narrative without false precision.

# Debugging Stories

1. **Text/faces leaking into images** — fixed via prompt persona change, negatives, model switch (see Challenge 1).
2. **Guardrail intervened / max_tokens** — stop-reason handling; sometimes Guardrails left optional on agent path during testing.
3. **Agent file collisions / missing outputs** — `find_poster_index` + `confirm_file_exists` tools.
4. **Jira non-200 / payload shape** — rebuild payload from Advanced Form UI export; save `response.JSON`.
5. **Canva MCP experimentation then primary-path de-scope** — 20+ designs observed; Connect API AI limits informed not making MCP the final primary generator.

# Architecture Decisions

1. Prompt chaining (description → image prompt → image) over one-shot posters
2. OOP provider abstraction for Bedrock + Gemini
3. Nova Micro after 23-model bake-off
4. Dual-agent Strands design with JSON file handoff
5. Custom operational tools for agents
6. Canva MCP for 20+ experimental designs; de-emphasize as primary path after Connect API AI limits
7. Guardrails on direct text path
8. CLI POC first — productization later
9. Qualitative corpora instead of fake percentages
10. Separate Flask/Jira learning modules from AI core

# Lessons Learned

- Prompt iteration is first-class engineering for generative products
- Agents need operational tools (index/copy/confirm), not only “generate”
- Research third-party AI APIs for **real** capabilities before promising integrations
- Abstractions pay off once a second/third provider appears
- Honest POC scoping beats inflated production claims in interviews
- Unfinished TODOs (multimodal feedback) are fine to discuss as next quality loops

# Behavioral Stories

### Unpaid internship ownership

- Owned the POC end-to-end as sole committer over ~6 weeks and 8 PRs
- Balanced learning (Flask/Jira) with deep AI systems work

### Saying no to a shiny integration

- Canva MCP produced 20+ designs in experimentation; Connect API limits still drove de-emphasizing it as the primary automated path — judgment story

### Working with observed eval metrics

- Defend ~65% accuracy and ~25%→~3% formatting as internship qualitative eval while iterating prompts — not a published A/B study
- Canva MCP: 20+ designs from experimentation; separate that from “shipped primary path”

### Product empathy

- Framed work around organizer pain: after entering event details, they still manually make posters — POC targets that moment

# Potential Interview Questions

### AI / ML

- Walk through the prompt chain end to end. Why not one-shot?
- How did you choose Nova Micro? What would change your mind?
- How do you evaluate image generators without a preference model?
- How do Guardrails interact with agent stop reasons?
- Design the production service that runs after “Create event” in KonfHub.

### Agents

- When do you write custom tools vs using a REPL?
- How does filesystem state compare to a shared database/queue?
- Sliding window of 10 — what breaks as workflows get longer?

### Backend

- How would you wrap this CLI POC in an authenticated API with async jobs?
- Compare Flask learning API semantics to a real generation service API.
- How did you handle secrets and multi-cloud credentials?

### Product / behavioral

- What did you *not* ship?
- Why was Canva MCP de-emphasized as the primary path if you still produced 20+ designs?
- How do you talk about ~65% accuracy / formatting-error improvements without overselling a formal study?
- Unpaid internship — how did you prioritize?

# Do Not Claim

- Production launch of AI posters inside KonfHub
- **70%** time saved until reconfirmed in CONTEXT
- Implying Canva MCP remained the shipped **primary** KonfHub generator (20+ experimental designs are OK)
- Ownership of KonfHub’s live AI networking / photo gallery / face check-in
- Formal published online metrics, revenue, or organizer adoption for this feature
- New percentages not listed in `METRICS.md`
