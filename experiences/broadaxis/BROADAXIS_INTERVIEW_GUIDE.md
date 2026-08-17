# Broadaxis — Interview Guide

> **Sources:** `BROADAXIS_CONTEXT.md`, `BROADAXIS_ACCOMPLISHMENTS.md`, `BROADAXIS_SYSTEM_DESIGN.md`, `METRICS.md`, `REFERENCES/REFERENCES.md`
> **Rule:** Do not invent experiences. Prefer confirmed ownership; label likely contributions when speaking.
> **NDA:** Externally, emphasize technical design, constraints, and impact. Avoid confidential product contents / tenant identities. Safe manager-confirmed claims: actual tenants exist; multi-agent system shipped on Azure; stakeholder presentation.

# Project Summary

**Product (external framing):** A production multi-tenant B2B event-intelligence + CRM platform on Azure (internally / privately: Cirklo). Prefer technical importance over proprietary workflow detail in interviews.

**Problem (high-level):** Manual event research and CRM were siloed; no systematic way to evaluate events or turn attendance into pipeline.

**Your role:** Primary engineer for **Event** and **CRM** platforms. Branding was built by a separate teammate. Reported directly to **Rohan Mandrekar**.

**Stack:** React 19 SPA (Vite) → FastAPI monolith (~5,000 lines) → PostgreSQL (prod) / SQLite (dev). Azure: Static Web Apps, App Service B1, PostgreSQL Flexible Server, Blob Storage. CI/CD via Azure DevOps. AI via DeepSeek (multi-agent discovery/enrichment workflows).

**Ownership for interviews**

| Level | Scope |
|-------|--------|
| **Confirmed** | Event discovery / scoring / enrichment; CRM (contacts, companies, deals, interactions, follow-ups, meetings, tasks, activity feed, analytics); documents; attendee import; CI/CD + scheduled pipelines for this platform; stakeholder presentation; Azure deploy of shipped multi-agent system; production tenants exist (manager-confirmed — no count/names) |
| **Likely** | Auth, RBAC, multi-tenant RLS, `dbconn` dual-database layer |
| **Possible** | Rate-limit middleware design, CORS, settings/user-management endpoints, theme tokens |
| **Do not claim** | Branding platform; tenant count or tenant/customer names; confidential product contents beyond NDA-safe technical framing |

---

### Elevator pitch (30–60s) — external / NDA-safe

> I interned as a software engineer reporting to Rohan Mandrekar and shipped a production multi-tenant event-intelligence and CRM platform on Azure. I owned the event discovery and CRM backends and UIs: automated discovery and multi-agent enrichment/scoring pipelines, a full contacts/deals pipeline, and Azure DevOps CI/CD. The product runs with real client tenants isolated via PostgreSQL RLS. I ramped quickly on Azure and multi-agent systems, designed before coding, and presented the work to stakeholders myself.

### Elevator pitch (internal prep only)

> I built Cirklo’s event intelligence and CRM. The system discovers industry events across six verticals, scores them with a five-dimension DeepSeek rubric, and connects attendance to a full CRM pipeline — contacts, deals, follow-ups, and audit. It’s a FastAPI monolith on Azure with PostgreSQL RLS for multi-tenancy (actual tenants in production). Nightly discovery finds 5–20 new events; enrichment rescores every four hours within App Service B1 timeout limits.

---

### Quick facts

**Hosting:** App Service B1 — ~230s timeout, no staging slots, 1 vCPU / 1.75 GB.  
**Discovery:** Serper → SearXNG; curl_cffi → Playwright; JSON-LD → regex → LLM; nightly 7 AM UTC; 5–20 new events.  
**Scoring:** 5 dims; bands Attend/Consider/Monitor/Skip; temp 0; `scoring_history`.  
**Enrichment:** Every 4 hours; 4 events/batch; 2s LLM spacing; ~1–3.5 min.  
**CRM:** 7 lifecycle stages; 6 deal stages; relationship score recency 60% / frequency 40%.  
**Decay:** warm/known → cold after 180d no touch; active_client → known_contact after 90d.  
**AI use cases:** scoring, contact summaries, follow-up draft, follow-up refine, aggregator mining (manager also framed the shipped Azure work as a complete multi-agent system).  
**Activity feed:** 7 sources; 40+ endpoints logging; RBAC via contact owner OR actor.  
**Auth (likely):** PIN + bcrypt (+ plaintext auto-upgrade); 24h Bearer DB sessions; 10 attempts / 60s / IP.  
**RBAC (likely):** Admin / Partner / Member / Guest; 7 resources × view/edit/delete.  
**Multi-tenant (likely ownership of RLS):** 25 tables; FORCE RLS; `cirklo_app`; auth_bootstrap; acting_tenant_id; **actual tenants in production** (manager-confirmed).  
**Code scale:** ~5k main.py; ~2k scripts; ~400 agent; ContactsPage ~1,986 / EventsPage ~1,775 lines.  
**API surface:** ~100+ REST endpoints.
**Soft / leadership (confirmed):** Stakeholder presentation of shipped work; methodical design-before-code; fast ramp on Azure + multi-agent systems.

---

### Whiteboard talking points

If asked to “design Cirklo” or a subsystem:

1. **Event discovery:** seeds → search → scrape → extract → dedup → score → store; draw Serper/curl_cffi/DeepSeek boxes; call out timeout batching.
2. **Scoring service:** rubric as contract; structured JSON; validation; audit history; rescoring triggers.
3. **CRM write path:** interaction → follow-up upsert → async draft → activity log (best-effort).
4. **Multi-tenancy:** session sets tenant → RLS USING clause → DEFAULT on insert → bootstrap for auth.
5. **Failure matrix:** LLM down, scrape blocked, vertical fails, timeout — each has a documented mitigation.

Prefer drawing the flows from `BROADAXIS_SYSTEM_DESIGN.md` (discovery, nightly sweep, enrichment, event→pipeline).

---

# My Role

Primary engineer for **Event** and **CRM** platforms. Branding was built by a separate teammate.

| Level | Scope |
|-------|--------|
| **Confirmed** | Event discovery / scoring / enrichment; CRM (contacts, companies, deals, interactions, follow-ups, meetings, tasks, activity feed, analytics); documents; attendee import; CI/CD + scheduled pipelines for this platform |
| **Likely** | Auth, RBAC, multi-tenant RLS, `dbconn` dual-database layer |
| **Possible** | Rate-limit middleware design, CORS, settings/user-management endpoints, theme tokens |
| **Do not claim** | Branding platform |

# Technical Challenges

## Challenge 1 — Event Discovery Pipeline (SWE + Automation)

### Situation

BroadAxis evaluated industry events across six verticals (Texas Government, Oil & Gas, Workforce, Staffing, Microsoft, AI) via Google and spreadsheets.

### Problem

Automate search → scrape → extract → score → insert so BD wouldn’t miss events and evaluation would be consistent.

### Solution

- Built `discover.py` (~113KB): per-vertical seed phrases → regional/type variants (capped at 24 queries)
- Multi-strategy scrape: curl_cffi (browser TLS impersonation) primary, Playwright headless Chromium fallback
- Aggregator mining: LLM extracts official URLs from listing pages (10times, Eventbrite), then scrape official pages
- JSON-LD + regex extraction; URL dedup with `canonical_url`; add-from-url for missed events
- Split sweeps **per vertical** to stay under Azure App Service B1 ~230s request timeout; scheduled nightly 7 AM UTC

### Tradeoffs

Anti-bot TLS fingerprinting, timeout-driven batching, structured extraction before LLM, aggregator→official URL strategy.

### Result

Nightly discovery finds **5–20 new events** across verticals with per-vertical failure isolation.

## Challenge 2 — AI Event Scoring (AI Engineering)

### Situation

Different people scored “is this event worth it?” inconsistently.

### Problem

Produce consistent, auditable recommendations (Attend / Consider / Monitor / Skip).

### Solution

- Designed 5-dimension rubric: Meeting Potential 0–35, Attendee Quality 0–30, Vertical Alignment 0–20, Strategic Opportunity 0–10, Cost Efficiency 0–5
- DeepSeek `deepseek-chat` via OpenAI-compatible API; **temperature 0**; structured JSON; vertical-aware prompts; up to 8K chars page context
- Validated outputs (known verticals, integer scores); conservative scoring when page content missing
- Stored dimensions + rationale; `scoring_history` audit trail; rescore when never scored, new speakers, or score >30 days old

### Tradeoffs

Prompt engineering for skeptical B2B evaluation, structured-output parsing (code-fence tolerance), temperature 0 vs 0.7, failure non-blocking to enrichment.

### Result

Recommendation bands (Attend ≥80, Consider ≥65, Monitor ≥50, Skip <50) replaced inconsistent manual judgment.

## Challenge 3 — Enrichment Pipeline Under Timeout Constraints (SWE + AI)

### Situation

Discovery deferred speakers for speed; many events needed rescoring as data changed.

### Problem

Continuously enrich/score without exceeding B1 ~210–230s pipeline/request limits or blowing DeepSeek rate limits.

### Solution

- Built in-process `agent/enrich.py` (~400 lines): Phase 1 re-scrape speakers; Phase 2 DeepSeek score
- Batch size **4** events; **2s** sleep between LLM calls; **2 retries** on 429
- Non-fatal per-event failures; scheduled every 4 hours via Azure DevOps

### Tradeoffs

In-process vs separate worker, rate limiting, graceful LLM degradation, deferred work from discovery.

### Result

Hands-off enrichment (~1–3.5 min typical) without a separate worker service on B1.

## Challenge 4 — Multi-Tenant RLS Migration (SWE / Security) — *likely ownership*

### Situation

Cirklo started single-tenant for BroadAxis; needed multi-org isolation without downtime or leaks. The product now has **actual tenants** in production (manager-confirmed).

### Problem

Add `tenant_id` + PostgreSQL RLS across **25 tables** without rewriting ~100+ INSERTs or breaking login.

### Solution

- 7-phase rollout: nullable columns → deploy → backfill + NOT NULL → per-tenant UNIQUE → FORCE RLS + `cirklo_app` role + DEFAULT → tenant_verticals → platform admin `acting_tenant_id`
- Rehearsed on local Postgres with real data + synthetic second tenant
- `auth_bootstrap` policy for pre-auth login/invite

### Tradeoffs

Why RLS over app-only `WHERE`; table-owner/superuser RLS pitfalls; login-before-tenant.

**Caveat:** Documented as **likely** contribution — don’t claim solo ownership unless you can defend it.

### Result

Defense-in-depth isolation; existing INSERTs auto-populate `tenant_id` via session DEFAULT; production multi-tenant with real client organizations (no inventable count).

## Challenge 5 — Activity Audit Feed (SWE / Backend)

### Situation

Interactions, follow-ups, meetings, deals, event contacts, imports, and admin actions lived in different tables with inconsistent actor attribution (“System”).

### Problem

Unified, RBAC-scoped chronological feed with real actor names.

### Solution

- Retrofitted actor columns (`logged_by`, `sent_by`, `scheduled_by`, `updated_by`)
- `UNION ALL` merge of **7 sources** into one shape; type/date filters; pagination + separate count query
- Write-time `_log_activity()` on **40+ endpoints** (best-effort — never blocks mutations)
- Non-admins: own contacts’ activities OR own actions

### Tradeoffs

Heterogeneous schemas, UNION ALL vs app merge, RBAC duplication in count + data queries.

### Result

Accountability feed with real actors and scoped visibility.

## Challenge 6 — AI Follow-up Drafts (AI Engineering)

### Situation

After event meetings, writing professional follow-ups was slow and inconsistent.

### Problem

Generate drafts from interaction context; let users refine via LLM; keep queue/ops usable when LLM is down.

### Solution

- DeepSeek draft from contact + interaction (`crm_draft_followup.py`); async **subprocess** spawn so API stays responsive
- Auto-create follow-up on event interaction log (2-day due); priority 1–4; channel/source tracking
- Refine endpoint: user suggestions → LLM revision
- Template/graceful path when LLM unavailable

### Tradeoffs

Subprocess IPC for long LLM calls, human-in-the-loop, temperature 0.7 for generation, product failure modes when LLM is down.

### Result

Draft + refine loop; reduced drafting from minutes to seconds (documented business impact).

## Challenge 7 — Dual-Database Abstraction (SWE) — *likely ownership*

### Situation

Needed zero-Docker local dev and production Postgres (pooling, RLS).

### Problem

Avoid two query codepaths / dialect drift.

### Solution

- `dbconn.py`: auto-detect; `?`→`%s`; `datetime('now')`→`NOW()`; `lastrowid` via `RETURNING` + `_ID_TABLES`; RealDictRow-compatible access; ThreadedConnectionPool; tenant context `SET app.current_tenant_id`

### Tradeoffs

Translation gaps (`julianday`, `ILIKE`, `ON CONFLICT`); silent `_ID_TABLES` failures; dual schema files.

**Caveat:** **Likely** contribution.

### Result

`uvicorn` on SQLite locally; Azure Postgres in prod; one application SQL style.

## Challenge 8 — CRM: Event → Pipeline (Full-Stack SWE)

### Situation

Contacts met at events were lost; no path from attendance → lifecycle → deal.

### Problem

Full CRM connecting events to pipeline.

### Solution

- Contacts CRUD (30+ fields), 7-stage lifecycle, relationship score (recency 60% + frequency 40%), decay rules
- Companies, 6-stage Kanban deals (@dnd-kit), interactions → auto follow-ups, meetings/tasks
- Attendee CSV/XLSX import: preview → commit, fuzzy column map, email + name/company match
- Event documents via Blob + 15-min SAS URLs

### Tradeoffs

Domain modeling, import matching edge cases, proxied uploads vs direct-to-blob.

### Result

End-to-end path: discover/attend → import/link contacts → interact → follow-up → lifecycle → deal → ROI/analytics.

## Challenge 9 — CI/CD + Scheduled Automation (DevOps / SWE)

### Situation

Need continuous deploy and automated discovery/enrichment with no staging slots and fixed timeouts.

### Problem

Reliable deploys + hands-off scheduled jobs.

### Solution

- Azure DevOps: frontend build → Static Web Apps + health gate; backend RLS enable → strip secrets → ZIP → Kudu zipdeploy → force pip → `/docs` health gate
- Nightly per-vertical sweep; 4-hourly enrichment with batch/retry

### Tradeoffs

No blue/green on B1; secrets never ship (`config.json`, `search_log.txt` stripped).

### Result

Push-to-main deploys with hard health gates; zero-manual-intervention discovery + enrichment within B1 limits.


### Challenge summary table (prior guide)

| Challenge | Why hard | What you did |
|-----------|----------|--------------|
| **B1 ~230s request timeout** | Full multi-vertical discovery exceeded limit; not configurable | Per-vertical sweep calls; enrichment batches of 4; pipeline-level aggregation |
| **Anti-bot + JS event sites** | TLS fingerprinting / SPA rendering | curl_cffi primary + Playwright fallback |
| **Aggregator vs official pages** | Listing pages yield poor structured data | LLM mining → scrape official URL |
| **LLM flakiness / 429** | Enrichment and scoring must not die | 2 retries, 2s spacing, non-fatal per-event failures, next-cycle retry |
| **Multi-tenant on live single-tenant DB** | 25 tables, login-before-tenant, ~100+ INSERTs | Phased RLS rollout, DEFAULT tenant_id, auth_bootstrap, dedicated app role |
| **Heterogeneous audit sources** | Different schemas / actors / timestamps | Actor column retrofit + UNION ALL + RBAC in count and data queries |
| **SQLite vs Postgres dialects** | One codebase, two backends | `dbconn` translation layer (with known gaps) |
| **Long LLM/scrape work vs API latency** | Don’t block FastAPI | Subprocess JSON IPC for search/scrape/drafts; in-process enrichment for small batches |
| **Document security** | Validate content; don’t leave long-lived links | Backend-proxied upload; allowlist; 25MB cap; 15-min SAS |
| **CRM data quality** | Stale relationships inflate pipeline | Decay rules (180d / 90d); duplicate detection (email OR company+Jaccard ≥70%) |

---

# Debugging Stories

Use these as “tell me about a hard bug / production constraint” answers. They are documented failure modes and mitigations — not invented incidents.

### 1. Discovery killed by App Service timeout
**Symptom:** Sweep dies ~230s mid-run.  
**Root cause:** Fixed B1 request timeout; all verticals in one request.  
**Fix:** One HTTP call per vertical from Azure pipeline; aggregate counts.  
**Lesson:** Hosting limits shape architecture as much as domain logic.

### 2. Login broken after enabling RLS
**Symptom:** Auth queries can’t read `users` (tenant unknown).  
**Root cause:** RLS applied before tenant context exists.  
**Fix:** `auth_bootstrap` escape-hatch policy for login/invite.  
**Lesson:** Test pre-auth paths explicitly when adding RLS.

### 3. RLS “enabled” but not enforcing
**Symptom:** Isolation appears to work in one env, leaks in another.  
**Root cause:** Table owner / superuser bypasses RLS (even with FORCE nuances).  
**Fix:** Dedicated `cirklo_app` non-owner, non-superuser role for live traffic.  
**Lesson:** Role choice is part of the security design, not an afterthought.

### 4. Enrichment / scoring stuck or partial
**Symptom:** Events remain unscored; intermittent 429s.  
**Root cause:** DeepSeek rate limits / outages; batch too large for timeout.  
**Fix:** Batch size 4, 2s sleep, 2 retries, non-fatal per-event errors, next cycle.  
**Lesson:** Treat LLM as an unreliable dependency; never make the batch all-or-nothing.

### 5. Scrape returns garbage from aggregator URLs
**Symptom:** Poor speakers/details; weak scores.  
**Root cause:** Listing pages ≠ official event pages.  
**Fix:** LLM aggregator mining → resolve official URL → scrape again.  
**Lesson:** Extraction quality depends on *which* page you fetch.

### 6. Playwright missing in production path
**Symptom:** JS-only sites fail after curl_cffi.  
**Root cause:** Playwright not available in zip-deploy prod; needs Docker image path.  
**Fix / nuance:** curl_cffi primary; document Docker image for Playwright.  
**Lesson:** Local/prod capability parity isn’t free on constrained deploys.

### 7. Silent wrong `lastrowid` on Postgres
**Symptom:** Inserts appear to succeed with wrong/missing IDs.  
**Root cause:** `_ID_TABLES` allowlist not updated for new tables.  
**Mitigation awareness:** Manual discipline; prefer loud failures later / ORM.  
**Lesson:** Silent compatibility shims are worse than loud ones.

### 8. Audit log failure blocking CRM writes (design avoidance)
**Problem class:** Sync audit that fails would block mutations.  
**Design:** `_log_activity()` is best-effort — never blocks the business write.  
**Lesson:** Observability must not outrank core write availability (for this product).

### 9. Dual schema drift (SQLite `db.py` vs `schema_postgres.sql`)
**Symptom:** Works locally, fails or differs in prod.  
**Root cause:** Two schema sources of truth.  
**Mitigation:** Careful dual maintenance; future Alembic/SQLAlchemy.  
**Lesson:** Call this out honestly in interviews as a known risk.

---

# Architecture Decisions

1. **Monolith FastAPI (~5k lines)** — 1–2 engineers; avoid microservice ops tax; mitigate with sectioned file + scripts for long jobs.
2. **Raw SQL + `dbconn.py`** — control + dual SQLite/Postgres; no ORM migration framework yet.
3. **curl_cffi + Playwright** — speed first, JS when needed.
4. **Per-vertical discovery / 4-event enrichment** — fit B1 timeout without tier upgrade.
5. **Defer speakers in sweeps** — fast discovery; enrichment backfills.
6. **Aggregator LLM mining then official scrape** — net-new events with better page quality.
7. **5-dim DeepSeek scoring, temp 0, recommendation bands** — consistent, auditable evaluation.
8. **PostgreSQL RLS + FORCE + `cirklo_app`** — defense-in-depth multi-tenancy (**likely**).
9. **`tenant_id` DEFAULT from session** — avoid rewriting ~100+ INSERTs (**likely**).
10. **`auth_bootstrap` policy** — login/invite before tenant known (**likely**).
11. **DB-backed Bearer sessions** — instant logout/invalidation vs JWT rotation (**likely**).
12. **PIN + bcrypt auto-upgrade** — BD usability + migrate plaintext prototypes (**likely**).
13. **Subprocess IPC for long ops** — keep API responsive; isolate crashes.
14. **In-process enrichment** — no second paid worker on B1.
15. **App Service ZIP/Kudu** — simple budget deploy vs Container Apps.
16. **UNION ALL activity feed** — one paginated chronological audit.
17. **Backend-proxied blobs + short SAS** — validate before store; least privilege on download.
18. **Health-check-gated CI/CD** — bad deploys fail the pipeline hard.

---

### Related tradeoffs

| Decision | Benefit | Cost / risk |
|----------|---------|-------------|
| Monolith vs microservices | Velocity, simple deploy | Coupling, large file; future split by domain |
| Raw SQL vs ORM | Debuggable, dual-DB control | No Alembic; dialect drift; injection if params missed |
| Subprocess scripts | Isolation, timeouts, non-blocking API | Spawn/IPC overhead; harder debugging; future Celery |
| In-process enrichment | Cheap on B1 | Competes with API CPU |
| B1 App Service vs Container Apps | Cost, Kudu simplicity | No staging slots, fixed timeout, limited scale |
| curl_cffi + Playwright | Coverage + speed | Dual maintenance; Playwright not in all zip-deploy paths |
| RLS vs app-only filters | Missed `WHERE` can’t leak | Harder debug; DEFAULT hides tenant_id in code |
| Bearer DB sessions vs JWT | Instant revoke | DB hit every request |
| UNION ALL activity feed | Server-side sort/page | Unwieldy past ~5–7 sources; RBAC duplicated |
| Temp 0 scoring vs creative gen | Determinism for decisions | Less “creative”; still needs validation against hallucination |
| Proxied blob upload vs direct | Content validation | Extra backend bandwidth/CPU |
| LLM for extraction vs site scrapers | Flexible across sites | Cost, hallucinations, rate limits |

---

# Lessons Learned

- Hosting limits shape architecture as much as domain logic.
- Test pre-auth paths explicitly when adding RLS.
- Role choice is part of the security design, not an afterthought.
- Treat LLM as an unreliable dependency; never make the batch all-or-nothing.
- Extraction quality depends on *which* page you fetch.
- Local/prod capability parity isn’t free on constrained deploys.
- Silent compatibility shims are worse than loud ones.
- Observability must not outrank core write availability (for this product).
- Call this out honestly in interviews as a known risk.

- Hosting limits (B1 timeout, no staging slots) shape architecture as much as domain logic
- Treat LLMs as unreliable dependencies; never make batches all-or-nothing
- Prefer loud failures over silent compatibility shims (`lastrowid` allowlist)
- Observability must not outrank core write availability for CRM mutations (best-effort audit logging)
- Dual schema sources of truth (SQLite vs Postgres) are a known risk — call them out honestly

# Behavioral Stories

### Ownership honesty

- State confirmed Event/CRM ownership; label Auth/RBAC/RLS/dbconn as likely/shared when discussing them
- Explicitly say Branding was built by a separate teammate

### Constraint-driven design

- B1 timeout shaping discovery/enrichment batching is a strong behavioral + technical story

### Risky migration without staging

- RLS rollout on live DB with no staging slots — rehearsal and phased rollout narrative

### Behavioral interviewer prompts

(From prior guide — answer with ownership-labeled stories only.)

- What did you own vs what did someone else own?
- Hardest technical decision and what you’d revisit?
- Time you designed for a hard infrastructure constraint (B1)
- Time you prioritized defense-in-depth (RLS) over shipping speed
- How do you rehearse risky migrations without staging slots?
- Time you learned a new stack quickly (Azure / multi-agent) and shipped
- Time you presented technical work to non-engineering stakeholders

### Stakeholder presentation (manager-confirmed)

**Situation:** End of internship; needed to socialize what shipped.  
**Action:** Presented the work to stakeholders yourself (not only via manager).  
**Result:** Manager recommendation: did a great job; supports “finishes what he starts / communicates clearly” narrative.  
**External tip:** Describe audience + technical themes + decisions; do not dump confidential product contents.


# Potential Interview Questions

### Software engineering / systems

- Walk me through the platform end-to-end from discovery to closed deal (sanitize product contents per NDA).
- Why a monolith? When would you split services?
- How did you work around the B1 ~230s timeout?
- Why subprocesses instead of a task queue? When Celery/Redis?
- How do you design REST APIs for this domain? Pagination? Field allowlisting?
- How would you scale discovery to 100 verticals?
- How would you scale the activity feed to 1M+ rows or 20 sources?
- Raw SQL vs ORM — defend the choice and the exit ramp.
- How does CI/CD fail closed? What do health checks prove / not prove?
- Proxied uploads vs SAS direct-to-blob — tradeoffs?
- How do you prevent SQL injection and mass-assignment on PATCH?

### Multi-tenancy & security (*likely* — speak carefully)

- Why RLS over application-level filtering only?
- How do you test RLS? What would you monitor for leaks?
- How does login work before tenant is known?
- Why Bearer sessions over JWT? PIN over password?
- How would cross-tenant sharing work if the product needed it?
- RBAC: middleware vs per-endpoint — how do they interact with PermGate?

### AI / LLM engineering

- How does the 5-dimension scoring rubric work? Why those weights?
- Why temperature 0 for scoring and 0.7 for drafts/summaries?
- How do you parse / validate structured LLM output?
- How do you handle hallucinations in scoring or aggregator mining?
- How would you evaluate scoring quality or A/B a rubric change?
- Rate limits: how do you stay under quota without starving enrichment?
- What happens when DeepSeek is down? Which features degrade how?
- Human-in-the-loop follow-up refine — why not fully autonomous send?
- Why urllib over an SDK for DeepSeek?
- How would you reduce LLM cost as volume grows?
- Prompt injection risks from free-text notes/interaction content?

### Data / CRM product engineering

- How does relationship scoring and decay work?
- Duplicate detection: email vs Jaccard name+company — false positive tradeoffs?
- Attendee import matching strategy and failure modes?
- How is event ROI computed from meetings/deals?
- How do you keep CRM metrics honest (decay, lifecycle)?

### Behavioral / ownership

- What did you own vs what did someone else own? (Branding!)
- Hardest technical decision and what you’d revisit?
- Time you designed for a hard infrastructure constraint (B1).
- Time you prioritized defense-in-depth (RLS) over shipping speed.
- How do you rehearse risky migrations without staging slots?

---

# Do Not Claim

- **Branding** platform ownership
- Solo ownership of **auth / RBAC / multi-tenancy / dbconn** unless you can defend it — say **likely / shared**
- **Possible** items (CORS, settings/user mgmt, theme tokens, rate-limit middleware design) as primary work
- Invented **business** metrics (revenue, dollar ROI, **tenant count**, tenant/customer **names**) beyond documented technical metrics (5–20 events/night, tables, endpoints, code sizes, etc.)
- Microservices, Kubernetes, multi-region HA
- Playwright works on **every** prod path without nuance
- JWT auth (it’s DB-backed Bearer tokens)
- Blue/green zero-downtime on B1 (no deployment slots; direct deploy + health gates)
- Experiences or metrics not in the accomplishments / system design / manager-confirmation docs
- Confidential **product contents** externally (NDA) — use technical + importance framing; product name omitted on resume

**Safe to claim (manager-confirmed):** actual tenants exist; multi-agent system shipped and running on Azure; stakeholder presentation; fast ramp on Azure/multi-agent; methodical design-before-code.

---

# Prep Checklist

- [ ] Deliver 30–60s elevator pitch
- [ ] Practice Stories 1–3 (discovery, scoring, enrichment) cold — strongest SWE + AI combo
- [ ] Practice Story 4 only with ownership caveat if asked about multi-tenancy
- [ ] Be ready to whiteboard scoring rubric + recommendation bands
- [ ] Be ready to explain B1 timeout → batching as a constraint-driven design story
- [ ] List three tradeoffs you’ll defend (monolith, RLS, curl_cffi/Playwright, or subprocess vs queue)
- [ ] Rehearse one debugging scenario (timeout, RLS login, or LLM 429)
- [ ] Explicitly state what you did **not** build (Branding)
