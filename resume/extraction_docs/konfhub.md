# KonfHub Internship — Master Accomplishment Database

**Source:** `akhilk999/konfhub-internship`  
**Author (sole committer):** Akhil Kasamsetty (`akhilk999`)  
**Repo activity window (git):** 2025-06-19 → 2025-07-29  
**Merged PRs:** 8 (`#1`–`#8`)  
**Purpose of this document:** Evidence-backed extraction of engineering accomplishments for later resume targeting. Not a resume.

**Evidence tiers used throughout:**
- **Code evidence** — present in source/tests/artifacts
- **Doc evidence** — present in README/onboarding/commit messages
- **Inference** — reasonable but not proven by repo alone

---

# 1. Project Context

## What problem does this system solve?

It automates creation of **event marketing assets** from structured event facts (`What` / `Who` / `When` / `Where` / `Why`):

1. Persuasive **event description**
2. SEO-oriented **keywords**
3. Thematic **poster / visual imagery** (no-text / no-face constraints)

This is framed in onboarding docs as a **proof of concept** for generating description, keywords, and event poster for a user-created event.

## Who are the intended users?

**Inferred from product + code:** event organizers / conference hosts using an event platform (KonfHub), who currently write descriptions and design posters manually.

**Cannot be determined from repository:**
- Exact KonfHub end-user personas or customer segments
- Whether this shipped into production KonfHub UX
- Number of organizers or events supported in production

## What workflow/process does it automate?

| Manual step (inferred) | Automated step (code) |
|---|---|
| Write event description | LLM generates JSON `description` from 5W input |
| Choose SEO keywords | LLM generates `keywords` list |
| Brief a designer / use Canva | LLM generates image prompt → image model generates poster |
| Iterate style (professional / trendy / minimalistic) | Style parameter in prompt pipeline |

Two automation architectures were built:

1. **Direct LLM pipeline** (`llm-testing`) — sequential scripted calls
2. **Agentic pipeline** (`strands-agent-testing`) — multi-agent tool-using agents

## What existed before this system?

**Cannot be fully determined.** Repo implies organizers manually wrote copy and designed posters (including Canva). Commit history shows iterative POC work, not replacement of a prior internal system.

**Doc evidence of Canva exploration:** `strands-agent-testing/onboarding.md` documents Canva MCP research and removal of active Canva MCP usage because Canva AI generation was not supported via Canva Connect API used by the MCP server. Manual Canva reference images exist under `llm-testing/i-o/posters/canvas/` (4 PNGs).

## What was the role of AI in the product?

AI is the **core generation engine**, not an accessory:

- Text LLMs → event copy + keywords + intermediate image prompts
- Image generative models → posters / thematic photos
- Agent framework (Strands) → tool-using autonomous generation with file I/O validation
- Safety layer → Amazon Bedrock Guardrails (implemented in direct LLM path; partially disabled/commented in agent path)

**Cannot be determined:** production feature flag status, latency SLOs, or customer-facing AI UX copy.

---

# 2. Ownership and Contributions

All commits are from **Akhil Kasamsetty**. Ownership of everything in this private internship repo is strongly supported. Treat claims as **internship POC ownership**, not company-wide production ownership unless confirmed outside this repo.

## Confirmed contributions

### Features implemented
- End-to-end **event description + keywords generation** from structured 5W input
- End-to-end **thematic poster / photo generation** with style variants
- **Prompt-chained** poster pipeline (description → image-prompt LLM → image model)
- **Multi-agent event generator POC** (`DescriptionAgent` → `PosterAgent`)
- Indexed **test harness** with 5 event scenarios for agent evaluation
- Flask **Video CRUD REST API** learning project with SQLite persistence
- Jira Forms API client covering **5 HTTP operations** for form templates

### Components / modules created
| Module | Role |
|---|---|
| `llm-testing/classes/BaseModel.py` | Abstract model interface |
| `llm-testing/classes/Generator.py` | Unified text/image generation + save/retrieval |
| `llm-testing/classes/models/NovaMicro.py` | Amazon Nova Micro via Bedrock Converse |
| `llm-testing/classes/models/SD35_L.py` | Stable Diffusion 3.5 Large via Bedrock |
| `llm-testing/classes/models/Gemini2_0FlashImg.py` | Gemini 2.0 Flash image generation |
| `strands-agent-testing/lib/agent.py` | Agent orchestration / run loop |
| `strands-agent-testing/lib/init_functions.py` | Parser, logger, agent initialization |
| `strands-agent-testing/lib/tools.py` | Custom Strands tools |
| `flask-testing/main.py` + `test.py` | REST API + request tests |
| `jira-form-testing/main.py` + `payload.JSON` | External API integration |

### APIs developed
- Flask-RESTful resource: `/video/<int:video_id>` with GET, PUT, PATCH, DELETE
- Jira Forms Cloud API client for GET/PUT/DELETE/POST form template operations + project form index

### AI workflows created
1. **Benchmarks across Bedrock prompt templates** (`prompting_v2.py`) — many foundation models compared on same event input
2. **Description gen + Guardrails** (`description_gen.py` → OOP rewrite)
3. **Poster gen with intermediate prompt generation** (`poster-gen.py` → OOP rewrite)
4. **Unified Generator pipeline** (`main.py` in `llm-testing`)
5. **Two-agent Strands workflow** with custom tools and file-based state

### Integrations built
- Amazon Bedrock Runtime (Converse + InvokeModel)
- Amazon Bedrock Guardrails
- Amazon Bedrock Prompt Management templates (ARNs in `prompting_v2.py`)
- Google Gemini API (`google-genai`)
- Atlassian Jira Forms Cloud API
- Strands Agents SDK + strands-tools
- MCP client scaffolding for Canva (researched; deactivated)

### Infrastructure / configuration added
- `.env`-based secrets (`AWS_GUARDRAIL_ID`, `GEMINI_API_KEY`, Jira auth vars)
- AWS CLI / Bedrock region notes (`us-west-2`, earlier `us-east-2` experiments)
- Per-project `requirements.txt` lockfiles
- Onboarding docs with setup + learning resources
- Argparse CLI for agent test selection and Jira method selection
- Logging setup for agent runs
- Indexed artifact directories for posters/images/outputs

### Significant refactors
- Procedural scripts → OOP `BaseModel` inheritance (`model-testing-rework`, PR #5)
- Separate `TextGenerator` / `ImageGenerator` → unified `Generator` (PR #7)
- Prompt evolution: poster-with-text → thematic **no-text / no-face** imagery
- Agent architecture: separate image+poster agents (`main`) vs single no-text poster agent (`no-text-posters` branch content merged)
- Canva MCP attempted then removed after API capability discovery

### Testing / debugging work
- 5 agent test cases with saved inputs/outputs/images/posters
- Large visual regression corpus (generated PNGs committed)
- Flask `test.py` exercising PUT/DELETE/GET/PATCH
- Jira methods marked as working in code comments after payload built via Jira Advanced Form UI
- Iterative negative-prompt and style tuning (commit history: “tried to remove text…”, “prompt is looking good”)
- Explicit TODOs for unfinished work: `generate_image_stability`, system prompt polish, multi-modal feedback loop

## Possible contributions (inference, not proven)

- Intended eventual productization into KonfHub event-creation UX
- Comparison of generated posters vs Canva baseline (`canvas/` folder)
- Internal demos / oncall testing (`oncall testing` commit)
- Prompt research documented in external Google Doc linked from onboarding (“Prompting Methods and Analysis”) — content not in repo
- Internship learning track for Flask/Jira as onboarding to company stack

**Do not claim without external confirmation:** production deployment, revenue impact, user counts, accuracy %, time-saved hours.

---

# 3. AI/ML Engineering Analysis

## Models

### LLM / text providers
| Provider | Model | Where used |
|---|---|---|
| Amazon Bedrock | `us.amazon.nova-micro-v1:0` | Primary text gen (final `llm-testing` pipeline) |
| Amazon Bedrock | Claude Sonnet 4 `us.anthropic.claude-sonnet-4-20250514-v1:0` | Strands agents |
| Amazon Bedrock Prompt Management | Many models via prompt ARNs | `prompting_v2.py` comparative eval |

### Models evaluated in `output_v2.txt` (23 model outputs recorded)
Amazon Nova Pro/Premier/Lite/Micro; Claude 3.5 Sonnet (multiple), Claude 3.7 Sonnet, Claude 3 Haiku, Claude 3.5 Haiku, Claude Opus 4, Claude Sonnet 4; DeepSeek R1; Llama 3.1 (8B/70B/405B), Llama 3.2 (1B/3B/11B/90B), Llama 3.3 70B, Llama 4 Scout/Maverick; Mistral Pixtral Large.

### Image models
| Model | Evidence |
|---|---|
| Gemini 2.0 Flash Preview Image Generation | Final `llm-testing` image path; **42** saved PNGs |
| Stability SD 3.5 Large (`stability.sd3-5-large-v1:0`) | Class + **47** PNGs; comment “best poster style & text generation” |
| Stable Image Core v1.1 | **3** PNGs |
| Stable Image Ultra v1.1 | **1** PNG |
| Amazon Titan Image Generator v1 | **1** PNG |
| Titan v2 | Referenced in old `poster-gen.py` (no dedicated output folder found) |
| Strands `generate_image` tool | Agent poster/image generation (Bedrock-backed via strands-tools) |

### APIs / frameworks / SDKs
- `boto3` Bedrock Runtime (`converse`, `invoke_model`)
- `google-genai` (`GenerateContentConfig`, multimodal TEXT/IMAGE)
- `strands-agents` + `strands-agents-tools`
- `mcp` + Strands `MCPClient` (Canva remote MCP scaffolding)
- Pillow for image decode/save
- Bedrock Guardrails config (`guardrailIdentifier`, version, trace)

### Agent frameworks
- **Strands Agents SDK** with:
  - `Agent`
  - `BedrockModel`
  - `SlidingWindowConversationManager` (window_size=10)
  - Built-in tools: `python_repl`, `file_read`, `file_write`, `generate_image`, `image_reader`
  - Custom `@tool` functions

## Prompt Engineering

### System prompts (role + task + constraints)
- Event-planner persona for description/keywords with JSON schema constraints (4–6 sentences; 3–7 keywords; SEO)
- Photographer persona for intermediate image-prompt generation
- PosterAgent expert system prompt enforcing no text/faces, 16:9, negative prompts, directory hygiene
- DescriptionAgent system prompt enforcing output path + JSON keys + word limits

### Few-shot examples
In `llm-testing/main.py` image-prompt system prompt:
- Tech conference example
- Music festival example
- Food festival example

### Parameterization
- Style selector: `professional` / `trendy` / `minimalistic`
- Inference configs tuned differently per stage:
  - Description: `maxTokens=600`, `temperature=0.9`, `topP=0.9`
  - Image prompt: `maxTokens=600`, `temperature=0.5`, `topP=0.5`
  - Gemini image: `temperature=0.1`
  - DescriptionAgent: `temperature=0.6`, `top_p=0.7`, `max_tokens=4096`
  - PosterAgent: `temperature=0.4`, `top_p=0.5`, `max_tokens=4096`
- Negative prompts for faces/text/watermarks/low quality artifacts
- Aspect ratio 16:9
- Random seeds for SD generation

### Prompt chaining / context management
**Chained pipeline (direct LLM):**
1. 5W input → description + keywords JSON
2. Description + keywords → photographic prompt string (≤200 chars in final prompt)
3. Prompt (+ negative prompt) → image model

**Agent memory:** Sliding window conversation manager (10 turns). File system used as durable state between agents (`output.JSON` → poster agent).

### Output formatting
- Strict JSON keys: `description`, `keywords`
- File naming conventions: `{index}-{style}.png`, `{index}.png`
- Agent instructed to avoid commentary unless errors

## Agent Architecture

### Agents
1. **DescriptionAgent** — reads `tests/[n]/input.JSON`, writes `output.JSON`
2. **PosterAgent** — reads description/keywords, generates/copies poster into `posters/`

### Custom tools (`lib/tools.py`)
| Tool | Purpose |
|---|---|
| `read_description_keywords` | Load prior agent output |
| `find_poster_index` | Avoid filename collisions |
| `copy_poster` | Persist generated poster + cleanup temp `output/` |
| `confirm_file_exists` | Validation / confirmation |

### Workflows
- Sequential multi-agent pipeline with logging and stop-reason handling (`guardrail_intervened`, `max_tokens`, KeyboardInterrupt)
- Branch design tradeoff documented: separate image vs poster agents vs single no-text poster agent

### Memory / state
- Sliding window conversation
- Filesystem as inter-agent contract
- Indexed test directories as reproducible evaluation harness

### Human-in-the-loop
- CLI test selection
- Manual prompt iteration via commits
- Guardrail intervention logging
- Planned but unfinished: multi-modal feedback loop (commit TODO)

## Evaluation

### What exists
- Comparative text outputs across **23** Bedrock models for one event prompt
- Visual artifact corpus: **98** LLM-pipeline posters + **14** agent images + **12** agent posters = **124** PNGs total
- Style distribution in LLM posters: ~59 professional, ~13 trendy, ~10 minimalistic (plus unstyled early files)
- 5 diverse agent scenarios (tech ethics, cooking, alumni, climate walk, art fair)
- File existence confirmation tools as runtime validation
- HTTP status checks for Jira client
- Flask abort paths for 404/409

### What does **not** exist in repo
- Quantitative accuracy / BLEU / human preference scores
- Automated unit tests for prompts or agents
- A/B metrics or latency benchmarks
- Formal rubric for poster quality

### Why this demonstrates AI engineering ability
- Multi-provider LLM/image integration with a swappable model abstraction
- Explicit prompt engineering (roles, constraints, few-shots, negatives, decoding params)
- Prompt chaining rather than single-shot generation
- Safety integration (Guardrails)
- Agent tool design + filesystem state contracts
- Model bake-off before selecting Nova Micro for text
- Iterative constraint solving for hard generative failure modes (text-in-image, faces)
- Honest de-scoping of Canva MCP after API capability research

---

# 4. Backend Engineering Analysis

## APIs

### Flask Video API (`flask-testing`)
- **Framework:** Flask + Flask-RESTful + Flask-SQLAlchemy (SQLite)
- **Endpoints:** 1 resource path × 4 methods = **4 operations**
  - `GET /video/<id>` — fetch or 404
  - `PUT /video/<id>` — create or 409 if exists (201)
  - `PATCH /video/<id>` — partial update or 404
  - `DELETE /video/<id>` — delete or 404 (204)
- **Request handling:** `reqparse` with required/optional args; `marshal_with` response shaping
- **Auth:** none (tutorial scope)

### Jira Forms API client (`jira-form-testing`)
- **Not a server you own** — client against Atlassian Forms Cloud API
- **5 operations:**
  1. GET form template
  2. PUT save form template
  3. DELETE form template
  4. GET project form index
  5. POST create form template
- **Auth:** Authorization header from env (Bearer-style via `AUTHORIZATION_HEADER`); example file also shows HTTP Basic with email/API token
- **Request/response:** JSON payload from `payload.JSON`; responses saved to `response.JSON`; non-200 exits with error

### AI systems
- Script/CLI entrypoints, not HTTP microservices
- External model APIs via AWS + Google SDKs

## Architecture

### Backend structure
- Four independent Python packages; no monorepo shared library
- LLM package uses inheritance (`BaseModel` → provider classes) + façade (`Generator`)
- Agent package separates orchestration / init / tools
- Flask uses classic Resource + ORM model pattern

### Service layers
- Thin: scripts call SDKs directly; Flask handlers talk to SQLAlchemy models
- No distinct domain service layer / repository pattern beyond Flask models

### Database interactions
- SQLite via SQLAlchemy `VideoModel` (`id`, `name`, `likes`, `views`)
- File-based JSON as pseudo-DB for AI pipelines

### Data models
- Event input schema: What/Who/When/Where/Why
- Event output schema: `{description, keywords[]}`
- Video ORM model
- Jira form design/publish payload (questions, sections, settings, publish targets)

### External APIs
- Bedrock, Gemini, Atlassian Jira Forms, (researched) Canva MCP

### Background jobs / queues
- **None found** (no Celery/RQ/SQS workers)

## Engineering Complexity

### Scalability
- Local CLI POCs; not horizontally scaled services
- Model abstraction would support swapping providers if productized
- Agent window + max_tokens limits show awareness of context cost

### Reliability
- Try/except around agent execution
- Stop-reason handling for guardrails and token limits
- File existence checks before overwrite/copy
- Jira status-code gating

### Error handling
- Flask `abort` with messages
- SystemExit if LLM input missing
- NotImplementedError for unsupported modality per model
- Agent errors logged; response nulled on failure

### Security
- Secrets via `.env` + gitignore
- Guardrails on Bedrock text path
- No auth on Flask tutorial API (expected for learning module)
- Jira credentials externalized

### Performance optimizations
- Limited evidence: model selection toward Nova Micro (smaller/cheaper) for text; lower temperatures for image prompts; image prompt length capped to reduce noise
- No caching, batching, or async request fan-out implemented

---

# 5. Automation and Workflow Analysis

| Automation | Manual process replaced | Workflow improvement | Technologies |
|---|---|---|---|
| Description + keyword generation | Writing marketing copy + keyword research by hand | Structured 5W → JSON assets in one run | Bedrock Converse, Nova Micro, Guardrails, prompt templates |
| Intermediate poster prompt generation | Human writing image prompts | Consistent style + constraints from description | LLM prompt chaining |
| Poster/image generation | Designer/Canva creation | Instant thematic visuals; style variants | SD3.5, Gemini Flash Img, Titan, Stability Core/Ultra, strands `generate_image` |
| Multi-agent generation | Multi-step human orchestration of tools/files | Agents read/write files, validate existence, index outputs | Strands Agents, custom tools, sliding window memory |
| Model bake-off script | Ad-hoc model trials | Same prompt across many models, logged to one file | Bedrock Prompt Management ARNs |
| Jira form template API scripting | Manual form UI ops / repeated clicks | Scripted CRUD for form templates | requests, Atlassian Forms API |
| Flask CRUD demo | N/A (learning) | Practice REST + ORM patterns | Flask-RESTful, SQLAlchemy |

**Scheduled tasks:** none found.  
**Data pipelines:** local file I/O only (input → JSON/PNG artifacts).

---

# 6. Metrics Extraction

## Code / artifact metrics (code evidence)

| Metric | Value |
|---|---|
| Python source files | 18 |
| Approx. Python LOC | ~1,283 |
| Markdown LOC (docs) | ~322 |
| Git commits on `main` history | 105 |
| Merged PRs | 8 |
| Distinct top-level project modules | 4 |
| Custom model classes in final OOP layer | 3 (+ abstract base) |
| Agent classes initialized | 2 |
| Custom Strands tools | 4 |
| Built-in strands tools wired | 5 (`python_repl`, `file_read`, `file_write`, `generate_image`, `image_reader`) |
| Flask API operations | 4 |
| Jira API operations exercised | 5 |
| Agent test scenarios | 5 |
| Models with recorded text outputs in bake-off | 23 |
| Total PNG artifacts | 124 |
| LLM-pipeline posters | 98 |
| — Gemini 2 Flash | 42 |
| — SD 3.5 Large | 47 |
| — Stable Image Core | 3 |
| — Stable Image Ultra | 1 |
| — Titan v1 | 1 |
| — Canvas reference | 4 |
| Agent-generated images | 14 |
| Agent-generated posters | 12 |
| Style params supported | 3 (professional, trendy, minimalistic) |
| Repo activity span | ~6 weeks (2025-06-19 → 2025-07-29) |

## Business / impact metrics

**None supported by repository evidence.**  
No time-saved, accuracy %, adoption, conversion, or revenue numbers appear in code or docs.

## Documentation-only notes (not quantitative impact)
- Onboarding states projects are **POCs**
- Commit notes unfinished multi-modal feedback loop
- Canva MCP unsupported for AI generation via Connect API (capability finding)

---

# 7. Technologies and Skills Demonstrated

## Software Engineering
- **Backend:** Flask, Flask-RESTful, request parsing, response marshalling, HTTP status semantics
- **Frontend:** none in this repo
- **APIs:** REST design (CRUD), third-party REST client (Jira), model inference APIs
- **Databases:** SQLite, SQLAlchemy ORM
- **Cloud:** AWS Bedrock (us-west-2 / us-east-2), IAM/CLI setup (documented), Google AI Studio keys
- **DevOps:** venv, pip requirements freeze, `.env` secrets, gitignore, PR-based workflow
- **Testing:** manual API test scripts, artifact-based visual eval harness, argparse test indexing

## AI
- **LLMs:** Bedrock Converse, multi-model evaluation, Nova Micro selection
- **Agents:** Strands multi-agent orchestration, tool calling, conversation windowing
- **Prompt Engineering:** system prompts, few-shots, constraints, negatives, decoding params, chaining
- **RAG:** not present
- **MCP:** researched/integrated Canva MCP client; deactivated after API gap
- **Evaluation:** qualitative model bake-off + visual corpus; no formal metrics pipeline
- **Automation:** event copy + poster generation pipelines; agent file workflows
- **Safety:** Bedrock Guardrails
- **Multimodal:** text→image pipelines; image_reader tool; planned multimodal feedback (unfinished)

## Product
- **User workflows:** 5W event intake → publishable description/keywords/poster
- **Business impact:** intended organizer time reduction (inferred; unmeasured)
- **Customer value:** faster event listing content creation (inferred)
- **Requirements:** no-text/no-face posters, SEO keywords, style variants, JSON contract, 16:9

### Accomplishment → tags map (quick index)

| Accomplishment | Tags |
|---|---|
| OOP model abstraction + Generator façade | Backend, APIs, LLMs, Automation |
| Prompt-chained poster pipeline | LLMs, Prompt Engineering, Automation |
| 23-model bake-off | LLMs, Evaluation |
| Guardrails integration | LLMs, Evaluation, Security |
| Strands dual-agent POC + custom tools | Agents, LLMs, Automation, MCP (research) |
| 5-scenario agent test harness | Evaluation, Testing, Automation |
| Flask Video CRUD API | Backend, APIs, Databases, Testing |
| Jira Forms API client + UI-derived payload | Backend, APIs, Integrations, Product |
| Canva MCP de-scope decision | MCP, Product, Requirements |

---

# 8. Resume Bullet Bank

Rules applied: no invented metrics; prefer ownership + outcomes; one line where possible.

## General SWE Resume

- Built an end-to-end Python POC that turns structured event details into description, SEO keywords, and thematic poster assets via chained LLM and image-model calls.
- Designed a provider-agnostic OOP generation layer (`BaseModel` + `Generator`) so text and image models from AWS Bedrock and Google Gemini could be swapped without rewriting the pipeline.
- Refactored separate text/image generators into a unified generation interface and saved outputs to a consistent JSON/PNG artifact layout.
- Implemented a multi-agent Strands workflow with custom tools for reading prior outputs, indexing poster filenames, copying artifacts, and validating files.
- Created a reproducible 5-scenario test harness that stores inputs, generated copy, and visual outputs for iterative prompt/agent debugging.
- Delivered a Flask-RESTful CRUD API on SQLite with request validation, response marshalling, and 404/409 error handling.
- Built a CLI client for Atlassian Jira Forms Cloud covering create/read/update/delete/list form-template operations using env-based auth.
- Drove work through 8 merged PRs over ~6 weeks, progressing from Bedrock experiments to an agentic event-generation POC.

## Backend SWE Resume

- Implemented a Flask + SQLAlchemy Video API with GET/PUT/PATCH/DELETE semantics, reqparse validation, and structured JSON responses.
- Integrated Amazon Bedrock Runtime (`converse` / `invoke_model`) and Google Gemini APIs behind a common generation interface with environment-configured secrets.
- Applied Bedrock Guardrails on text generation paths and handled agent stop reasons including guardrail intervention and max-token cutoffs.
- Built a Jira Forms API integration that posts UI-authored form designs (questions, sections, publish settings) and persists API responses for debugging.
- Used argparse CLIs and logging to make local generation and external API experiments repeatable across test cases.
- Encoded durable inter-step contracts via filesystem JSON so downstream poster generation consumes upstream description/keyword outputs reliably.

## AI/ML Resume

- Engineered a prompt-chained generative pipeline: event 5W → persuasive description/keywords → constrained image prompt → no-text/no-face poster.
- Evaluated 23 Bedrock foundation models on identical event prompts (Nova, Claude, Llama, DeepSeek, Mistral) and selected Nova Micro for the production-path text stage.
- Tuned system prompts, few-shot examples, negative prompts, temperatures/top-p, and length constraints to reduce unwanted text/faces in generated posters.
- Built a Strands Agents POC with Claude Sonnet 4, sliding-window memory, and tool-using Description and Poster agents for autonomous asset generation.
- Authored 4 custom agent tools to manage description/keyword I/O, poster indexing, artifact copy/cleanup, and file confirmation.
- Integrated multimodal image generation across Stability SD 3.5 Large, Gemini 2.0 Flash image, Titan, and Stability Core/Ultra, producing 100+ saved visual artifacts for qualitative evaluation.
- Researched Canva MCP via Strands MCPClient and intentionally removed live Canva generation after confirming AI image tools were unsupported by Canva Connect API.
- Documented setup for Bedrock model access, Guardrails, Gemini keys, and agent/MCP learning paths to make the POC reproducible.

## Product Resume

- Defined an organizer-facing event intake schema (What/Who/When/Where/Why) that maps directly to generated marketing copy and visuals.
- Translated product constraints—SEO keywords, short persuasive descriptions, 16:9 no-text posters, style variants—into enforceable prompt and agent instructions.
- Prototyped automation that replaces manual copywriting and poster design steps in event creation with a single generation run.
- Ran comparative model and visual experiments (including Canva reference outputs) to inform which generation approach fit event branding needs.
- Built Jira Forms API workflows to support structured issue/form creation, improving understanding of internal tooling around request intake.
- Scoped MCP/Canva integration down after capability research, protecting delivery focus on generation quality over unsupported integrations.
- Packaged onboarding docs so teammates can reproduce the event-generation POC and understand tradeoffs between direct LLM calls and agentic workflows.

---

# 9. Interview Story Extraction

## Most technically challenging parts

1. **Killing text/faces in generative posters**  
   Early poster prompts produced typography and people; solved via prompt redesign (photographic scene prompts), negative prompts, style constraints, model switching (SD vs Gemini vs Titan), and eventually a dedicated no-text poster agent path.

2. **Making agents reliably operate on the filesystem**  
   Agents needed to read JSON, write outputs, find next index, copy images, and clean temp files—leading to custom tools rather than relying only on `python_repl`.

3. **Unifying heterogeneous model APIs**  
   Bedrock Converse, Bedrock InvokeModel (base64 images), and Gemini multimodal parts each return different shapes; `BaseModel`/`Generator` normalize generate + extract + save.

4. **MCP/Canva integration dead-end**  
   Wired remote MCP client, listed tools, then discovered Canva AI generation wasn’t available through the Connect API path—required a product/engineering pivot.

## Biggest engineering decisions

- Direct LLM scripts → OOP model abstraction → unified Generator
- Multi-model bake-off before locking Nova Micro for text
- Prompt chaining (description → image prompt → image) instead of one-shot poster generation
- Dual-agent architecture with file-based handoff vs single agent doing everything
- Disable Canva MCP rather than ship a broken integration
- Use Guardrails on text path; leave commented/optional on agent path during testing

## Problems worth discussing in interviews

- How to evaluate generative systems without formal metrics (artifact corpora + scenario tests)
- Tool design for agents: when to write custom tools vs REPL
- Safety: Guardrails + negative prompts + stop-reason handling
- API client craftsmanship: reconstructing Jira form payloads from UI builder exports
- Tradeoff between determinism (scripted pipeline) and flexibility (agents)

## Tradeoffs made

| Decision | Tradeoff |
|---|---|
| POC CLI vs service API | Faster experimentation; no production auth/scale |
| Qualitative visual eval vs automated metrics | High signal for posters; weak quantitative claims |
| Smaller Nova Micro for text | Cost/latency win; possibly less prose quality than larger Claude/Llama |
| No-text posters | Better brand control; less “poster-like” typography |
| Remove Canva MCP | Less design-tool integration; more reliable local generation |
| Commit generated images | Reproducible demos; noisy git history / large artifacts |

## Lessons learned (supported by commits/docs)

- Inheritance/OOP pays off once multiple providers exist (“inheritance & OOP is such a pain” → later successful Generator refactor)
- Prompt iteration is first-class engineering work, not afterthought
- Agents need operational tools (index, copy, confirm), not only “generate”
- Research integrations against real API capabilities before committing delivery
- Explicit TODOs (stability image tool, multimodal feedback loop) show unfinished quality loops—good honesty in interviews

---

# Appendix A — Module Map

```
konfhub-internship/
├── llm-testing/               # Direct LLM + image generation POC
│   ├── classes/               # BaseModel, Generator, provider models
│   ├── i-o/                   # input, output.JSON, posters/
│   └── old testing/           # bake-off + pre-OOP scripts
├── strands-agent-testing/     # Agentic generation POC
│   ├── lib/                   # agent, init, tools
│   └── tests/1..5/            # scenario harness
├── flask-testing/             # REST + SQLite learning API
└── jira-form-testing/         # Atlassian Forms API client
```

# Appendix B — Merged PR Timeline

| PR | Title | Theme |
|---|---|---|
| #1 | Adding guardrails | Bedrock Guardrails |
| #2 | Poster generator | Description + poster generation |
| #3 | Flask tutorial completed | REST API learning |
| #4 | Jira form testing | Forms API integration |
| #5 | Model testing rework | OOP rewrite |
| #6 | Gemini testing | Gemini image generation |
| #7 | Generation integration | Unified Generator class |
| #8 | Strands agent | Agent POC |

# Appendix C — Explicit Gaps (cannot determine from repo)

- Production deployment status inside KonfHub
- User/customer adoption or NPS
- Measured time savings or conversion lift
- Formal internship title/dates beyond git window
- Content of external “Prompting Methods and Analysis” Google Doc
- Whether Flask/Jira work connected to a specific production ticket beyond learning/integration practice
- Absolute quality ranking of Gemini vs SD3.5 beyond folder volume and comments

---

*Generated from repository evidence for master resume database use. Prefer Confirmed contributions and Code evidence metrics when drafting resumes.*