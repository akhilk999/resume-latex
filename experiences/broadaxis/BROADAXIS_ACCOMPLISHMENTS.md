# Broadaxis — Accomplishments

Source: `BROADAXIS_CONTEXT.md`, repository analysis, and prior extraction.
Do not invent metrics. Do not write polished resume bullets here.
Detailed ownership inventory lives in `BROADAXIS_CONTEXT.md`. Architecture detail lives in `BROADAXIS_SYSTEM_DESIGN.md`. Numbers live in `METRICS.md`.

---

## Accomplishment 1 — Event Discovery Pipeline

### What I Built

Automated web search + scrape + score + insert pipeline that discovers industry events across 6 verticals nightly, finding 5–20 new events per run that the team would have missed via manual Google/spreadsheet research.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Built discovery engine (`discover.py`, ~113KB) with per-vertical seed phrases expanding into regional/type variants (capped at 24 queries)
  - Implemented multi-strategy scraping: curl_cffi browser-TLS impersonation primary, Playwright headless Chromium fallback
  - Added aggregator mining via LLM to extract official event URLs from listing pages (10times, Eventbrite, etc.)
  - Implemented JSON-LD + regex structured extraction, URL dedup with canonical_url tracking, and add-from-url for missed events
  - Split execution per-vertical to stay under Azure App Service B1 ~230s request timeout; scheduled via azure-pipelines-sweep.yml at 7 AM UTC

### Engineering Challenge

Anti-bot scraping, dual scrape strategies, B1 timeout batching, aggregator vs official-page strategy, future-dated event defenses

### Impact

6 verticals; nightly 5–20 new events; ~113KB discovery module; failure isolation per vertical

Automated manual event research; expanded discovery reach beyond what BD could cover by hand

### Evidence

`discover.py`, `search.py`, `fetch.py`, azure-pipelines-sweep.yml, `/api/internal/discovery-sweep`, `/api/crm/events/discover`, `/api/crm/events/add-from-url`

### Tags

Backend, Automation, AI

*Skills demonstrated:* Python, FastAPI, curl_cffi, Playwright, SearXNG, Serper, Azure DevOps

---

## Accomplishment 2 — AI Event Scoring System

### What I Built

Systematic, data-driven event evaluation with consistent recommendation bands replacing inconsistent gut-feel decisions.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Designed 5-dimension rubric (Meeting Potential 0–35, Attendee Quality 0–30, Vertical Alignment 0–20, Strategic Opportunity 0–10, Cost Efficiency 0–5)
  - Integrated DeepSeek LLM with temperature 0, structured JSON output, vertical-aware prompting, and scoring_history audit trail
  - Defined recommendation bands: Attend ≥80, Consider ≥65, Monitor ≥50, Skip <50
  - Validated output (known vertical labels, integer scores); conservative scoring when page content unavailable

### Engineering Challenge

Prompt engineering for skeptical B2B evaluation; structured output parsing with code-fence tolerance; staleness/rescore triggers

### Impact

5 scoring dimensions; 4 recommendation bands; page context up to 8,000 chars; 2 retries on 429

Enabled ROI-based event investment decisions with audit trail of every score

### Evidence

`score_event.py`, scoring_history table, events score_a–e columns, enrichment Phase 2

### Tags

AI, Backend, Architecture

*Skills demonstrated:* Python, DeepSeek, LLM prompt engineering, FastAPI

---

## Accomplishment 3 — CRM with Lifecycle Pipeline

### What I Built

Full-featured CRM connecting event attendance to the sales pipeline — contacts tracked from first meeting through closed deal.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Built contacts CRUD with 30+ fields, server-side pagination, multi-dimensional filtering, inline PATCH editing with field allowlisting
  - Implemented 7-stage lifecycle (new → engaged → qualified → opportunity → proposal → client → inactive) with funnel visualization and lifecycle-counts endpoint
  - Built relationship scoring (0–100) from recency (60%) + frequency (40%); referral network; profile endpoint aggregating interactions/follow-ups/meetings
  - Built companies CRUD with uniqueness, pipeline value aggregation, and rich linked views (contacts, deals, events)

### Engineering Challenge

Wide domain model (~200+ Event/CRM columns), relationship health, company name resolution, RBAC-aware ownership

### Impact

30+ contact fields; 7 lifecycle stages; ContactsPage ~1,986 lines

Closed the gap between event meetings and deal tracking; prevented lost contacts from events

### Evidence

contacts/companies APIs, crm_health.py, ContactsPage, CompaniesPage

### Tags

Full Stack, Database, Backend, Frontend

*Skills demonstrated:* Python, FastAPI, React, PostgreSQL

---

## Accomplishment 4 — Automated Enrichment Pipeline

### What I Built

Continuous event evaluation without manual effort — unscored and stale events scored, speaker data backfilled on a 4-hour schedule.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Built `agent/enrich.py` (~400 lines) in-process on App Service: Phase 1 re-scrape speakers/details; Phase 2 DeepSeek scoring
  - Staleness detection (never scored, new speakers, score >30 days old); 2s rate limit between LLM calls; 2-attempt retry on 429
  - Batched 4 events per run to stay under ~210s pipeline timeout; non-fatal per-event failures
  - Scheduled via azure-pipelines-enrich.yml at 0/4/8/12/16/20 UTC

### Engineering Challenge

Timeout-constrained batching, rate limits, graceful LLM degradation, deferred speakers from discovery sweeps

### Impact

Every 4 hours; 4 events/batch; ~400 lines agent; ~1–3.5 min typical duration

Keeps scoring current as new data arrives without BD intervention

### Evidence

`agent/enrich.py`, azure-pipelines-enrich.yml, `/api/internal/agent/enrich`, `/api/crm/events/{id}/enrich`

### Tags

Automation, AI, Backend

*Skills demonstrated:* Python, httpx, DeepSeek, Azure DevOps

---

## Accomplishment 5 — Multi-Tenant Architecture with RLS

### What I Built

Platform can serve multiple client organizations with guaranteed data isolation at the database level, without downtime or data leaks during migration.

**Ownership:** Likely primary architect (likely contribution)

### Technical Implementation

- Designed 7-phase rollout: nullable tenant_id → deploy schema → backfill + NOT NULL → per-tenant UNIQUE → RLS + cirklo_app role + DEFAULT → tenant_verticals → platform admin switcher
  - Implemented PostgreSQL FORCE ROW LEVEL SECURITY, auth_bootstrap escape hatch for pre-auth queries, acting_tenant_id for support views
  - Rehearsed end-to-end against local Postgres with real data + synthetic second tenant

### Engineering Challenge

Migrating live single-tenant app; ~100+ INSERTs unchanged via DEFAULT; table-owner/superuser RLS pitfalls; login before tenant is known

### Impact

25 tables with tenant_id; 7 rollout phases; rehearsed with synthetic second tenant

Unblocked multi-org SaaS path with defense-in-depth isolation

### Evidence

schema_postgres.sql RLS policies, dbconn tenant context, organizations/tenant_verticals

### Tags

Security, Database, Architecture

*Skills demonstrated:* PostgreSQL RLS, Python, FastAPI

---

## Accomplishment 6 — Dual-Database Abstraction Layer

### What I Built

Single codebase runs on SQLite (zero-config local) and PostgreSQL (prod with pooling/RLS) without maintaining two query paths.

**Ownership:** Likely primary architect (likely contribution)

### Technical Implementation

- Built `dbconn.py` with auto-detect, `?`→`%s` translation, datetime/NOW conversion, lastrowid via RETURNING + `_ID_TABLES`, RealDictRow-compatible access
  - Connection pooling via ThreadedConnectionPool; tenant context via `SET app.current_tenant_id`
  - Separate auth_bootstrap vs tenant-scoped connect paths

### Engineering Challenge

Dialect gaps (julianday, ILIKE, ON CONFLICT); silent `_ID_TABLES` failure mode; dual schema file maintenance

### Impact

One abstraction file; SQLite local + Azure PostgreSQL Flexible Server prod

Fast local iteration without Docker; production-grade DB features preserved

### Evidence

`dbconn.py`, db.py, schema_postgres.sql

### Tags

Database, Architecture, DevOps

*Skills demonstrated:* Python, SQLite, PostgreSQL, psycopg2

---

## Accomplishment 7 — RBAC with Granular Permissions

### What I Built

Controlled access for Admin/Partner/Member/Guest with fine-grained per-resource view/edit/delete permissions.

**Ownership:** Likely contributor to design and implementation (likely contribution)

### Technical Implementation

- Implemented 4 roles with default templates; 7 resources × 3 actions; ASGI `rbac_middleware`; frontend PermGate
  - Admin bypass; vertical filter for event visibility; SERVICE_TOKEN for `/api/internal/*`
  - Invite flow with 7-day tokens; PIN auth with bcrypt + plaintext auto-upgrade; 24h Bearer sessions

### Engineering Challenge

Middleware + per-endpoint enforcement; public path allowlist; pre-auth invite/login; frontend/server parity

### Impact

4 roles; 7 resources × 3 actions; 10 login attempts / 60s / IP rate limit

Safe sharing with partners/guests without oversharing CRM or settings

### Evidence

rbac_middleware, user_permissions, PermGate, auth endpoints

### Tags

Security, Full Stack

*Skills demonstrated:* Python, FastAPI, React, bcrypt

---

## Accomplishment 8 — Activity Audit System

### What I Built

Unified chronological feed of “what happened” across the CRM with real actor names (not “System”) and RBAC-scoped visibility.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Added actor columns to legacy tables (logged_by, sent_by, scheduled_by, updated_by)
  - Built UNION ALL merge of 7 sources into unified shape; type/date filters; pagination with separate count query
  - Centralized write-time `_log_activity()` on 40+ endpoints; non-admins see own contacts’ activities or own actions

### Engineering Challenge

Heterogeneous schemas/timestamps; retrofitting actor attribution; RBAC duplicated across count + data queries

### Impact

7 merged sources; 40+ endpoints logging; RBAC via contact_owner_id + actor_user_id

Accountability and activity review across the org

### Evidence

`/api/crm/activities`, activity_log table, actor FK columns

### Tags

Backend, Database

*Skills demonstrated:* Python, FastAPI, PostgreSQL

---

## Accomplishment 9 — AI Follow-up Generation

### What I Built

Professional follow-up drafts generated in seconds from interaction context, with user-driven LLM refinement.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Built DeepSeek draft generation (`crm_draft_followup.py`) from contact + interaction context; async subprocess spawn
  - Auto-create follow-ups on event interaction logging (2-day due date); queue with priority 1–4; status/channel/source tracking
  - Follow-up refine endpoint: user suggestions → LLM revision

### Engineering Challenge

Async subprocess IPC; graceful fallback when LLM unavailable; queue + overdue detection

### Impact

Draft + refine use cases; 2-day default due; priority levels 1–4

Reduced time to draft professional follow-ups from minutes to seconds

### Evidence

crm_draft_followup.py, `/api/crm/followups/{id}/draft`, `/api/crm/followups/refine`, `/api/crm/queue`

### Tags

AI, Backend

*Skills demonstrated:* Python, DeepSeek, FastAPI

---

## Accomplishment 10 — CSV/XLSX Attendee Import

### What I Built

One-click import of event attendee spreadsheets into contacts + event linkages, replacing hours of manual entry.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Two-phase flow: upload → preview → commit; CSV and XLSX with auto-detection (openpyxl)
  - Auto-column mapping via keyword fuzzy match; email dedup; name+company fallback matching
  - Creates event_contacts AND event_attendees; import history with created/matched/total counts

### Engineering Challenge

Schema variance across spreadsheets; safe preview/commit; contact matching edge cases

### Impact

Auto-maps name/email/title/company/linkedin/phone/notes; dual format support

Turned hours of manual contact entry into a preview-and-commit operation

### Evidence

`/api/crm/attendees/import`, attendee_imports table, EventsPage import UI

### Tags

Full Stack

*Skills demonstrated:* Python, FastAPI, openpyxl, React

---

## Accomplishment 11 — Kanban Deal Pipeline

### What I Built

Visual deal management from prospect to close with stage transitions, probability, and value aggregation.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Built 6-stage pipeline (Prospect → Discovery → Proposal → Negotiation → Closed Won → Closed Lost)
  - Deal CRUD with field cleaning; stage movement endpoint with activity logging; board aggregated by stage
  - Frontend Kanban with @dnd-kit drag-and-drop; contact-linked deals with joins

### Engineering Challenge

Stage-specific fields (probability, close date, lost reason); consistent board aggregates

### Impact

6 deal stages; pipeline board API + drag-and-drop UI

Visual pipeline management for tracking deals from prospect to close

### Evidence

crm_deals.py, `/api/crm/pipeline/board`, `/api/crm/deals/{id}/stage`

### Tags

Full Stack, Frontend

*Skills demonstrated:* React, @dnd-kit, FastAPI, PostgreSQL

---

## Accomplishment 12 — Event Document Management

### What I Built

Centralized event-related documents accessible securely without email/file shares.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Backend-proxied upload to Azure Blob Storage with extension allowlist and 25MB size limit
  - Time-limited SAS URLs (15-minute expiry) for view/download; category tagging; optional contact association
  - Linked documents to events with metadata in event_documents

### Engineering Challenge

Content validation before blob write; SAS expiry; proxied vs direct-to-blob tradeoff

### Impact

12 supported file types; 25MB limit; 15-minute SAS expiry

Single place for meeting notes, contracts, presentations tied to events

### Evidence

event_documents APIs, Azure event-documents container

### Tags

Full Stack, Cloud

*Skills demonstrated:* Python, FastAPI, Azure Blob Storage, React

---

## Accomplishment 13 — Automated Relationship Decay

### What I Built

CRM relationship levels stay honest — stale contacts automatically downgraded so pipeline metrics aren’t inflated.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Rules engine: warm/known_contact → cold after 180 days no touch; active_client → known_contact after 90 days
  - Batch UPDATE with rowcount reporting; health scoring and cold-contact detection via crm_health.py
  - is_active from relationship_level + days since last touch (≤180 days)

### Engineering Challenge

Threshold tuning; batch safety; interaction with relationship scoring

### Impact

180-day and 90-day decay thresholds; manual trigger POST `/api/crm/contacts/decay`

Maintains CRM data quality by flagging stale relationships automatically

### Evidence

crm_health.py, decay endpoint, relationship_level fields

### Tags

Automation, Backend

*Skills demonstrated:* Python, FastAPI, PostgreSQL

---

## Accomplishment 14 — CI/CD Pipeline

### What I Built

Continuous deployment of frontend and backend on every push to main, gated by health checks.

**Ownership:** Primary for Event/CRM deploy path (confirmed for pipelines supporting this platform)

### Technical Implementation

- Azure DevOps pipeline: frontend npm ci/build → Static Web Apps → health check; backend RLS enable → strip secrets → bundle agent → ZIP → Kudu zipdeploy → force pip install → `/docs` health check
  - Secrets via cirklo-secrets variable group + App Service Application Settings; never ship config.json/search_log.txt

### Engineering Challenge

B1 has no staging slots; Kudu basic auth zipdeploy; hard health-check gates; Playwright/Docker image considerations

### Impact

4 YAML pipeline definitions; 10+ steps per deploy; dual health checks as hard gates

Reliable shipping without manual deploy rituals

### Evidence

azure-pipelines.yml, Kudu deploy steps, www.cirklo.ai

### Tags

DevOps, Cloud

*Skills demonstrated:* Azure DevOps, Bash, Kudu, Azure Static Web Apps, App Service

---

## Accomplishment 15 — Scheduled Pipeline Automation

### What I Built

Fully automated event pipeline (discovery + enrichment) requiring zero manual intervention within B1 timeout constraints.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Nightly per-vertical discovery sweep with failure isolation and per-vertical count summaries
  - 4-hourly enrichment with batch size 4, retry loop (2 attempts, 30s delay), non-fatal LLM warnings
  - Pipeline-level orchestration aggregating results across verticals/batches

### Engineering Challenge

Fixed ~230s App Service timeout; orchestrating many short calls vs one long request

### Impact

Sweep daily 7 AM UTC; enrich every 4 hours; 6 verticals; 4 events/enrichment batch

Hands-off continuous event intelligence

### Evidence

azure-pipelines-sweep.yml, azure-pipelines-enrich.yml, internal discovery/enrich endpoints

### Tags

DevOps, Automation

*Skills demonstrated:* Azure DevOps, Bash, FastAPI internal APIs

---

## Accomplishment 16 — Contact Duplicate Detection

### What I Built

Data-quality tool that surfaces duplicate contact pairs before relationship history fragments.

**Ownership:** Primary architect and implementer (confirmed)

### Technical Implementation

- Detection by identical email OR same company + similar name (≥70% token overlap via Jaccard on word tokens)
  - Configurable result threshold endpoint for review

### Engineering Challenge

Fuzzy name matching false positives/negatives; email vs name+company strategies

### Impact

≥70% token overlap threshold; email-exact OR company+name similarity

Prevents duplicate entries and fragmented relationship history

### Evidence

`/api/crm/contact-duplicates`

### Tags

Backend, Database

*Skills demonstrated:* Python, Jaccard similarity, FastAPI, PostgreSQL
