# Broadaxis — Metrics

Never invent numbers. Values below are taken only from `BROADAXIS_ACCOMPLISHMENTS.md`, `BROADAXIS_SYSTEM_DESIGN.md`, and manager confirmation in `REFERENCES/REFERENCES.md`. Prefer provenance.

**Production tenancy (qualitative, confirmed):** Rohan Mandrekar confirmed the product has **actual tenants** (multiple client organizations). No numeric count is available — claim existence only.


---

# Technical Metrics

## Confirmed

Exact or tightly specified numbers stated as product/system facts (schema, config, schedules, code measurements, or observed pipeline outcomes).

### Platform scale

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Database tables | 25 | tables | Accomplishments Metrics; System Design Schema Size | System Design also says 17 data + 8 branding. Accomplishments lists 22 named + 7 branding in the parenthetical — do not claim a more precise breakdown than “25 tables” without reconciling. |
| Foreign key relationships | ~60 | relationships | System Design Schema Size | Approximate count from schema design section. |
| Event table columns | 35+ | columns | Accomplishments; System Design | Includes scoring dimensions and ROI fields. |
| Contact fields / columns | 30+ | fields / columns | Accomplishments; System Design | |
| Event fields editable | 25+ | fields | Accomplishments Event CRUD | |
| REST API endpoints (platform) | ~100+ | endpoints | Accomplishments Metrics; Complexity notes | Approximate; spans `/api/crm/*`, auth, pipeline, analytics, admin, settings, internal. |
| Activity write-time logging | 40+ | endpoints | Accomplishments Activity / Accomplishment 8 | `_log_activity()` call sites. |
| Activity feed sources | 7 | sources | Accomplishments; System Design | interactions, follow_ups, meetings, deals, event_contacts, attendee_imports, activity_log. |
| Cloud services used | 4 | services | Accomplishments Metrics | Static Web Apps, App Service, PostgreSQL Flexible Server, Blob Storage. |
| CI/CD pipeline YAML definitions | 4 | files | Accomplishments Metrics / Accomplishment 14 | |
| CI/CD steps per deployment | 10+ | steps | Accomplishments Metrics / Accomplishment 14 | Build, deploy, health checks, RLS, strip secrets, bundle, ZIP, Kudu, pip, backend health. |
| Frontend health-check retries | 10 | retries | System Design CI/CD | |
| Backend health-check retries | 12 | retries | System Design CI/CD | |
| Multi-tenancy rollout phases | 7 | phases | Accomplishments; System Design | |
| Tables with `tenant_id` | 25 | tables | Accomplishment 5 | Same “25 tables” figure as schema size. |
| Per-tenant indexes | all data tables (`idx_*_tenant_id`); Accomplishments also says 24 data tables | indexes / tables | Accomplishments Indexing; System Design | Prefer “per-tenant indexes on data tables” over inventing an exact table count beyond what’s consistent with 25 total. |

### Event discovery & scoring

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Event verticals | 6 | verticals | Accomplishments; System Design | Naming varies across sections (e.g. Workforce vs Private Equity). Claim “6 verticals,” not a specific list, unless reconciled. |
| Discovery query cap | 24 | queries | Accomplishments Discovery | Per-vertical seed expansion capped at 24. |
| Future event rejection window | >365 | days out | Accomplishments Discovery | Rejects events more than 365 days in the future. |
| Stale / old event rejection | >1 | year old | Accomplishments Discovery | |
| Scoring dimensions | 5 | dimensions | Accomplishments; System Design | Meeting Potential, Attendee Quality, Vertical Alignment, Strategic Opportunity, Cost Efficiency. |
| Score weight — Meeting Potential | 0–35 | points | Accomplishments; System Design | Dimension a. |
| Score weight — Attendee Quality | 0–30 | points | Accomplishments; System Design | Dimension b. |
| Score weight — Vertical Alignment | 0–20 | points | Accomplishments; System Design | Dimension c. |
| Score weight — Strategic Opportunity | 0–10 | points | Accomplishments; System Design | Dimension d. |
| Score weight — Cost Efficiency | 0–5 | points | Accomplishments; System Design | Dimension e. |
| Recommendation bands | 4 | bands | Accomplishments; System Design | Attend / Consider / Monitor / Skip. |
| Attend threshold | ≥80 | score | Accomplishments; System Design | |
| Consider threshold | ≥65 | score | Accomplishments; System Design | |
| Monitor threshold | ≥50 | score | Accomplishments; System Design | |
| Skip threshold | <50 | score | Accomplishments; System Design | |
| Scoring page context limit | 8,000 | characters | Accomplishments; System Design AI | From speakers_raw/notes. |
| Scoring temperature | 0 | temperature | Accomplishments; System Design | Deterministic scoring. |
| Content-generation temperature | 0.7 | temperature | Accomplishments; System Design | Summaries / drafts / refine. |
| LLM retries on 429 | 2 | attempts | Accomplishments; System Design | |
| Enrichment inter-call sleep | 2 | seconds | Accomplishments Enrichment | Between DeepSeek calls. |
| Score staleness rescore trigger | >30 | days | Accomplishments; System Design | Also: never scored, or new speaker data. |
| Nightly discovery new events | 5–20 | events / run | Accomplishments Metrics / Accomplishment 1 | Observed nightly outcome across verticals. |
| Nightly sweep schedule | Daily 7 AM UTC | schedule | Accomplishments; System Design | |
| Nightly sweep duration | ~5–10 | minutes | System Design Automation | Typical duration. |
| Enrichment schedule | Every 4 hours (0/4/8/12/16/20 UTC) | schedule | Accomplishments; System Design | |
| Enrichment batch size | 4 | events / batch | Accomplishments; System Design | Fits B1 timeout. |
| Enrichment typical duration | ~1–3.5 | minutes | Accomplishments Accomplishment 4; System Design | |
| Enrichment pipeline retry | 2 attempts, 30s delay | retries / delay | Accomplishments Scheduled Automation | |
| App Service request timeout | ~230 | seconds | Accomplishments; System Design | Fixed B1 constraint. |
| Enrichment pipeline timeout budget | ~210 | seconds | Accomplishments Enrichment | Pipeline timeout used for batching. |

### CRM & product rules

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| CRM lifecycle stages | 7 | stages | Accomplishments; System Design | new → engaged → qualified → opportunity → proposal → client → inactive. |
| Deal pipeline stages | 6 | stages | Accomplishments; System Design | Prospect → Discovery → Proposal → Negotiation → Closed Won → Closed Lost. |
| Relationship score scale | 0–100 | score | Accomplishments Contacts | |
| Relationship score weights | recency 60% + frequency 40% | percent | Accomplishments Contacts | |
| Decay: warm/known_contact → cold | 180 | days no touch | Accomplishments; System Design | |
| Decay: active_client → known_contact | 90 | days | Accomplishments; System Design | |
| `is_active` touch window | ≤180 | days | Accomplishments Relationship Decay | Combined with relationship_level. |
| Duplicate name similarity | ≥70 | % token overlap | Accomplishments Duplicate Detection | Jaccard on word tokens; OR identical email. |
| Follow-up default due | 2 | days | Accomplishments; System Design | On event interaction logging. |
| Follow-up priority levels | 1–4 | levels | Accomplishments Follow-ups | |
| Contact AI summary length | 2–3 | sentences | Accomplishments; System Design | |
| Interactions used in contact summary | last 5 | interactions | Accomplishments; System Design | |
| AI use cases (Event/CRM-related) | 5 | use cases | Accomplishments Metrics | Event scoring, contact summaries, follow-up drafts, follow-up refinement, aggregator mining. Branding content exists but is not Akhil’s platform. |
| Automations | 4+ | automations | Accomplishments Metrics | Discovery sweep, enrichment, relationship decay, follow-up auto-generation. |
| Scheduled pipelines | 2 | pipelines | Accomplishments Metrics | Nightly sweep + enrichment. |

### Auth, security, uploads

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| User roles | 4 | roles | Accomplishments; System Design | Admin, Partner, Member, Guest. |
| Permission resources | 7 | resources | Accomplishments; System Design | events, crm, branding, pipeline, analytics, settings, users. |
| Permission actions | 3 | actions | Accomplishments; System Design | can_view, can_edit, can_delete. |
| Session lifetime | 24 | hours | Accomplishments; System Design | Bearer tokens in `user_sessions`. |
| Invite token expiry | 7 | days | Accomplishments Auth | |
| Login rate limit | 10 attempts / 60s / IP | attempts / window | Accomplishments; System Design | In-memory. |
| PIN length | 6 | digits | System Design Auth | Numeric PIN. |
| Document upload size limit | 25 | MB | Accomplishments; System Design | Backend validation before blob write. |
| Supported upload file types | 12 | types | Accomplishments Metrics / Accomplishment 12 | Across CSV, XLSX, PDF, DOC, DOCX, XLS, XLSX, PPT, PPTX, JPG, PNG, TXT (XLS/XLSX listed twice in format list — claim “12 file types” as stated, or list unique extensions carefully). |
| SAS URL expiry | 15 | minutes | Accomplishments; System Design | View/download. |

### Infrastructure SKUs (stated)

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| App Service tier | B1 Basic | SKU | System Design | 1 vCPU, 1.75 GB RAM. |
| App Service CPU | 1 | vCPU | System Design | |
| App Service RAM | 1.75 | GB | System Design | |
| PostgreSQL SKU | Standard_B1ms | SKU | System Design | |
| PostgreSQL CPU (stated) | 1 | vCPU | System Design diagram | |
| Static Web Apps tier | Free | SKU | System Design | |
| Frontend region | eastus2 | region | System Design Azure Resources | |
| Backend / DB / Storage region | southcentralus | region | System Design | |

### Code size (measured in docs)

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Backend monolith (`main.py`) | ~5,000 | lines | Accomplishments; System Design | Approximate. |
| Scripts | ~2,000 | lines | Accomplishments Metrics | Approximate. |
| Agent module (`agent/enrich.py`) | ~400 | lines | Accomplishments Enrichment | Approximate. |
| Discovery module (`discover.py`) | ~113 | KB | Accomplishments Discovery | File size, not LOC. |
| ContactsPage | 1,986 | lines | Accomplishments Metrics | |
| EventsPage | 1,775 | lines | Accomplishments Metrics | |
| TasksPage | 1,393 | lines | Accomplishments Metrics | |
| CompaniesPage | 417 | lines | Accomplishments Metrics | |
| Subprocess spawn overhead | ~100 | ms | System Design Tradeoffs | Stated as tradeoff cost. |
| Scoring prompt length | ~200 | words | System Design AI | Rubric instructions. |
| INSERTs unchanged via tenant DEFAULT | ~100+ | inserts | Accomplishment 5; System Design Key Decisions | Approximate count of inserts that did not need explicit `tenant_id`. |

---

## Estimated

Numbers the source docs themselves label as estimates, or approximate aggregates without a precise measurement method.

| Name | Value | Unit | Confidence | Source | Notes |
|------|-------|------|------------|--------|-------|
| Total LOC (Event + CRM, backend + frontend) | ~10,000+ | lines | Estimated | Accomplishments Estimated Metrics | Aggregate estimate; do not tighten. |
| Event & CRM database columns | ~200+ | columns | Estimated | Accomplishments Estimated Metrics; System Design Schema Size | Same figure appears in both; still an aggregate estimate. |
| Event + CRM endpoint handlers | ~80+ | handlers | Estimated | Accomplishments Estimated Metrics | Subset of platform ~100+ endpoints. |
| Scrape success (curl_cffi primary path) | ~90%+ | success rate | Estimated / design note | System Design Event Discovery design notes | No measurement method or time window given — treat as soft estimate, not a resume headline. |

---

# Business Metrics

No quantified business outcomes (revenue, win rate, hours saved with study, customer counts) appear in the source documents. Qualitative business impact belongs in accomplishments / interview guide — not as invented metrics here.

# Awards / Recognition

None recorded for this experience in the source documents.

# Metrics To Avoid

Qualitative impact, unverified business outcomes, hypotheticals, or capabilities without measured values. Do not invent numbers for these.

### Business / product impact (no measured values in sources)

| Claim in sources | Why not claim as a metric |
|------------------|---------------------------|
| Discovery finds events “the team would have missed” | Outcome narrative only; no miss-rate or before/after study. The **5–20 events/run** figure is claimable; the “would have missed” framing is not quantified. |
| “Reduced professional follow-up drafting from minutes to seconds” | No timed study, sample size, or baseline. Qualitative only. |
| “Turned hours of manual contact entry … into one-click import” | No measured hours saved or import volume. |
| “Replaced gut-feel event evaluation” | Process change, not a measured accuracy/ROI lift. |
| “zero-manual-intervention” discovery/enrichment | Operational intent; exceptions (failures, retries, manual triggers for decay) exist. |
| Exact tenant / customer organization count or names | Manager (Rohan Mandrekar) confirmed **actual tenants exist** in production. Count and identities are **not** recorded — claim existence only, never invent N or names. |
| Dashboard stats (leads, pipeline $, win rate, 30-day deltas, etc.) | Features that **compute** these exist; no actual production values are recorded in the source docs. |
| Per-event ROI “stored as percentage” | Mechanism exists; no example ROI % or lift is given. |
| Pipeline value / weighted pipeline / conversion analytics | Analytics capabilities only — no reported figures. |

### Speculative / scaling hypotheticals (System Design Scaling)

| Hypothetical | Why not claim |
|--------------|---------------|
| “More verticals (e.g. 100)” | Example scale scenario, not current state. |
| “Activity feed growth (1M+ rows)” | Future scaling consideration. |
| Precision/recall of scored Attend events | Called out as something to measure later — not measured. |
| LLM cost, quality A/B, hallucination rates | Monitoring suggestions only. |
| Multi-instance Redis rate limits / Celery | Future architecture, not shipped metrics. |

### Ownership / attribution boundaries

| Item | Why not claim |
|------|---------------|
| Branding platform metrics or deliverables | Explicitly built by a separate team member. |
| Auth / RBAC / multi-tenancy / `dbconn.py` as sole primary ownership | Accomplishments mark these as **likely** (not confirmed) contributions. Do not claim sole ownership metrics for them. |
| Exact vertical name list as a single canonical set | Docs disagree on labels (Workforce vs Private Equity, etc.). Claim count (6), not an unverified named set. |
| Exact branding vs data table split beyond “25 tables” | Parenthetical counts in Accomplishments vs System Design disagree (17+8 vs 22+7). Do not invent a reconciled breakdown. |

### Soft numbers that look measurable but lack provenance

| Item | Guidance |
|------|----------|
| curl_cffi “~90%+ success” | Do not use on resume without a measurement method / window. |
| “Team size of 1–2 engineers” | Tradeoff context only; not an impact metric. |
| Any user count, MAU, revenue, deal $ closed, meetings completed, or win rate | **Not present** in either source document. |

---

## Metric Registry (structured)

Use these entries when promoting a number into bullets. Prefer Confirmed over Estimated; never use “Should Not Be Claimed.”

### Metric 1 — Nightly discovery yield

- Name: New events discovered per nightly sweep
- Value: 5–20
- Unit: events per run
- Measurement method: Nightly discovery pipeline outcome (stated observed range)
- Time window: Per nightly run across verticals
- Confidence: Confirmed (observed range in accomplishments)
- Source: `BROADAXIS_ACCOMPLISHMENTS.md` (Metrics; Accomplishment 1)
- Notes: Safe resume metric; do not add “events BD would have missed” as quantified impact

### Metric 2 — Event verticals

- Name: Industry verticals covered by discovery
- Value: 6
- Unit: verticals
- Measurement method: Product configuration / pipeline design
- Time window: N/A (system constant)
- Confidence: Confirmed
- Source: Accomplishments; System Design
- Notes: Do not assert a specific name list without reconciling doc inconsistencies

### Metric 3 — AI scoring rubric

- Name: Scoring dimensions and recommendation bands
- Value: 5 dimensions; 4 bands (Attend ≥80, Consider ≥65, Monitor ≥50, Skip <50)
- Unit: dimensions / bands / score thresholds
- Measurement method: Product rubric design
- Time window: N/A
- Confidence: Confirmed
- Source: Accomplishments; System Design Scoring Rubric
- Notes: Weights 0–35 / 0–30 / 0–20 / 0–10 / 0–5 are confirmed

### Metric 4 — Enrichment cadence and batching

- Name: Enrichment schedule and batch size
- Value: Every 4 hours; 4 events per batch; ~1–3.5 min typical
- Unit: schedule / events / minutes
- Measurement method: Azure pipeline schedule + B1 timeout batching design; typical duration stated
- Time window: Ongoing scheduled runs
- Confidence: Confirmed (schedule/batch); duration approximate as stated
- Source: Accomplishments; System Design Automation
- Notes: Tied to ~210s pipeline / ~230s App Service timeout constraints

### Metric 5 — Schema and API surface

- Name: Tables and API scale
- Value: 25 tables; ~100+ REST endpoints; 7 activity sources; 40+ audit call sites
- Unit: tables / endpoints / sources
- Measurement method: Schema and codebase inventory stated in docs
- Time window: N/A
- Confidence: Confirmed as documented approximations where marked with ~
- Source: Accomplishments Metrics; System Design
- Notes: Use “~” where sources use “~”; do not invent tighter counts

### Metric 6 — CRM pipeline structure

- Name: Lifecycle and deal stages
- Value: 7 contact lifecycle stages; 6 deal stages
- Unit: stages
- Measurement method: Product domain model
- Time window: N/A
- Confidence: Confirmed
- Source: Accomplishments; System Design CRM
- Notes: Claimable structural metrics; no conversion rates attached

### Metric 7 — Relationship decay thresholds

- Name: Stale relationship decay windows
- Value: 180 days (warm/known → cold); 90 days (active_client → known_contact)
- Unit: days
- Measurement method: Implemented decay rules
- Time window: N/A (rule thresholds)
- Confidence: Confirmed
- Source: Accomplishments Contact Health; Accomplishment 13
- Notes: Do not claim “X% of contacts decayed” — not measured

### Metric 8 — Document security limits

- Name: Upload size and SAS expiry
- Value: 25 MB max; 15-minute SAS URLs; 12 supported file types
- Unit: MB / minutes / types
- Measurement method: Backend validation and Blob SAS config
- Time window: N/A
- Confidence: Confirmed
- Source: Accomplishments Event Documents; System Design Failure Modes
- Notes: Good systems metrics; not business-impact metrics

### Metric 9 — Auth rate limit and session

- Name: Login rate limit and session TTL
- Value: 10 attempts / 60 seconds / IP; 24-hour sessions; 7-day invites
- Unit: attempts / seconds / hours / days
- Measurement method: Auth implementation
- Time window: N/A
- Confidence: Confirmed
- Source: Accomplishments Auth; System Design Auth
- Notes: Ownership of auth is “likely,” not confirmed primary — be careful in bullets

### Metric 10 — Estimated total LOC

- Name: Event + CRM total lines of code
- Value: ~10,000+
- Unit: lines
- Measurement method: Aggregate estimate in accomplishments
- Time window: N/A
- Confidence: Estimated
- Source: Accomplishments Estimated Metrics
- Notes: Prefer more precise page/module line counts (ContactsPage 1,986, etc.) when a single number is needed

### Metric 11 — Do not claim: follow-up time saved

- Name: Follow-up draft time reduction
- Value: “minutes to seconds” (qualitative only)
- Unit: N/A
- Measurement method: None recorded
- Time window: None
- Confidence: Should not be claimed as a metric
- Source: Business Impact / Accomplishment 9 narrative
- Notes: May describe the feature; do not put a numeric time-saved claim on the resume

### Metric 12 — Do not claim: business dashboard KPIs

- Name: Leads, pipeline revenue, win rate, ROI %
- Value: Not stated
- Unit: N/A
- Measurement method: Feature exists; values not extracted
- Time window: None
- Confidence: Should not be claimed
- Source: Accomplishments Analytics (feature list only)
- Notes: Never invent production CRM/revenue figures
