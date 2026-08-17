# Broadaxis — Context

## Overview

Cirklo is a B2B CRM + event-intelligence platform built for BroadAxis. It tracks industry events worth attending or sponsoring, turns event engagement into a CRM pipeline (contacts → deals), automates discovery of new events to evaluate, and runs a social/branding content pipeline around those events.

Target users: B2B business development teams. Originally built for BroadAxis — a consulting firm focused on AI modernization for government, oil & gas, staffing, private equity, and Microsoft enterprise customers. **Production status (confirmed by manager Rohan Mandrekar, verbally + LinkedIn recommendation):** the product has **actual tenants** (multiple client organizations using the platform), is **deployed and running on Azure**, and includes a **shipped multi-agent system** (manager framing of the agentic discovery/enrichment/LLM workflows). Do **not** invent a tenant count or name other organizations.

Business problem: Before Cirklo, event tracking and CRM were siloed. Events were tracked in spreadsheets, contacts from events were lost, and there was no systematic way to evaluate which events were worth the investment. The platform automates this entire workflow and connects event attendance directly to the sales pipeline.

## Confidentiality / NDA

Akhil signed an NDA covering Cirklo product contents. For **external** use (applications, public resumes, interviews with other companies, LinkedIn):

- **Safe:** stack/technologies, engineering challenges (timeouts, RLS, scrapers, CI/CD), ownership of Event/CRM engineering, impact framed as “production multi-tenant platform on Azure,” stakeholder presentation, ramp on Azure/multi-agent work.
- **Avoid disclosing:** proprietary product workflows beyond high-level category, customer/tenant identities, internal business data, confidential domain specifics that are not already public, and any NDA-restricted implementation detail you would not want reproduced outside BroadAxis.
- **Internal KB (`experiences/broadaxis/`):** may retain technical detail for personal prep; treat as private. Prefer sanitized wording when promoting bullets to `resume/` or speaking externally.

Major subsystems:
1. **Event Discovery** — Automated web search, scraping, scoring pipeline that finds and evaluates industry events
2. **CRM** — Contacts, companies, deals pipeline, interactions, follow-ups, meetings, tasks
3. **Branding** — Content marketing pipeline (NOT built by Akhil)
4. **Authentication & RBAC** — PIN-based auth, granular permissions, multi-tenant isolation
5. **Dashboard & Analytics** — Aggregated metrics, lifecycle funnels, CSV exports
6. **Automation** — Scheduled pipelines for discovery and enrichment, relationship decay
7. **AI** — DeepSeek LLM integration for event scoring, contact summaries, follow-up drafts

Architecture: React 19 SPA (Vite) → FastAPI monolith (~5,000 lines) → PostgreSQL (prod) / SQLite (local dev). Deployed on Azure: Static Web Apps (frontend), App Service B1 (backend), PostgreSQL Flexible Server (database), Blob Storage (documents). CI/CD via Azure DevOps Pipelines.

Akhil was the primary engineer for the Event and CRM platforms. The Branding platform was built by a separate team member.

## Personal Ownership

### Confirmed contributions

#### Event Platform

**Event Discovery Pipeline**
- Built the automated event discovery engine (`discover.py`, ~113KB) that searches the web for industry events across 6 verticals (Texas Government, Oil & Gas, Workforce, Staffing, Microsoft, AI)
- Implemented multi-strategy web scraping with curl_cffi browser-TLS impersonation as primary and Playwright headless Chromium as fallback
- Built search query expansion system: per-vertical seed phrases expand into regional/type variants, capped at 24 queries
- Implemented aggregator mining: LLM-powered extraction of official event URLs from aggregator listing pages (10times, Eventbrite, etc.)
- Built URL deduplication by normalized URL with canonical_url tracking
- Implemented JSON-LD and regex-based structured data extraction from event pages
- Added "add-from-url" capability for known events the discovery sweep missed — single-URL scrape with immediate scoring
- Built defense against future-dated events (rejects events >365 days out, events >1 year old)

**Event Scoring Pipeline**
- Designed 5-dimension AI scoring rubric (Meeting Potential 0-35, Attendee Quality 0-30, Vertical Alignment 0-20, Strategic Opportunity 0-10, Cost Efficiency 0-5)
- Recommendation bands: Attend ≥80, Consider ≥65, Monitor ≥50, Skip <50
- Integrated DeepSeek LLM for automated evaluation with structured JSON output
- Scored criteria stored as individual dimensions (a-e) with rationale text
- Scoring history tracked in scoring_history table for audit trail

**Event Enrichment Pipeline**
- Built enrichment engine (`agent/enrich.py`, ~400 lines) running in-process on App Service
- Two-phase pipeline: Phase 1 — re-scrape event pages for missing speakers/details via API call; Phase 2 — score unscored events via DeepSeek LLM
- Staleness detection: rescore events when new speaker data added, score >30 days old, or never scored
- Rate limiting: 2-second sleep between DeepSeek calls to stay under API limits
- Retry logic with 2 attempts per LLM call, handling 429 rate limits
- Per-tenant vertical configuration for scoring context
- Non-fatal error handling: failed LLM calls retried next cycle, individual event failures don't kill the batch

**Event CRUD & Management**
- Full REST API for events: GET list (with filtering), POST create, PATCH update, GET detail
- Manual event creation with validation (name required, future-dated events can't be marked attended)
- Event status lifecycle: discovered → registered → attended
- Event registrations tracking with automatic sync on status changes
- Category tabs: State of Texas, O&G, Workforce, Staffing, Microsoft, AI, Others
- Field-level editing for 25+ event fields including cost, attendance, speakers, ROI
- Event URL uniqueness constraint (per-tenant in multi-tenant setup)

**Event Documents (Blob Storage)**
- Built document upload/download with Azure Blob Storage integration
- File type allowlist (PDF, DOC/DOCX, XLS/XLSX, PPT/PPTX, JPG, PNG, TXT)
- 25MB file size limit with backend validation before storage
- Backend-proxied upload (not direct-to-blob) for content validation
- Time-limited SAS URLs for viewing and downloading (15-minute expiry)
- Documents linked to events with optional contact association
- Category tagging (meeting_notes, planning_doc, contract, presentation, other)

**Event ROI**
- Built ROI calculation engine aggregating meetings, deals, pipeline value per event
- Per-event ROI score stored as percentage
- Bulk refresh endpoint for recalculating all events

**Event Contacts**
- Event-to-contact linking with status tracking (planning_to_meet, met, missed, introduced_by)
- Auto-match existing contacts by name+company when adding to event
- Create new contacts on-the-fly when adding to event (with email dedup)
- Interaction logging at events auto-creates follow-up tasks
- Event attendees tracking with contact matching and rank

**Attendee CSV Import**
- Two-phase import flow: upload → preview → commit
- Supports CSV and XLSX formats with auto-detection
- Auto-column mapping via keyword-based fuzzy match (name, email, title, company, linkedin, phone, notes)
- Email deduplication on import
- Name+company fallback matching when email unavailable
- Import history tracking with counts (created, matched, total)
- Creates event_contacts AND event_attendees entries

**Pipeline Events View**
- Events sorted by score with filtering by vertical, recommendation, status
- Pipeline summary with aggregate counts (total, attending, high-scored, by sector)
- Upcoming/past toggle

#### CRM Platform

**Contacts (CRM)**
- Full CRUD for contacts with 30+ fields (name, title, company, email, phone, linkedin, vertical, lifecycle stage, relationship level, tags, owner, notes, etc.)
- Lifecycle stage pipeline: Lead → Qualified → Active → Opportunity → Customer (7 stages)
- Relationship scoring (0-100) computed from recency (60%) + frequency (40%) of interactions
- Server-side pagination with configurable limit/offset
- Multi-dimensional filtering: search, source, vertical, lifecycle_stage, owner, priority
- Default sort by created_at DESC (newest first)
- Inline editing support via PATCH endpoint with field allowlisting
- Contact profile endpoint returns interactions, follow-ups, meetings in one call
- Referral network: tracks referred_by with bidirectional lookup (referrals made)
- Contact events: lists all events a contact has attended
- Contact deals: aggregates all deals for a contact with stage/closed sorting
- Contact tasks: lists tasks with assignee name
- Contact notes: CRUD for timestamped notes with type classification
- Auto-resolves company_id from company name on update

**Contact Lifecycle Pipeline**
- 7-stage lifecycle: new → engaged → qualified → opportunity → proposal → client → inactive
- Lifecycle counts endpoint aggregating contacts by stage
- Chevron funnel bar visualization

**Contact Health & Decay**
- Health scoring via crm_health.py: scores individual contacts and provides cold contact detection
- Relationship decay automation: warm/known_contact → cold after 180 days no touch, active_client → known_contact after 90 days
- Stale contact detection with configurable threshold
- is_active flag computed from relationship_level + days since last touch (≤180 days)

**Contact AI Summaries**
- DeepSeek-generated 2-3 sentence contact summaries from interaction history
- Stored in ai_summary column with summary_generated_at timestamp
- Fallback to template-based summary when LLM unavailable

**Contact Duplicate Detection**
- Identifies duplicate contact pairs by: identical email, OR same company + similar name (≥70% token overlap)
- Configurable result threshold
- Name similarity via Jaccard index on word tokens

**Companies**
- Full CRUD with name uniqueness enforced at DB level
- Rich detail view: contacts, deals, events linked to the company (via contact associations)
- Pipeline value aggregation per company
- Relationship_level classification with priority sorting
- 409 conflict on duplicate name creation
- Company name case-insensitive uniqueness

**Deals Pipeline (Kanban)**
- 6-stage pipeline: Prospect → Discovery → Proposal → Negotiation → Closed Won → Closed Lost
- Stage-specific fields: probability %, expected close date, deal value, lost reason
- Deal CRUD via crm_deals.py with field cleaning (empty string → NULL coercion)
- Pipeline board aggregated by stage with deal counts and values
- Stage movement endpoint with activity logging
- Contact-linked deals with contact name join

**Interactions**
- Logging: type (event_meeting, call, email, linkedin, referral, inbound), date, notes, topics, commitments, next step
- Auto-creates follow-up tasks when logging event interactions
- Async follow-up draft generation spawned as subprocess
- Interactions linked to contacts and events

**Follow-ups**
- AI-generated follow-up drafts via DeepSeek (crm_draft_followup.py)
- Follow-up refinement: edit AI draft with user suggestions via LLM revision
- Queue management with priority levels (1-4) and priority labels
- Status lifecycle: pending → sent, with deferred and dismissed options
- Channel tracking: email, linkedin, phone
- Source tracking: event_interaction, contact_reminder, manual
- Follow-up upsert: setting follow_up_date on contact creates/updates follow-up
- Overdue detection endpoint

**Meetings**
- Schedule meetings with contacts linked to events
- Status tracking: scheduled, completed, cancelled, no_show
- Pre-meeting message tracking (pre_meeting_sent flag)
- Outcome and completion tracking
- Query by event_id, status, upcoming days

**Tasks**
- CRUD with title, status, priority (urgent/high/medium/low), type, due date, assignee
- Linked to contacts, deals, events for context
- Merged view with follow-ups in Tasks page
- Status cycling: not_started → in_progress → completed
- Task type classification: outreach, meeting_prep, research, proposal, event_prep, internal, follow_up

**Activities / Audit Log**
- Built comprehensive activity feed merging 7 sources: interactions, follow_ups, meetings, deals, event_contacts, attendee_imports, activity_log
- Real actor attribution: interactions (logged_by), follow_ups (sent_by), meetings (scheduled_by), deals (updated_by)
- RBAC-scoped: non-admins only see their own contacts' activities or their own actions
- Activity type filtering with comma-separated multi-type support
- Date-range archiving with "since" parameter
- Write-time logging via centralized `_log_activity()` called by 40+ endpoints
- Chronological merged feed with actor, timestamp, detail, and navigation links

**Analytics & Dashboard**
- Dashboard stats: total leads, qualified leads, opportunities, revenue pipeline (all with 30-day deltas)
- Pipeline analytics: total value, weighted pipeline, by-stage breakdown, avg deal age
- Conversion analytics: win rate, lifecycle funnel, per-vertical deal value, 30-day activity trend
- Weekly comparison: meetings completed, followups sent, new contacts, interactions logged (this week vs last)
- Leads by source donut chart data
- CSV exports: contacts, deals, interactions with streaming response

### Likely contributions

**Authentication System**
- PIN-based login with bcrypt hashing
- Legacy plaintext PIN auto-upgrade to bcrypt on first successful login
- 24-hour Bearer token sessions stored in user_sessions table
- Rate limiting: 10 attempts per 60-second window per IP (in-memory)
- Logout: deletes session token
- Invite flow: admin generates invite tokens with 7-day expiry, email-based activation

**RBAC (Role-Based Access Control)**
- 4 roles: Admin, Partner, Member, Guest — with default permission templates
- Granular per-resource permissions (events, crm, branding, pipeline, analytics, settings, users) with can_view/can_edit/can_delete flags
- Frontend PermGate component with server-side enforcement on all routes
- Middleware-level auth enforcement (ASGI rbac_middleware)
- Admin bypasses all permission checks
- Vertical filter for event visibility (permission-scoped)
- Service token bypass for internal endpoints (/api/internal/*)

**Multi-Tenancy Architecture**
- tenant_id column on all 25 data tables (Phase 2)
- Multi-phase rollout: backfill existing data → NOT NULL constraints → per-tenant UNIQUE constraints → RLS policies → tenant_verticals config → platform admin switcher
- PostgreSQL Row-Level Security (RLS) with FORCE ROW LEVEL SECURITY on all tables
- app_current_tenant_id() function sets tenant context from session variable
- DEFAULT on tenant_id columns auto-populates from session context
- auth_bootstrap policy: narrow escape hatch for pre-auth queries (login, invite accept)
- Platform admin tenant switcher: acting_tenant_id for cross-tenant support views
- Per-tenant vertical configuration (tenant_verticals table)
- Tenant-specific brand voice prompts

**Database Abstraction Layer (dbconn.py)**
- Dual-database support: SQLite (local dev) and PostgreSQL (production) from one codebase
- Automatic ? → %s placeholder translation
- datetime('now') → NOW() translation
- lastrowid emulation on PostgreSQL via RETURNING id with _ID_TABLES allowlist
- RealDictRow compatibility for named column access on both drivers
- Connection pooling via ThreadedConnectionPool for PostgreSQL
- Tenant context injection via SET app.current_tenant_id

### Possible contributions

- Rate limiting middleware design
- CORS configuration
- Settings page endpoints
- User management endpoints (list, update, delete, permissions)
- Theme/UI token system

## Manager / recommendation evidence

**Manager:** Rohan Mandrekar (Akhil reported directly to him).

**LinkedIn recommendation (verbatim themes; full text in `REFERENCES/REFERENCES.md`):**

- Came in with little Azure / multi-agent background; ramped in weeks and shipped working features
- Structured, methodical design-before-code approach
- By end of internship: shipped a complete multi-agent system, deployed and running on Azure
- Presented work to stakeholders and did well
- Characterized as learns fast and finishes what he starts

**Verbal guidance from Rohan:** Safe to claim the product has **actual tenants** (real client organizations on the platform). Still do not invent counts or names.

## Constraints

- Team size: ~1–2 engineers on Event/CRM (Akhil primary for Event + CRM; Branding owned by another teammate)
- Timeline: Internship / build of Cirklo for BroadAxis (see role dates on resume)
- Technologies: React 19 + Vite, FastAPI (Python), PostgreSQL (prod) / SQLite (dev), Azure (Static Web Apps, App Service B1, PostgreSQL Flexible Server, Blob Storage), Azure DevOps, DeepSeek LLM, curl_cffi + Playwright, Serper / SearXNG
- Known inaccuracies: Prefer this CONTEXT and confirmed ownership labels over Git history for attribution
- NDA: see Confidentiality section above — external speakables ≠ full internal KB detail

## Important Instructions

- Do **not** attribute Branding platform work to Akhil
- Focus on **Event** and **CRM** ownership for resume and interviews
- Treat Auth, RBAC, multi-tenant RLS, and `dbconn` dual-database work as **likely** contributions unless evidence is upgraded — do not claim sole ownership
- Do not invent business metrics (revenue, dollar ROI, tenant count); use only numbers in `METRICS.md`
- **May claim:** production multi-tenant product with actual tenants; Azure-deployed multi-agent system shipped; stakeholder presentation (manager-confirmed)
- Git history alone is not proof of ownership
- When writing external resume/interview copy, prefer technical + importance framing over confidential product contents
