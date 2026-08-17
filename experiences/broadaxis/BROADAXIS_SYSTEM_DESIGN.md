# Broadaxis — System Design

> **Purpose:** Interview-ready system design. Only technically supported information.
> **Author:** Akhil (Event & CRM platforms)
> **Sources:** `BROADAXIS_CONTEXT.md`, `BROADAXIS_ACCOMPLISHMENTS.md`
> **Last Updated:** 2026-07-23

# Overview

Cirklo is a B2B CRM + event-intelligence platform originally built for BroadAxis, a consulting firm focused on AI modernization for government, oil & gas, staffing, private equity, and Microsoft enterprise customers. The platform automates the end-to-end workflow from discovering industry events → evaluating them with AI scoring → tracking contacts met at events → managing the sales pipeline through to closed deals.

The system is a monolithic Python/FastAPI backend with a React SPA frontend, deployed on Azure with PostgreSQL, Blob Storage, and CI/CD via Azure DevOps. It supports multi-tenant isolation through PostgreSQL Row-Level Security. **Production tenancy:** manager-confirmed **actual tenants** use the product (no claimed count/names). Treat detailed product contents as NDA-sensitive for external discussion; this design doc is for personal engineering prep.

Akhil was the primary engineer for the Event and CRM platforms. The Branding platform was built by a separate team member.

# Architecture

```
┌─────────────────────────────────────────────────────────┐
│                      User Browser                       │
│                  (React 19 SPA, Vite)                   │
└─────────────┬───────────────────────────────┬───────────┘
              │                               │
              ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────┐
│   Azure Static Web App  │────▶│    Azure App Service    │
│   (www.cirklo.ai)       │     │    (FastAPI, Python 3)  │
│   Free tier             │     │    B1 Basic (1vCPU)     │
└─────────────────────────┘     └───────────┬─────────────┘
                                            │
                              ┌─────────────┼─────────────┐
                              │             │             │
                              ▼             ▼             ▼
                    ┌──────────────┐ ┌──────────┐ ┌──────────────┐
                    │  PostgreSQL  │ │  Azure   │ │   DeepSeek   │
                    │  Flexible Srv│ │  Blob    │ │   LLM API    │
                    │  B1ms, 1vCPU │ │  Storage │ │  (scoring,   │
                    │  southcentral│ │  Standard│ │   content)   │
                    └──────────────┘ └──────────┘ └──────────────┘
```

### Stack Summary

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Frontend | React 19 + Vite 8 + Tailwind CSS 4 | SPA with client-side routing |
| Backend | FastAPI (Python 3.12) | REST API, ~5,000 lines monolithic app |
| Database | PostgreSQL 16 (prod) / SQLite (dev) | Dual-backend via abstraction layer |
| File Storage | Azure Blob Storage | Event documents (meeting notes, contracts) |
| AI/LLM | DeepSeek (`deepseek-chat`) | Event scoring, summaries, follow-up drafts |
| Scraping | curl_cffi + Playwright fallback | Multi-strategy web scraping |
| Search | Serper API (primary) + SearXNG (fallback) | Web search for event discovery |
| CI/CD | Azure DevOps Pipelines | Build + deploy + scheduled jobs |
| Auth | PIN + bcrypt + Bearer tokens | Stateless auth with 24h sessions |

### Azure Resources

| Resource | Hostname | SKU | Region |
|----------|----------|-----|--------|
| Frontend | www.cirklo.ai (Static Web App) | Free | eastus2 |
| Backend | cirklo-api-h5dqhscufkf9e2hg (App Service) | B1 Basic | southcentralus |
| Database | cirklo-db.postgres.database.azure.com | Standard_B1ms | southcentralus |
| Storage | cirklostorageacc → event-documents | Standard | southcentralus |

### Secrets Management
- **Pipeline secrets:** Azure DevOps Variable Group `cirklo-secrets` (DATABASE_URL, KUDU_USERNAME, KUDU_PASSWORD, AZURE_STATIC_WEB_APPS_API_TOKEN, CIRKLO_API_URL, SERVICE_TOKEN)
- **Runtime secrets:** App Service Application Settings (DB connection string, storage keys, API keys)
- **Never shipped:** config.json and search_log.txt deleted before packaging

### Dual-database abstraction

**My contribution: Likely primary architect.**

`dbconn.py` enables a single codebase on SQLite (local) and PostgreSQL (prod).

```
Application Code
       │
       ▼
   dbconn.connect(tenant_id=..., auth_bootstrap=...)
       │
       ├── DATABASE_URL/PGHOST set? → psycopg2 ThreadedConnectionPool
       └── else                     → sqlite3.connect(DB_PATH)
```

| Feature | SQLite | PostgreSQL | Handling |
|---------|--------|------------|----------|
| Placeholders | `?` | `%s` | Regex auto-translation |
| Date function | `datetime('now')` | `NOW()` | Regex translation |
| Date function | `date('now')` | `CURRENT_DATE` | Regex translation |
| Row access | `row['col']` / `row[0]` | RealDictRow supports both | Identical API |
| lastrowid | Native | Emulated via RETURNING id | Gated by _ID_TABLES |
| Connection pool | N/A | ThreadedConnectionPool | Automatic |
| Tenant context | N/A | SET app.current_tenant_id | Via tenant_id param |

**Known gaps:** `julianday()` (SQLite-only), `ILIKE` (Postgres-only), `ON CONFLICT` (conditional via `IS_POSTGRES`), `_ID_TABLES` must be updated manually.

---

### Multi-tenancy

**My contribution: Likely primary architect.**

#### Rollout Phases
1. Schema preparation: nullable `tenant_id` on all 25 tables
2. Deploy schema: idempotent ALTER TABLE
3. Backfill + lock: BroadAxis org, SET NOT NULL
4. Per-tenant constraints: (tenant_id, url) UNIQUE replacing global UNIQUE
5. RLS enablement: `cirklo_app` role, FORCE RLS, DEFAULT on tenant_id
6. Per-tenant configuration: tenant_verticals, brand_voice_prompt
7. Platform admin: acting_tenant_id on sessions

#### RLS Design
```sql
SET app.current_tenant_id = '1';

ALTER TABLE events ALTER COLUMN tenant_id SET DEFAULT app_current_tenant_id();

CREATE POLICY tenant_isolation ON events
  USING (tenant_id = current_setting('app.tenant_id')::int
         OR current_setting('app.is_platform_admin') = 'true');

CREATE POLICY auth_bootstrap ON users
  USING (current_setting('app.auth_bootstrap') = 'true');
```

---

# Components

### 1. Event Discovery Platform

**My contribution: Primary architect and implementer.**

#### Responsibilities
- Automated web search for industry events across 6 verticals
- Multi-strategy scraping of event websites
- Structured data extraction (JSON-LD, regex, LLM)
- Deduplication by URL
- AI-powered scoring and evaluation

#### Technologies
- Python, FastAPI, curl_cffi, Playwright, Serper API, SearXNG, DeepSeek LLM

#### Key APIs
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/crm/events/discover` | POST | Manual event discovery search |
| `/api/internal/discovery-sweep` | POST | Per-vertical nightly sweep (service auth) |
| `/api/crm/events/add-from-url` | POST | Single-URL scrape + insert + score |
| `/api/crm/events/{id}/enrich` | POST | Re-scrape one event for speakers/details |

#### Design notes
- **Multi-strategy scraping**: curl_cffi with browser TLS fingerprint impersonation handles most anti-bot blocking at near-native speed. Playwright headless Chromium is the fallback for JavaScript-rendered SPAs (~90%+ success at curl_cffi speed with JS pages handled gracefully).
- **Per-vertical execution**: B1 fixed ~230s timeout; one HTTP request per vertical from the pipeline.
- **Deferred speaker extraction**: `DISCOVER_DEFER_SPEAKERS=1` during bulk sweeps; 4-hourly enrichment backfills speakers.
- **Aggregator mining**: LLM extracts official event URLs from aggregator listing pages (10times, Eventbrite), then scrapes official pages.

---

### 2. Event Scoring System

**My contribution: Primary architect and implementer.**

#### Responsibilities
- 5-dimension AI evaluation of every event
- Recommendation banding (Attend/Consider/Monitor/Skip)
- Scoring history audit trail
- Automatic rescoring on staleness or new data

#### Scoring Rubric

| Dimension | Weight | What It Measures |
|-----------|--------|-----------------|
| a — Meeting Potential | 0-35 | Likelihood of face time with decision-makers |
| b — Attendee Quality | 0-30 | Seniority/relevance of attendees and speakers |
| c — Vertical Alignment | 0-20 | Match with tenant's target verticals |
| d — Strategic Opportunity | 0-10 | Sponsorship, speaking slots, brand visibility |
| e — Cost Efficiency | 0-5 | Cost relative to value |

**Recommendation bands:** ≥80 Attend, ≥65 Consider, ≥50 Monitor, <50 Skip.

#### LLM Integration
- DeepSeek `deepseek-chat` via OpenAI-compatible API
- Temperature 0 for deterministic scoring
- Structured JSON output with parsing tolerance (code fences, leading prose)
- Vertical-aware prompting; conservative scoring when page content unavailable
- 2-retry with backoff on 429 rate limits

#### Database Interactions
- `events`: score, score_a–e, score_rationale, recommendation, who_should_attend, vertical_match
- `scoring_history`: audit trail per scoring event
- Rescore triggers: never scored, new speaker data, score >30 days stale

---

### 3. CRM Platform

**My contribution: Primary architect and implementer.**

#### Responsibilities
- Contact lifecycle management (7 stages)
- Company profiles with pipeline aggregation
- Deal pipeline (Kanban board, 6 stages)
- Interaction tracking with auto-follow-up generation
- Follow-up management with AI drafts
- Meeting scheduling and tracking
- Task management
- Activity audit trail

#### Technologies
- Python, FastAPI, React 19, Recharts, @dnd-kit, PostgreSQL

#### Key APIs (Event & CRM)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/crm/contacts` | GET | Paginated contact list with filtering |
| `/api/crm/contacts` | POST | Create contact (via add_contact.py) |
| `/api/crm/contacts/{id}` | GET | Contact detail with relationship score |
| `/api/crm/contacts/{id}` | PATCH | Update contact fields |
| `/api/crm/contacts/{id}/profile` | GET | Interactions + follow-ups + meetings |
| `/api/crm/contacts/{id}/notes` | GET/POST | Contact notes CRUD |
| `/api/crm/contacts/{id}/summary` | POST | AI-generated contact summary |
| `/api/crm/contacts/{id}/health` | PATCH | Refresh contact health score |
| `/api/crm/contacts/lifecycle-counts` | GET | Contacts grouped by lifecycle stage |
| `/api/crm/contacts/decay` | POST | Apply relationship decay rules |
| `/api/crm/contact-duplicates` | GET | Fuzzy duplicate detection |
| `/api/crm/companies` | GET/POST | Company list + create |
| `/api/crm/companies/{id}` | GET/PATCH | Company detail + update |
| `/api/crm/deals` | GET/POST | Deal list + create |
| `/api/crm/deals/{id}` | GET/PATCH | Deal detail + update |
| `/api/crm/deals/{id}/stage` | POST | Move deal stage |
| `/api/crm/pipeline/board` | GET | Kanban board data by stage |
| `/api/crm/interactions` | POST | Log interaction |
| `/api/crm/followups/{id}/draft` | POST | Generate AI follow-up draft |
| `/api/crm/followups/{id}` | PATCH | Update follow-up status |
| `/api/crm/followups/refine` | POST | LLM-refine follow-up draft |
| `/api/crm/queue` | GET | Follow-up queue |
| `/api/crm/meetings` | GET/POST | Meeting list + schedule |
| `/api/crm/meetings/{id}` | PATCH | Update meeting status/outcome |
| `/api/crm/tasks` | GET/POST | Task list + create |
| `/api/crm/tasks/{id}` | PATCH/DELETE | Task update + delete |
| `/api/crm/activities` | GET | Unified activity feed |
| `/api/crm/events` | GET/POST | Event list + create |
| `/api/crm/events/{id}` | PATCH | Update event fields |
| `/api/crm/events/{id}/contacts` | GET/POST | Event contact linking |
| `/api/crm/events/{id}/contacts/{cid}` | PATCH/DELETE | Update/remove event contact |
| `/api/crm/events/{id}/contacts/{cid}/log-interaction` | POST | Log interaction at event |
| `/api/crm/events/{id}/attendees` | GET | Event attendees with contact matching |
| `/api/crm/events/{id}/documents` | GET/POST | Event documents |
| `/api/crm/events/{id}/roi` | GET | Event ROI calculation |
| `/api/crm/events/{id}/register` | POST | Register for event |
| `/api/crm/events/{id}/lifecycle` | GET | Event lifecycle contacts |
| `/api/crm/attendees/import` | POST | CSV/XLSX attendee import |

#### Database Interactions
- **contacts** (30+ columns): lifecycle, relationship, health, AI summary, referral chain, owner, source
- **companies**: Name (UNIQUE), industry, size, relationship_level; linked via company_id or name match
- **deals**: 6-stage pipeline; value, probability, close date, source event, lost reason
- **interactions**: type, date, notes, topics, commitments, next step; actor via logged_by
- **follow_ups**: priority, due date, draft/final, status, channel, source; actor via sent_by
- **meetings**: status, date/time, duration, location, agenda, pre-meeting; actor via scheduled_by
- **event_contacts**: many-to-many with status; UNIQUE(event_id, contact_id)
- **event_attendees**: scraped attendee data with contact_id matching
- **activity_log**: write-time audit log called by 40+ endpoints

---

### Contribution summary (interview talking points)

#### Event Platform
Entire event intelligence pipeline — search across 6 verticals, multi-strategy scraping, structured extraction, URL dedup, 5-dimension DeepSeek scoring, enrichment with retry/rate limits, Blob document management with SAS URLs, attendee CSV/XLSX import with auto-column mapping.

#### CRM Platform
Full CRM — 7-stage lifecycle, relationship scoring + decay, AI summaries, duplicate detection, companies, Kanban deals, interactions with auto follow-ups, AI draft/refine, meetings/tasks, unified 7-source activity feed with actor attribution and RBAC scoping.

#### Infrastructure & Platform
Multi-tenant RLS (7-phase rollout), dual-database abstraction, RBAC (4 roles × 7 resources), Azure DevOps CI/CD with health gates, scheduled pipelines within B1 timeout.

#### Technical Depth Available
- PostgreSQL RLS: FORCE, dedicated DB role, auth_bootstrap, DEFAULT pattern
- Scraping: TLS impersonation vs JS rendering, aggregator mining
- LLM: structured output, scoring prompts, failure handling
- Monolith: subprocesses, organizing ~5,000-line files
- Dual-DB abstraction, per-tenant constraints, tenant-scoped indexes
- Kudu zip-deploy, force pip install, secrets management
- Resource-oriented APIs, field allowlisting, pagination, error responses

# Data Flow

### Event Discovery Pipeline
```
Vertical seed phrases
       │
       ▼
  search.py → web search (Serper → SearXNG)
       │
       ▼
  fetch.py → scrape event pages (curl_cffi → Playwright)
       │
       ▼
  discover.py → extract structured data (JSON-LD → regex → LLM)
       │
       ▼
  score_event.py → evaluate with 5-dim rubric (DeepSeek)
       │
       ▼
  INSERT into events table (dedup by URL)
```

### Nightly Sweep
```
Azure DevOps scheduled trigger (7 AM UTC)
  → For each vertical (index 0..N):
    → POST /api/internal/discovery-sweep {tenant_id, vertical_index}
    → Build queries from seed phrases
    → Search web (Serper API)
    → Scrape result pages (curl_cffi)
    → Extract events (JSON-LD → regex → LLM)
    → Dedup by URL
    → Insert new events
    → Return counts
  → Aggregate summary
```

### Enrichment
```
Azure DevOps scheduled trigger (every 4 hours)
  → POST /api/internal/agent/enrich {tenant_id, batch_size: 4}
  → Query events needing enrichment (no speakers, unscored, stale)
  → For each event:
    → Phase 1: Enrich — re-scrape for speakers
    → Phase 2: Score — DeepSeek LLM with rubric
    → Update events + scoring_history
    → Sleep 2s (rate limiting)
  → Return summary counts
```

### CRM Event → Pipeline Path
```
Event discovered/attended
  → Event contacts / attendee import
  → Interaction logged at event
  → Auto follow-up (2-day due) + async AI draft
  → Contact lifecycle progression
  → Deal created / moved on Kanban board
  → Activity feed + analytics / ROI
```

### Dual-Database Connect Path
```
dbconn.connect(tenant_id=... | auth_bootstrap=...)
  → Postgres? pool + SET app.current_tenant_id
  → else SQLite file
  → Application uses parameterized SQL (translated as needed)
```

# Database Design

**My contribution: Primary designer for Event and CRM tables.**

#### Key Entity Relationships

```
organizations (1) ──< (many) users
organizations (1) ──< (many) events
organizations (1) ──< (many) contacts
organizations (1) ──< (many) companies

events ──< event_contacts >── contacts
events ──< event_attendees >── contacts
events ──< event_documents
events ──< event_registrations
events ──< interactions
events ──< meetings

contacts ──< interactions
contacts ──< follow_ups
contacts ──< meetings
contacts ──< contact_notes
contacts ──< deals
contacts ──< tasks
contacts ──< user_permissions (via owner_id)
contacts (1) ──< (many) contacts (referred_by)

companies ──< contacts (via company_id or name match)
```

#### Schema Size
- **25 tables** total (17 data tables + 8 branding tables)
- **~60 foreign key relationships**
- **~200+ columns** across Event and CRM tables
- **events**: 35 columns including scoring dimensions and ROI metrics
- **contacts**: 30+ columns including lifecycle, relationship, AI fields

#### Indexing
- Per-tenant B-tree indexes on all data tables (`idx_*_tenant_id`)
- Event date index (`ix_events_date`)
- Unique compound indexes: `ux_events_tenant_url`, `ux_events_tenant_canonical_url`, `ux_attendee_event_person`
- Foreign key columns implicitly indexed via FK constraints

---

# APIs

### Event Discovery

#### Key APIs
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/crm/events/discover` | POST | Manual event discovery search |
| `/api/internal/discovery-sweep` | POST | Per-vertical nightly sweep (service auth) |
| `/api/crm/events/add-from-url` | POST | Single-URL scrape + insert + score |
| `/api/crm/events/{id}/enrich` | POST | Re-scrape one event for speakers/details |
### CRM

#### Key APIs (Event & CRM)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/crm/contacts` | GET | Paginated contact list with filtering |
| `/api/crm/contacts` | POST | Create contact (via add_contact.py) |
| `/api/crm/contacts/{id}` | GET | Contact detail with relationship score |
| `/api/crm/contacts/{id}` | PATCH | Update contact fields |
| `/api/crm/contacts/{id}/profile` | GET | Interactions + follow-ups + meetings |
| `/api/crm/contacts/{id}/notes` | GET/POST | Contact notes CRUD |
| `/api/crm/contacts/{id}/summary` | POST | AI-generated contact summary |
| `/api/crm/contacts/{id}/health` | PATCH | Refresh contact health score |
| `/api/crm/contacts/lifecycle-counts` | GET | Contacts grouped by lifecycle stage |
| `/api/crm/contacts/decay` | POST | Apply relationship decay rules |
| `/api/crm/contact-duplicates` | GET | Fuzzy duplicate detection |
| `/api/crm/companies` | GET/POST | Company list + create |
| `/api/crm/companies/{id}` | GET/PATCH | Company detail + update |
| `/api/crm/deals` | GET/POST | Deal list + create |
| `/api/crm/deals/{id}` | GET/PATCH | Deal detail + update |
| `/api/crm/deals/{id}/stage` | POST | Move deal stage |
| `/api/crm/pipeline/board` | GET | Kanban board data by stage |
| `/api/crm/interactions` | POST | Log interaction |
| `/api/crm/followups/{id}/draft` | POST | Generate AI follow-up draft |
| `/api/crm/followups/{id}` | PATCH | Update follow-up status |
| `/api/crm/followups/refine` | POST | LLM-refine follow-up draft |
| `/api/crm/queue` | GET | Follow-up queue |
| `/api/crm/meetings` | GET/POST | Meeting list + schedule |
| `/api/crm/meetings/{id}` | PATCH | Update meeting status/outcome |
| `/api/crm/tasks` | GET/POST | Task list + create |
| `/api/crm/tasks/{id}` | PATCH/DELETE | Task update + delete |
| `/api/crm/activities` | GET | Unified activity feed |
| `/api/crm/events` | GET/POST | Event list + create |
| `/api/crm/events/{id}` | PATCH | Update event fields |
| `/api/crm/events/{id}/contacts` | GET/POST | Event contact linking |
| `/api/crm/events/{id}/contacts/{cid}` | PATCH/DELETE | Update/remove event contact |
| `/api/crm/events/{id}/contacts/{cid}/log-interaction` | POST | Log interaction at event |
| `/api/crm/events/{id}/attendees` | GET | Event attendees with contact matching |
| `/api/crm/events/{id}/documents` | GET/POST | Event documents |
| `/api/crm/events/{id}/roi` | GET | Event ROI calculation |
| `/api/crm/events/{id}/register` | POST | Register for event |
| `/api/crm/events/{id}/lifecycle` | GET | Event lifecycle contacts |
| `/api/crm/attendees/import` | POST | CSV/XLSX attendee import |

Additional surface: ~100+ REST endpoints across `/api/crm/*`, auth, pipeline, analytics, admin, settings, and `/api/internal/*` (service token). Resource-oriented URLs, server-side pagination, field allowlisting on PATCH, consistent error handling.

# Authentication/Security

**My contribution: Likely contributor to design and implementation.**

#### Authentication Flow
```
User → POST /api/auth/login {email, pin}
  → bcrypt.verify(pin, stored_hash)
  → Generate token = secrets.token_hex(32)
  → INSERT user_sessions (token, expires_at = now + 24h)
  → Load user_permissions
  → Return {token, user, permissions}
```

#### Security Decisions
- **PIN over password**: 6-digit numeric PIN for non-technical BD users; bcrypt + rate limiting
- **bcrypt with auto-upgrade**: Legacy plaintext (no `$2` prefix) hashed in-place on first successful login
- **Bearer tokens over JWT**: DB-backed 24h sessions for instant invalidation; no key rotation
- **Rate limiting**: 10 attempts / 60s / IP in-memory (would need Redis for multi-instance)

#### RBAC Model

| Role | Events | CRM | Branding | Pipeline | Analytics | Settings | Users |
|------|--------|-----|----------|----------|-----------|----------|-------|
| Admin | V/E/D | V/E/D | V/E/D | V/E/D | V/E/D | V/E/D | V/E/D |
| Partner | V/-/- | V/E/- | V/-/- | -/-/- | V/-/- | -/-/- | -/-/- |
| Member | V/E/- | V/E/- | V/E/- | V/E/- | V/-/- | -/-/- | -/-/- |
| Guest | V/-/- | -/-/- | -/-/- | -/-/- | -/-/- | -/-/- | -/-/- |

V = can_view, E = can_edit, D = can_delete

**Enforcement**: ASGI `rbac_middleware` on every request. Public paths (login, logout, invite accept, health, docs, OPTIONS) exempt. Internal endpoints use SERVICE_TOKEN. Admin role bypasses granular checks. Frontend PermGate mirrors server enforcement. Vertical filter for event visibility.

---

# Infrastructure

### Deployment / CI/CD

#### CI/CD Pipeline (azure-pipelines.yml)

```
Push to main
  │
  ├── Frontend
  │   ├── npm ci && npm run build (VITE_API_URL from pipeline vars)
  │   ├── AzureStaticWebApp@0 deploy frontend/dist
  │   └── Health check: curl frontend URL (10 retries)
  │
  └── Backend
      ├── Enable RLS on PostgreSQL (idempotent psql)
      ├── Strip local-dev secrets (config.json, search_log.txt)
      ├── Bundle agent/ module into api/ package
      ├── ZIP api/ directory
      ├── Kudu zipdeploy (basic auth)
      ├── Force pip install via Kudu command API
      └── Health check: curl /docs (12 retries)
```

#### B1 Constraints & Workarounds

| Constraint | Limit | Workaround |
|-----------|-------|-----------|
| Request timeout | ~230s fixed | Per-vertical discovery, 4-event enrichment batches |
| Deployment slots | Not available | Direct deploy only (no staging) |
| CPU/RAM | 1 vCPU, 1.75 GB | Enrichment in-process (no separate service) |
| Startup time | ~230s | Keep startup scripts minimal |

---

(Azure resource table and secrets management are under Architecture.)

# Automation

#### Scheduled Pipelines

| Pipeline | Schedule | Duration | Purpose |
|----------|----------|----------|---------|
| Nightly Sweep | Daily 7 AM UTC | ~5-10 min | Discover new events per vertical |
| Enrichment | Every 4 hours | ~1-3.5 min | Score events + backfill speakers |

**Relationship Decay:** Manual trigger via POST; downgrades stale relationships by days-since-last-touch.
**Follow-up Auto-Generation:** Event interaction logging creates follow-up with 2-day due; AI draft via async subprocess.

---

# AI Systems

#### LLM Provider: DeepSeek
- Model: `deepseek-chat`
- API: OpenAI-compatible (`https://api.deepseek.com/v1/chat/completions`)
- Access: `urllib.request` (no SDK); key cascade: DB settings → env → config.json

| Use Case | System Prompt | Input | Output | Temperature |
|----------|--------------|-------|--------|-------------|
| Event Scoring | "Precise, skeptical B2B event evaluator" | Event metadata + page content (8K chars) | 5-dim scores + rationale JSON | 0 |
| Contact Summary | "Summarize business contact relevance" | Contact data + last 5 interactions | 2-3 sentence paragraph | 0.7 |
| Follow-up Draft | "Professional follow-up email writer" | Contact name + interaction context | Email draft text | 0.7 |
| Follow-up Refine | "Professional business communication editor" | Draft + revision suggestions | Revised text | 0.7 |
| Aggregator Mining | "Precise extraction engine" | Aggregator page HTML | [(event_name, official_url)] JSON | 0 |

**Scoring prompt:** ~200 words of rubric instructions; vertical names injected from tenant config; validation rejects unknown verticals and non-integer scores.

---

### Scoring system (detail)

**My contribution: Primary architect and implementer.**

#### Responsibilities
- 5-dimension AI evaluation of every event
- Recommendation banding (Attend/Consider/Monitor/Skip)
- Scoring history audit trail
- Automatic rescoring on staleness or new data

#### Scoring Rubric

| Dimension | Weight | What It Measures |
|-----------|--------|-----------------|
| a — Meeting Potential | 0-35 | Likelihood of face time with decision-makers |
| b — Attendee Quality | 0-30 | Seniority/relevance of attendees and speakers |
| c — Vertical Alignment | 0-20 | Match with tenant's target verticals |
| d — Strategic Opportunity | 0-10 | Sponsorship, speaking slots, brand visibility |
| e — Cost Efficiency | 0-5 | Cost relative to value |

**Recommendation bands:** ≥80 Attend, ≥65 Consider, ≥50 Monitor, <50 Skip.

#### LLM Integration
- DeepSeek `deepseek-chat` via OpenAI-compatible API
- Temperature 0 for deterministic scoring
- Structured JSON output with parsing tolerance (code fences, leading prose)
- Vertical-aware prompting; conservative scoring when page content unavailable
- 2-retry with backoff on 429 rate limits

#### Database Interactions
- `events`: score, score_a–e, score_rationale, recommendation, who_should_attend, vertical_match
- `scoring_history`: audit trail per scoring event
- Rescore triggers: never scored, new speaker data, score >30 days stale

---

# Engineering Decisions

1. **Monolith FastAPI** for 1–2 engineer velocity over microservices overhead.
2. **Raw SQL + dbconn.py** over ORM for control and dual SQLite/Postgres support.
3. **curl_cffi + Playwright** two-tier scraping for speed and JS coverage.
4. **Per-vertical discovery / 4-event enrichment** to fit B1 ~230s timeout without tier upgrade.
5. **Defer speakers in sweeps**; enrich later so discovery stays fast.
6. **Aggregator LLM mining** then scrape official pages for net-new events.
7. **5-dimension DeepSeek scoring** with temperature 0 and recommendation bands for consistent evaluation.
8. **PostgreSQL RLS + FORCE + cirklo_app role** for defense-in-depth multi-tenancy.
9. **tenant_id DEFAULT from session** so ~100+ INSERTs need not change.
10. **auth_bootstrap policy** so login/invite work before tenant is known.
11. **Bearer DB sessions** over JWT for instant revocation.
12. **PIN + bcrypt auto-upgrade** for BD usability and seamless prototype→prod migration.
13. **Subprocess IPC** for long-running search/scrape/LLM without blocking the API.
14. **In-process enrichment** to avoid a second paid service on B1.
15. **App Service ZIP/Kudu** over Container Apps for simpler budget deploy.
16. **UNION ALL activity feed** for one paginated chronological audit trail.
17. **Backend-proxied blob uploads + short SAS** for validation and least privilege.
18. **Health-check-gated CI/CD** so bad deploys fail the pipeline hard.

# Tradeoffs

### Monolith over Microservices
**Decision:** Single FastAPI file (~5,000 lines) rather than separate services.
**Why:** Team size of 1–2 engineers. Microservices overhead would slow development without benefits at this scale.
**Tradeoff:** File size and coupling. Mitigated by comment-delimited sections and script-based separation for long-running tasks.
**Future:** Extract agent/enrich.py; split route files by domain.

### Raw SQL over ORM
**Decision:** Parameterized raw SQL via dbconn.py rather than SQLAlchemy.
**Why:** Full control, no ORM learning curve, simpler debugging; dual-DB layer handles dialects.
**Tradeoff:** No migration framework, no compile-time SQL safety, injection risk if parameterization missed.
**Future:** Alembic for migrations; SQLAlchemy core for safer query building.

### Subprocess Script Execution
**Decision:** Long-running ops (search, scrape, LLM) as Python subprocesses with JSON stdin/stdout IPC.
**Why:** Keeps FastAPI responsive; isolates crashes; per-operation timeouts.
**Tradeoff:** ~100ms spawn overhead; JSON round-trip; harder to debug.
**Future:** Celery/Redis task queue for observability and retries.

### In-Process Enrichment
**Decision:** `agent/enrich.py` runs in-process on App Service, not a separate container.
**Why:** No extra service to maintain/pay for; fits B1 (4 events, ~1–3.5 min).
**Tradeoff:** Competes for CPU with API traffic.
**Future:** Separate container if batch size/frequency grows.

### B1 App Service over Container Apps
**Decision:** App Service + ZIP deploy over Container Apps/AKS.
**Why:** Simpler deploy, Kudu, no registry; B1 budget fit; Playwright base image option.
**Tradeoff:** No staging slots, fixed timeout, limited scaling; ZIP slower than container pull.
**Future:** Container Apps for staging, scaling, separate enrichment worker.

### Scraping Strategy
**Decision:** curl_cffi primary + Playwright fallback.
**Why:** Speed for most sites; JS rendering when needed.
**Tradeoff:** Playwright unavailable in zip-deploy prod (Docker image only); dual strategy maintenance.
**Future:** More fallbacks; cache page content to reduce re-scraping.

### RLS over Application-Level Filtering
**Decision:** PostgreSQL RLS with FORCE + dedicated app role.
**Why:** Defense in depth — one missed WHERE cannot leak tenants.
**Tradeoff:** Harder debugging; DEFAULT means tenant_id rarely explicit in code.
**Status:** Production multi-tenancy with **actual tenants** (manager-confirmed). Continue monitoring isolation and pool/RLS performance as tenant count grows; do not invent tenant numbers in claims.

### Bearer Sessions over JWT
**Decision:** DB-stored 24h Bearer tokens.
**Why:** Instant invalidation; simpler than JWT key rotation.
**Tradeoff:** DB lookup every request.

### Activity Feed UNION ALL
**Decision:** Single SQL UNION ALL of 7 sources vs app-side merge.
**Why:** Server-side sort/pagination in one query.
**Tradeoff:** Complex query; new sources require modifying the UNION; RBAC logic duplicated in count + data queries.

## Failure Modes

| Failure | Behavior | Mitigation |
|---------|----------|------------|
| DeepSeek API down / 429 | Events stay unscored; follow-up/summary fall back to templates | Non-fatal; 2 retries with delay; retried next enrichment cycle; individual event failures don't kill batch |
| Scrape blocked / JS-only page | curl_cffi fails | Playwright fallback (where available) |
| Aggregator page instead of official URL | Poor scrape quality | LLM aggregator mining → scrape official URL |
| Discovery sweep exceeds B1 timeout | Request killed at ~230s | Per-vertical calls; pipeline aggregates |
| Enrichment exceeds timeout | Batch incomplete | 4-event batches; pipeline retry loop (2×, 30s delay) |
| Single vertical fails in sweep | That vertical returns error | Remaining verticals continue (failure isolation) |
| `_log_activity()` fails | Mutation would be blocked if sync-fatal | Best-effort: audit failures never block mutations |
| Missing API keys | Feature would crash | Graceful degradation when keys absent |
| Login before tenant known | RLS would block users table | auth_bootstrap policy escape hatch |
| Table owner / superuser DB role | RLS silently bypassed even with FORCE | Dedicated `cirklo_app` non-owner, non-superuser role |
| GRANT ALL TABLES then new table | New table missing grants | Documented operational hazard; include new tables in grants |
| `_ID_TABLES` missing new table | lastrowid emulation silent wrong | Manual allowlist discipline; prefer loud failures later |
| Dual schema drift (db.py vs schema_postgres.sql) | Local/prod behavior diverge | Careful dual maintenance; future ORM/migrations |
| Playwright missing in zip-deploy | JS sites fail scrape | Docker image path for Playwright; curl_cffi primary |
| Rate-limit store in-memory | Multi-instance would not share limits | Acceptable on single B1; Redis if scaled out |
| Blob upload invalid content | Malware/oversized files | Backend-proxied upload; allowlist; 25MB limit |
| SAS URL abuse | Long-lived document links | 15-minute SAS expiry |
| Transaction exception mid-mutation | Partial writes | Rollback on exceptions |

# Future Improvements

### Current constraints (B1)
- Fixed ~230s request timeout drives batching of discovery and enrichment
- 1 vCPU / 1.75 GB — enrichment stays in-process; no separate worker yet
- No deployment slots — no staging environment on this tier
- In-memory login rate limiting — not multi-instance safe

### Horizontal / product scale
- **More verticals (e.g. 100):** Keep per-vertical (or sharded) sweep workers; move long jobs to a queue; measure discovery quality (precision/recall of scored Attend events)
- **Growing tenants:** Actual tenants already on the platform (manager-confirmed); RLS already isolates; platform admin switcher exists; watch connection pool + RLS policy performance; per-tenant vertical config already supported
- **Activity feed growth (1M+ rows):** Indexes on timestamp + tenant; consider materialized activity table or streaming instead of giant UNION ALL; refactor if sources exceed ~5–7
- **Enrichment load:** Extract to separate container/worker when batch size or frequency impacts API latency
- **Scraping volume:** Cache page content; add fallback strategies; avoid re-scraping unchanged pages
- **LLM cost/quality:** Structured validation already reduces bad scores; A/B rubric changes; monitor hallucinations; temperature 0 for scoring
- **Multi-instance App Service:** Move rate limits to Redis; consider shared task queue (Celery)
- **Schema evolution:** Move to Alembic/SQLAlchemy core to avoid dual-schema drift
- **Cross-tenant sharing:** Not built; would need explicit share tables/policies beyond isolation DEFAULT
- **Hosting upgrade path:** Container Apps for staging slots, better scaling, and dedicated enrichment worker

Future notes also appear under individual Tradeoffs entries (Celery/Redis, Container Apps, Alembic/SQLAlchemy, separate enrichment worker, activity-feed materialization).
