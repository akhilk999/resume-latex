# KonfHub — Accomplishments

Source: `KONFHUB_CONTEXT.md`, `resume/extraction_docs/konfhub.md` (repository analysis of `akhilk999/konfhub-internship`).
Do not invent metrics. Do not write polished resume bullets here.

---

## Accomplishment 1 — Prompt-chained event description + poster pipeline

### What I Built

End-to-end Python POC that turns structured event facts (What / Who / When / Where / Why) into a persuasive description, SEO keywords, and a thematic poster — intended as the backend path for auto-generating visuals right after organizers enter event details on KonfHub.

**Ownership:** Primary / sole implementer of internship POC (confirmed)

### Technical Implementation

- Built direct LLM pipeline in `llm-testing`: 5W input → Bedrock text generation (JSON `description` + `keywords`) → intermediate photographic image-prompt LLM → image model → PNG artifacts
- Enforced product constraints in prompts: short persuasive copy, SEO keyword lists, 16:9 aspect, **no-text / no-face** imagery, style variants (`professional` / `trendy` / `minimalistic`)
- Tuned decoding per stage (e.g. description higher temperature; image-prompt lower temperature; Gemini image temperature 0.1) and negative prompts for typography/faces/watermarks
- Saved outputs to consistent JSON/PNG artifact layout under `llm-testing/i-o/`

### Engineering Challenge

Generative posters often rendered unwanted text and faces; required iterative prompt redesign (scene/photography framing), negatives, style constraints, and model switching rather than a single-shot “make a poster” call.

### Impact

Replaced a multi-step manual workflow (write copy → keyword research → brief designer/Canva) with a single chained generation run for the POC. Observed during internship eval: content accuracy improved ~65% and formatting errors fell from ~25% to ~3% after parameterized prompts + multi-turn chaining (see `METRICS.md`).

### Evidence

`llm-testing/main.py`, `description_gen` / `poster-gen` evolution, `i-o/` outputs, `resume/extraction_docs/konfhub.md` §§1–3

### Tags

AI, Backend, Automation, Product

*Skills demonstrated:* Python, Amazon Bedrock Converse, prompt chaining, Gemini / Stability image APIs

---

## Accomplishment 2 — Provider-agnostic OOP generation layer

### What I Built

A swappable model abstraction so text and image providers (Bedrock + Gemini) could be exchanged without rewriting the pipeline.

**Ownership:** Primary architect and implementer (confirmed; PRs #5, #7)

### Technical Implementation

- Introduced `BaseModel` abstract interface and provider classes (`NovaMicro`, `SD35_L`, `Gemini2_0FlashImg`)
- Unified separate `TextGenerator` / `ImageGenerator` into a single `Generator` façade for generate + extract + save
- Normalized heterogeneous API shapes: Bedrock Converse, Bedrock `invoke_model` (base64 images), Gemini multimodal parts
- Refactored procedural scripts → OOP inheritance (`model-testing-rework`)

### Engineering Challenge

Each provider returns different response structures and modalities; unsupported modality paths raise `NotImplementedError`; secrets via `.env`.

### Impact

Enabled multi-provider experimentation and cleaner integration of bake-off winners into one pipeline. ~3 concrete model classes + abstract base in final OOP layer.

### Evidence

`llm-testing/classes/BaseModel.py`, `Generator.py`, `classes/models/*`, PRs #5 / #7

### Tags

Backend, AI, Cloud

*Skills demonstrated:* Python OOP, boto3 Bedrock Runtime, google-genai, API abstraction

---

## Accomplishment 3 — Multi-model Bedrock bake-off and model selection

### What I Built

Comparative evaluation of many Bedrock foundation models on the same event prompt to choose a text model for the POC path.

**Ownership:** Primary implementer (confirmed)

### Technical Implementation

- Scripted bake-off via Bedrock Prompt Management template ARNs (`prompting_v2.py`)
- Recorded outputs across Nova, Claude, Llama, DeepSeek, Mistral families in `output_v2.txt`
- Selected **Amazon Nova Micro** (`us.amazon.nova-micro-v1:0`) for the final direct-pipeline text stage (cost/latency oriented)

### Engineering Challenge

Comparing heterogeneous model behavior without formal BLEU/preference metrics — relied on qualitative side-by-side outputs for one shared event input.

### Impact

**23** models with recorded text outputs in bake-off; informed Nova Micro selection for the production-path-of-POC text stage. No formal accuracy % measured.

### Evidence

`llm-testing/old testing/prompting_v2.py`, `output_v2.txt`, extraction doc §3 Models

### Tags

AI, Cloud, Product

*Skills demonstrated:* Amazon Bedrock Prompt Management, model evaluation, tradeoff analysis

---

## Accomplishment 4 — Bedrock Guardrails on text generation

### What I Built

Safety layer on the direct LLM text path using Amazon Bedrock Guardrails, with agent-path stop-reason handling for interventions.

**Ownership:** Primary implementer (confirmed; PR #1)

### Technical Implementation

- Configured Guardrails (`guardrailIdentifier`, version, trace) on Bedrock text generation
- Handled agent stop reasons including `guardrail_intervened` and `max_tokens`
- Guardrails partially disabled/commented on agent path during testing (documented tradeoff)

### Engineering Challenge

Balancing safety intervention with usable POC outputs during rapid prompt iteration.

### Impact

Demonstrated production-minded safety integration on generative text; intervention logging for debugging. Not a measured reduction in harmful outputs.

### Evidence

PR #1 “Adding guardrails”, Bedrock Guardrails config, agent stop-reason handling in `strands-agent-testing`

### Tags

AI, Security, Cloud

*Skills demonstrated:* Amazon Bedrock Guardrails, safety/reliability engineering

---

## Accomplishment 5 — Strands multi-agent event generation POC

### What I Built

Agentic alternative to the scripted pipeline: tool-using Description and Poster agents that autonomously produce event copy and posters with filesystem state handoff.

**Ownership:** Primary architect and implementer (confirmed; PR #8)

### Technical Implementation

- `DescriptionAgent` reads `tests/[n]/input.JSON`, writes `output.JSON`; `PosterAgent` consumes description/keywords and writes posters
- Claude Sonnet 4 via Bedrock (`us.anthropic.claude-sonnet-4-20250514-v1:0`), `SlidingWindowConversationManager` (window_size=10)
- Built-in tools: `python_repl`, `file_read`, `file_write`, `generate_image`, `image_reader`
- Custom tools: `read_description_keywords`, `find_poster_index`, `copy_poster`, `confirm_file_exists`
- Logging, try/except around runs, stop-reason handling; argparse CLI for test selection

### Engineering Challenge

Agents needed reliable filesystem operations (index filenames, copy, cleanup, confirm) — custom tools outperformed relying only on `python_repl`. Branch design explored separate image vs poster agents vs single no-text poster agent.

### Impact

Autonomous multi-step generation with durable inter-agent contracts via JSON files. **2** agents, **4** custom tools, **5** wired built-in tools.

### Evidence

`strands-agent-testing/lib/agent.py`, `init_functions.py`, `tools.py`, PR #8

### Tags

AI, Backend, Automation

*Skills demonstrated:* Strands Agents SDK, Claude Sonnet 4, tool design, agent orchestration

---

## Accomplishment 6 — Reproducible 5-scenario agent evaluation harness

### What I Built

Indexed test harness storing inputs, generated copy, and visual outputs for iterative prompt/agent debugging across diverse event types.

**Ownership:** Primary implementer (confirmed)

### Technical Implementation

- Five scenarios under `strands-agent-testing/tests/1..5/` (e.g. tech ethics, cooking, alumni, climate walk, art fair)
- Persisted inputs/outputs/images/posters per scenario; file existence confirmation as runtime validation
- Large visual regression corpus committed for qualitative review (LLM-pipeline + agent artifacts)

### Engineering Challenge

Evaluating generative systems without automated preference metrics — used scenario diversity + artifact corpora instead.

### Impact

**5** agent test scenarios; **124** PNG artifacts total across pipeline + agents (repo-confirmed). Supports iterative debugging alongside observed accuracy/formatting improvements in `METRICS.md`.

### Evidence

`strands-agent-testing/tests/`, committed PNG corpora, extraction doc §6

### Tags

AI, Product

*Skills demonstrated:* evaluation harness design, qualitative visual QA, argparse test indexing

---

## Accomplishment 7 — Multi-provider image generation experimentation

### What I Built

Integrated and compared multiple image models for thematic event posters/photos under no-text/no-face constraints.

**Ownership:** Primary implementer (confirmed; includes PR #6 Gemini)

### Technical Implementation

- Stability SD 3.5 Large via Bedrock (`stability.sd3-5-large-v1:0`) — noted as strong poster style/text experiments
- Gemini 2.0 Flash Preview Image Generation via `google-genai`
- Additional artifacts: Stable Image Core/Ultra, Amazon Titan Image Generator v1; Strands `generate_image` tool on agent path
- Style-parameterized runs producing professional/trendy/minimalistic variants

### Engineering Challenge

Model-dependent failure modes (typography, faces, quality); required switching models and prompt strategies rather than one fixed image backend.

### Impact

**98** LLM-pipeline posters (Gemini 42, SD 3.5 Large 47, Core 3, Ultra 1, Titan 1) + **14** agent images + **12** agent posters + **4** Canva reference PNGs. Qualitative only — no ranked A/B winner metric in sources.

### Evidence

`llm-testing/i-o/posters/`, model classes, PR #6, extraction doc §3 Image models

### Tags

AI, Cloud

*Skills demonstrated:* multimodal image APIs, Bedrock InvokeModel, Gemini image generation

---

## Accomplishment 8 — Canva MCP designs + API-aware de-scope

### What I Built

Integrated Canva via Strands MCPClient for design-tool workflows, producing branded event designs during internship experimentation; later de-emphasized MCP as the primary automated generator after Canva Connect API AI-generation limits.

**Ownership:** Primary investigator/implementer (confirmed)

### Technical Implementation

- Scaffolded MCP client against Canva remote MCP; listed and exercised tools in the design workflow
- Produced **20+ branded designs** during Canva MCP experimentation (internship observation — see `METRICS.md`)
- Documented Canva Connect API limitations for AI generation on the MCP path; removed/deactivated MCP as the primary automated path
- Retained Bedrock/Gemini generation as the main POC path; kept `canvas/` reference PNGs in-repo for comparison

### Engineering Challenge

Balancing a working experimental Canva MCP design path with honesty about API capability limits before treating MCP as the long-term primary generator.

### Impact

**20+ branded designs** via Canva MCP (observed). Later de-scope protected focus on Bedrock/Gemini for reliable automated generation — claim designs produced, not a shipped production Canva integration inside KonfHub.

### Evidence

Canva MCP scaffolding/commits, internship observation (20+ designs), `canvas/` references, onboarding notes on Connect API limits

### Tags

AI, Product, Backend

*Skills demonstrated:* MCP, Canva integration, API capability research, scope management

---

## Accomplishment 9 — Flask Video CRUD REST API (learning module)

### What I Built

Tutorial-scope Flask-RESTful + SQLAlchemy Video API demonstrating REST semantics used in company-adjacent backend learning.

**Ownership:** Primary implementer (confirmed; PR #3)

### Technical Implementation

- Resource `/video/<int:video_id>` with GET / PUT / PATCH / DELETE
- `reqparse` validation, `marshal_with` responses, `abort` for 404/409; SQLite `VideoModel`
- Companion `test.py` exercising methods

### Engineering Challenge

Correct HTTP semantics (create-vs-conflict on PUT, partial PATCH, 204 delete) without auth (expected for tutorial).

### Impact

**4** REST operations practiced; onboarding to Flask/ORM patterns. Not part of the event-poster product path.

### Evidence

`flask-testing/main.py`, `test.py`, PR #3

### Tags

Backend, Database

*Skills demonstrated:* Flask, Flask-RESTful, SQLAlchemy, SQLite, REST design

---

## Accomplishment 10 — Jira Forms Cloud API client

### What I Built

CLI client covering five Atlassian Forms Cloud operations for form-template CRUD/list, supporting internal tooling familiarity.

**Ownership:** Primary implementer (confirmed; PR #4)

### Technical Implementation

- Operations: GET/PUT/DELETE form template, GET project form index, POST create form template
- Env-based auth (`AUTHORIZATION_HEADER`); JSON payload from UI-derived `payload.JSON`; responses saved to `response.JSON`
- Argparse method selection; non-200 exits with error

### Engineering Challenge

Reconstructing complex form design payloads (questions, sections, publish settings) from Jira Advanced Form UI exports.

### Impact

**5** HTTP operations exercised against live Forms API. Learning/integration practice — not the poster POC core.

### Evidence

`jira-form-testing/main.py`, `payload.JSON`, PR #4

### Tags

Backend, Product

*Skills demonstrated:* REST client craftsmanship, Atlassian APIs, env-based secrets

---

## Accomplishment 11 — Internship delivery through PR-based iteration

### What I Built

Structured delivery of the POC from Bedrock experiments → OOP rewrite → Gemini images → unified Generator → Strands agents over ~6 weeks.

**Ownership:** Sole committer; **8** merged PRs (confirmed)

### Technical Implementation

- PR timeline: #1 Guardrails → #2 Poster generator → #3 Flask → #4 Jira → #5 OOP rework → #6 Gemini → #7 Generator integration → #8 Strands agent
- Onboarding docs for Bedrock/Gemini/agent setup; requirements freezes; `.env` + gitignore for secrets
- Explicit TODOs left for unfinished quality loops (e.g. multimodal feedback, some Stability helpers)

### Engineering Challenge

Balancing learning modules (Flask/Jira) with core AI POC depth in a short unpaid internship window.

### Impact

**~6 weeks**, **8** merged PRs, **~105** commits on main history (repo metrics). Clear narrative of iterative AI systems engineering.

### Evidence

Git history / PR titles in extraction Appendix B; onboarding markdown

### Tags

AI, Backend, Leadership

*Skills demonstrated:* PR workflow, technical documentation, iterative delivery
