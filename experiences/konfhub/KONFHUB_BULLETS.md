# KonfHub — Resume Bullets

Formula: Accomplished X as measured by Y by doing Z.
Rules: Do not invent metrics. Do not exaggerate ownership. Prioritize impact. Keep bullets concise.

Sources: `KONFHUB_ACCOMPLISHMENTS.md`, `METRICS.md`, `KONFHUB_SYSTEM_DESIGN.md`, `KONFHUB_CONTEXT.md`.

Observed metrics approved in `METRICS.md` / `KONFHUB_CONTEXT.md`: ~65% content accuracy improvement; formatting errors ~25% → ~3%; 20+ Canva MCP designs. **70% time saved** still unconfirmed — omit until reconfirmed.

# Backend SWE

- Built a Python backend POC that turns structured event details (5W) into description, SEO keywords, and poster artifacts via chained Bedrock/Gemini calls and a consistent JSON/PNG output layout
- Designed a provider-agnostic OOP generation layer (`BaseModel` + `Generator`) so Bedrock and Gemini text/image backends could be swapped without rewriting the pipeline
- Integrated Amazon Bedrock Runtime (`converse` / `invoke_model`) and Google Gemini APIs behind environment-configured secrets, with Bedrock Guardrails on the text path
- Encoded durable inter-step contracts via filesystem JSON so poster generation reliably consumes upstream description/keyword outputs
- Implemented a Flask-RESTful Video CRUD API on SQLite with request validation, response marshalling, and 404/409 semantics (learning module; 4 operations)
- Built a CLI client for Atlassian Jira Forms Cloud covering 5 form-template operations using env-based auth and UI-derived JSON payloads
- Automated AI-powered poster workflows by validating Flask REST endpoints and integrating Canva MCP to produce 20+ branded designs during internship experimentation
- Delivered the internship POC through 8 merged PRs over ~6 weeks, from Bedrock experiments to an agentic generation path

# Full Stack SWE

- *(Limited frontend in this experience.)* Prefer Backend / AI bullets; if a fullstack variant needs KonfHub, emphasize end-to-end asset pipeline from structured input → persisted JSON/PNG artifacts rather than UI ownership
- Prototyped organizer-facing event intake schema (What/Who/When/Where/Why) mapping directly to generated marketing copy and visuals for a future KonfHub event-creation hook

# AI/ML

- Engineered a prompt-chained generative pipeline: event 5W → persuasive description/keywords → constrained image prompt → no-text/no-face 16:9 poster with style variants
- Improved content accuracy by ~65% and reduced formatting errors from ~25% to ~3% by optimizing parameterized prompts and multi-turn prompt chaining through iterative evaluation
- Evaluated 23 Bedrock foundation models on identical event prompts and selected Amazon Nova Micro for the POC text stage
- Built a Strands Agents POC with Claude Sonnet 4, sliding-window memory, and tool-using Description and Poster agents for autonomous asset generation
- Authored 4 custom agent tools for description/keyword I/O, poster indexing, artifact copy/cleanup, and file confirmation
- Integrated multimodal image generation across Stability SD 3.5 Large, Gemini 2.0 Flash image, and related Bedrock image models, producing 100+ saved visual artifacts for qualitative evaluation
- Applied Bedrock Guardrails on text generation and handled agent stop reasons including guardrail intervention and max-token cutoffs
- Integrated Canva MCP via Strands MCPClient to produce 20+ branded designs, then de-emphasized MCP as the primary automated path after Canva Connect API AI-generation limits
- Created a reproducible 5-scenario agent test harness storing inputs, generated copy, and visual outputs for iterative prompt/agent debugging

# Robotics

_(Not applicable.)_

# Product

- Translated the organizer workflow gap—manual copywriting and poster design after entering event details—into a backend POC aimed at auto-generating assets at event-creation time on KonfHub
- Encoded product constraints (SEO keywords, short persuasive descriptions, 16:9 no-text/no-face posters, professional/trendy/minimalistic styles) into enforceable prompt and agent instructions
- Ran comparative model and visual experiments (Bedrock/Gemini artifacts plus 20+ Canva MCP designs) to inform which generation approach fit event branding needs
- Scoped Canva MCP down as the primary automated path after Connect API limits, while retaining Bedrock/Gemini generation for reliable POC demos
- Packaged onboarding docs so the event-generation POC and tradeoffs between direct LLM calls and agentic workflows are reproducible

# Quant / Trading SWE

_(No trading/market domain — analytical pipelines / eval tooling only.)_

- Built a Python generation pipeline with durable filesystem JSON contracts between stages so downstream poster steps reliably consume upstream description/keyword outputs
- Evaluated 23 Bedrock foundation models on identical prompts and selected Nova Micro for the POC text stage on cost/latency tradeoffs
- Created a reproducible 5-scenario agent test harness storing inputs, generated copy, and visual outputs for iterative debugging (124 PNG artifacts across pipeline + agents)
- Improved observed content accuracy by ~65% and cut formatting errors from ~25% to ~3% by iterating parameterized prompts and multi-turn chaining

# Forward Deployed

- Translated organizer pain (manual copy + poster work after entering event 5W) into a backend POC meant to plug into KonfHub event creation
- Encoded stakeholder constraints (SEO, short copy, 16:9 no-text/no-face posters, style variants) into enforceable prompts/agent instructions rather than loose demos
- Scoped Canva MCP out as the primary automated path after API limits, keeping Bedrock/Gemini paths that still demo reliably for product conversations
- Packaged onboarding docs so teammates can reproduce the POC and understand direct-LLM vs agentic tradeoffs

# Infra / Platform

_(POC / internship scope — not production platform engineering.)_

- Integrated Bedrock and Gemini behind environment-configured secrets, with Bedrock Guardrails on the text path
- Designed a provider-agnostic OOP generation layer so backends could be swapped without rewriting the pipeline
- Delivered the POC through 8 merged PRs over ~6 weeks with consistent artifact layouts for handoff — do not claim CI/CD, Kubernetes, or production multi-tenant infra
