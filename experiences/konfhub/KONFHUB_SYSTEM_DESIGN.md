# KonfHub — System Design

> **Purpose:** Interview-ready system design for the internship POC. Only technically supported information.
> **Sources:** `KONFHUB_CONTEXT.md`, `KONFHUB_ACCOMPLISHMENTS.md`, `resume/extraction_docs/konfhub.md`
> **Scope:** Backend POC — not production KonfHub platform architecture.

# Overview

KonfHub (the company product) is an AI-powered event management and ticketing platform. This internship built a **backend proof of concept** so that, when organizers enter event details, the system can automatically produce:

1. Persuasive event **description**
2. SEO **keywords**
3. Thematic **poster / visual** (constrained: no text, no faces, 16:9, style variants)

Two architectures were explored in one private internship repo (`konfhub-internship`):

1. **Direct LLM pipeline** (`llm-testing`) — deterministic scripted prompt chaining
2. **Agentic pipeline** (`strands-agent-testing`) — multi-agent tool-using generation

Supporting learning modules: Flask Video CRUD API and Jira Forms API client.

Akhil was the sole committer on the internship repo (unpaid SWE intern, Jun–Jul 2025). This POC was **not** evidenced as shipped into live KonfHub event-creation UX.

# Architecture

```
                    ┌─────────────────────────────────────┐
                    │     Event details (5W JSON input)   │
                    │   What / Who / When / Where / Why   │
                    └─────────────────┬───────────────────┘
                                      │
              ┌───────────────────────┴───────────────────────┐
              ▼                                               ▼
┌─────────────────────────────┐               ┌─────────────────────────────┐
│   Direct LLM pipeline       │               │   Strands agent pipeline    │
│   (llm-testing)             │               │   (strands-agent-testing)   │
│                             │               │                             │
│  Nova Micro (Bedrock)       │               │  DescriptionAgent           │
│       ↓ description/kw      │               │    (Claude Sonnet 4)        │
│  Image-prompt LLM           │               │       ↓ output.JSON         │
│       ↓ photo prompt        │               │  PosterAgent + tools        │
│  Image model                │               │    (generate_image, I/O)    │
│  (Gemini Flash Img / SD3.5) │               │                             │
└──────────────┬──────────────┘               └──────────────┬──────────────┘
               │                                             │
               └──────────────────┬──────────────────────────┘
                                  ▼
                    ┌─────────────────────────────────────┐
                    │  Artifacts: output.JSON + PNG posters │
                    └─────────────────────────────────────┘

External services: Amazon Bedrock (text, image, Guardrails, Prompt Management),
Google Gemini image API, (researched then removed) Canva MCP.
```

Four independent Python packages — no shared monorepo library; no production auth gateway, queue, or multi-tenant KonfHub service layer in this repo.

# Components

### 1. Direct LLM generation package (`llm-testing`)

- `BaseModel` + provider adapters + `Generator` façade
- CLI/script entrypoints for description and poster generation
- Artifact directories for inputs, JSON outputs, posters
- Legacy bake-off scripts under `old testing/`

### 2. Strands agent package (`strands-agent-testing`)

- Agent orchestration / run loop (`lib/agent.py`)
- Init: parser, logger, Bedrock model wiring (`lib/init_functions.py`)
- Custom tools (`lib/tools.py`)
- Indexed scenario tests `tests/1..5/`

### 3. Flask learning API (`flask-testing`)

- Video CRUD resource on SQLite via SQLAlchemy
- Manual HTTP test script

### 4. Jira Forms client (`jira-form-testing`)

- Thin `requests` client against Atlassian Forms Cloud
- UI-derived form template payloads

# Data Flow

### Direct pipeline

```
5W input JSON
    → Bedrock Converse (Nova Micro) + Guardrails
    → {description, keywords[]}
    → Bedrock text LLM (photographer persona) → ≤200-char image prompt
    → Gemini Flash Img and/or SD 3.5 Large (negative prompts, style, 16:9)
    → PNG under i-o/posters/ + JSON output
```

### Agentic pipeline

```
tests/[n]/input.JSON
    → DescriptionAgent (Claude Sonnet 4, sliding window)
    → output.JSON (description, keywords)
    → PosterAgent tools: read_description_keywords → generate_image
        → find_poster_index → copy_poster → confirm_file_exists
    → tests/[n]/posters/
```

### Intended product flow (context — not implemented as KonfHub UX in repo)

```
Organizer creates event on KonfHub → enters details
    → (future) backend calls generation service
    → poster (+ copy) returned into event creation UX
```

# Database Design

- **AI pipelines:** filesystem JSON as durable state (no relational DB)
- **Event schemas:**
  - Input: What / Who / When / Where / Why
  - Output: `{description: string, keywords: string[]}`
- **Flask module only:** SQLite `VideoModel` (`id`, `name`, `likes`, `views`)
- No KonfHub production schema in this repo

# APIs

### Owned HTTP API (learning)

| Method | Path | Behavior |
|--------|------|----------|
| GET | `/video/<id>` | Fetch or 404 |
| PUT | `/video/<id>` | Create or 409 if exists (201) |
| PATCH | `/video/<id>` | Partial update or 404 |
| DELETE | `/video/<id>` | Delete or 404 (204) |

### External APIs consumed

| API | Usage |
|-----|--------|
| Amazon Bedrock Runtime | `converse`, `invoke_model` |
| Amazon Bedrock Guardrails | Text-path safety |
| Amazon Bedrock Prompt Management | Multi-model bake-off ARNs |
| Google Gemini (`google-genai`) | Image generation |
| Atlassian Jira Forms Cloud | 5 form-template operations |
| Canva remote MCP | Researched; deactivated |

AI generation entrypoints are **CLI/scripts**, not production HTTP microservices.

# Authentication/Security

- Secrets via `.env` + gitignore (`AWS_GUARDRAIL_ID`, `GEMINI_API_KEY`, Jira auth vars)
- Bedrock Guardrails on direct text path; agent path handles `guardrail_intervened`
- Flask tutorial API: **no auth** (expected for learning scope)
- Jira: Authorization header / API token from environment
- No production OAuth/RBAC for a KonfHub-facing generation service in this repo

# Infrastructure

- Local Python venvs + per-package `requirements.txt`
- AWS Bedrock regions documented (`us-west-2`; earlier `us-east-2` experiments)
- Google AI Studio keys for Gemini
- No containers, CI deploy pipelines, or cloud hosting for the POC services found in extraction
- Large PNG corpora committed for demos (tradeoff: reproducible visuals vs noisy git history)

# Automation

| Automation | Replaces (manual) | Mechanism |
|------------|-------------------|-----------|
| Description + keywords | Hand-written marketing copy + keyword research | Bedrock + JSON schema prompts |
| Image-prompt generation | Human writing image prompts | Prompt chaining |
| Poster generation | Designer / Canva | SD3.5 / Gemini / strands `generate_image` |
| Multi-agent orchestration | Human multi-step tool use | Strands agents + custom tools |
| Model bake-off | Ad-hoc model trials | Prompt Management ARNs → one log file |
| Jira form scripting | Repeated Forms UI clicks | CLI client |

No scheduled jobs, queues (Celery/RQ/SQS), or streaming pipelines.

# AI Systems

### Text models

- Primary POC path: Amazon Nova Micro via Bedrock Converse
- Agents: Claude Sonnet 4 via Bedrock
- Bake-off: 23 recorded Bedrock model outputs (Nova, Claude, Llama, DeepSeek, Mistral families)

### Image models

- Gemini 2.0 Flash Preview Image Generation
- Stability SD 3.5 Large (Bedrock)
- Stability Core/Ultra, Titan v1 (experimental artifacts)
- Strands `generate_image` on agent path

### Prompt engineering

- System prompts with role + JSON/schema constraints
- Few-shot examples (tech conference, music festival, food festival) for image-prompt stage
- Style parameterization; negative prompts; aspect 16:9; length caps
- Chaining: description → image prompt → image (not one-shot poster)

### Agents

- Sliding window memory (10 turns)
- Filesystem as inter-agent contract
- Custom operational tools (index, copy, confirm) beyond REPL

### Safety

- Bedrock Guardrails on text path
- Stop-reason handling; planned multimodal feedback loop unfinished (TODO)

### Evaluation

- Qualitative: bake-off text file + 124 PNGs + 5 scenarios
- **No** BLEU, preference scores, latency SLOs, or A/B metrics in repo

# Engineering Decisions

1. **POC CLI over production service** — faster iteration; no auth/scale yet.
2. **Prompt chaining over one-shot posters** — better control of copy vs visual constraints.
3. **OOP `BaseModel`/`Generator`** — swap Bedrock/Gemini without rewriting callers.
4. **Multi-model bake-off before locking Nova Micro** — evidence-based text model choice.
5. **No-text / no-face posters** — brand-safe thematic imagery over typography-heavy “poster” look.
6. **Dual-agent + file handoff** — clear contracts vs one mega-agent.
7. **Custom agent tools** — reliable filesystem ops vs REPL-only.
8. **Remove Canva MCP** — unsupported AI generation via Connect API; don’t ship broken integration.
9. **Guardrails on text; optional on agents during testing** — safety vs iteration speed.
10. **Qualitative artifact corpora** — practical for images; weak for quantitative resume claims.
11. **Include Flask/Jira learning modules** — stack onboarding alongside core AI POC.

# Tradeoffs

| Decision | Benefit | Cost |
|----------|---------|------|
| CLI POC vs service API | Speed of experimentation | No production auth, multi-tenant isolation, or SLOs |
| Qualitative visual eval vs automated metrics | High signal for posters | Cannot defend invented accuracy/time-saved % |
| Nova Micro for text | Cost/latency | Possibly weaker prose than larger Claude/Llama |
| No-text posters | Brand control | Less “classic poster” with headlines |
| Remove Canva MCP | Reliable local generation | No design-tool deep integration |
| Commit generated images | Reproducible demos | Large/noisy git artifacts |
| Agents vs scripts | Flexibility, tool use | Less determinism; harder debugging |
| Guardrails | Safer text | Can interrupt runs; needs stop-reason handling |

## Failure Modes

| Failure | Behavior / mitigation |
|---------|------------------------|
| Unwanted text/faces in images | Prompt redesign, negatives, model switch, no-text agent path |
| Guardrail intervention | Logged stop reason; agent path may disable during tests |
| Max tokens | Stop-reason handling; tune `max_tokens` |
| Missing input JSON | SystemExit / explicit errors |
| Unsupported modality on a model class | `NotImplementedError` |
| Jira non-200 | CLI exits with error; response saved for debug |
| Canva MCP AI gap | De-scoped; use Bedrock/Gemini instead |
| Flask unknown video id | 404 abort |

# Future Improvements

Documented or implied by POC/TODOs (not shipped):

- Productize as a KonfHub event-creation backend service (auth, async jobs, storage, UX hook after detail entry)
- Formal evaluation rubric / human preference tests for posters and copy
- Finish multimodal feedback loop (agent sees image, revises)
- Complete remaining Stability helpers / TODOs in code
- Alembic-style persistence if generation metadata must be queried
- Revisit design-tool integrations only if APIs support AI generation
- Latency/cost monitoring if moved behind production traffic
