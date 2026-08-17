# Broadaxis — Resume Bullets

Formula: Accomplished X as measured by Y by doing Z.
Rules: Do not invent metrics. Do not exaggerate ownership. Prioritize impact. Keep bullets concise.

Sources: `BROADAXIS_ACCOMPLISHMENTS.md`, `METRICS.md`, `BROADAXIS_SYSTEM_DESIGN.md`, `REFERENCES/REFERENCES.md` (manager confirmation).
Ownership caveats: multi-tenant / RBAC / dbconn bullets must stay aligned with **likely** ownership unless evidence is upgraded; do not claim Branding.
**NDA:** Prefer technical + impact framing in resume bullets; avoid confidential product-content detail. Safe to say production multi-tenant platform with real tenants; Azure-deployed multi-agent system; stakeholder presentation.
**Tenant count:** Existence confirmed; never invent N or names.

# Backend SWE

- Designed and implemented ~100+ REST API endpoints in a monolithic FastAPI application with resource-oriented URL structure, server-side pagination, and consistent error handling
- Built an automated event discovery pipeline: web search → multi-strategy scraping (curl_cffi TLS impersonation + Playwright JS rendering) → LLM extraction → dedup → insert
- Implemented a 4-hourly enrichment pipeline scoring unscored events and backfilling speaker data with retry logic, rate limiting, and graceful degradation on LLM failures
- Designed PostgreSQL schema with 25 tables, 60+ foreign key relationships, per-tenant unique constraints, and optimized indexing for tenant-scoped queries
- Built a contact lifecycle pipeline (7 stages) with relationship scoring from interaction recency/frequency and automated decay rules
- Implemented CSV/XLSX attendee import with auto-column mapping, fuzzy matching, email deduplication, and two-phase commit
- Created a unified activity audit system merging 7 heterogeneous data sources into a single chronological feed with real actor attribution and RBAC-scoped visibility
- Built automated CI/CD pipelines on Azure DevOps deploying frontend (Static Web Apps) and backend (App Service via Kudu zip-deploy) with health-check gating on every push to main
- Led the multi-tenant migration of a production application now serving real client organizations (tenants), implementing PostgreSQL Row-Level Security across 25 tables without downtime or data leaks *(likely ownership; tenant existence manager-confirmed)*
- Built a dual-database abstraction layer enabling a single Python/FastAPI codebase to run transparently on SQLite (local dev) and PostgreSQL (production) *(likely ownership)*
- Implemented granular RBAC with 4 roles and per-resource view/edit/delete permissions enforced at both middleware and database levels *(likely ownership)*
- Shipped a multi-agent discovery/enrichment system on Azure (FastAPI + scheduled agent pipelines + DeepSeek), ramping from limited prior Azure/multi-agent background *(manager-confirmed framing)*

# Full Stack SWE

- Architected and built the Event Discovery and CRM platforms for a production multi-tenant B2B event-intelligence product (real client tenants) across 6 industry verticals, using Python/FastAPI and React
- Built CRM frontend with 1,986-line React ContactsPage featuring lifecycle funnel bar, inline editing, server-side pagination, and document preview
- Built Events frontend with 1,775-line EventsPage featuring category tabs, scoring visualization, document management, and attendee import
- Implemented Kanban deal pipeline board with drag-and-drop stage transitions using @dnd-kit, probability tracking, and value aggregation
- Built tasks + follow-ups unified view with AI draft generation, refinement, and status management
- Designed permission-gated frontend routing with PermGate components and admin-only sections
- Presented shipped work to stakeholders end-to-end *(manager-confirmed)*

# AI/ML

- Designed a 5-dimension AI scoring system using DeepSeek LLM to automatically evaluate industry events, replacing manual, inconsistent evaluation with data-driven recommendations
- Designed and implemented a 5-dimension LLM scoring rubric (Meeting Potential, Attendee Quality, Vertical Alignment, Strategic Opportunity, Cost Efficiency) with structured JSON output parsing and validation
- Built AI follow-up draft generation using DeepSeek with user refinement capability (suggest edits → LLM revises)
- Implemented LLM-powered aggregator mining: extracting official event URLs from aggregator listing pages to expand discovery reach
- Built contact AI summaries from interaction history with persistent storage and template fallback
- Shipped multi-agent Azure workflows (discovery → scrape/extract → enrich/score) with retries, rate limits, and degradation under App Service constraints *(manager-confirmed “multi-agent system” ship)*

# Robotics

_(Not applicable — no robotics work in this experience.)_

# Product

- Translated a manual event-research workflow into an automated production platform handling 6 industry verticals with nightly discovery, used by real client tenants
- Connected event attendance directly to CRM pipeline: contacts met at events → lifecycle tracking → deals pipeline
- Designed systematic event evaluation replacing gut-feel decisions with data-driven scoring, enabling ROI-based event investment decisions
- Delivered multi-tenant isolation so multiple client organizations can share one deployment with database-level data separation *(capability + production tenants manager-confirmed; RLS ownership likely)*
- Leveraged AI throughout: event evaluation, contact summarization, follow-up drafting — making AI a product feature, not a demo
- Owned stakeholder presentation of shipped work *(manager-confirmed)*

# Quant / Trading SWE

_(No trading/market domain — systems/data emphasis only.)_

- Built automated discovery and enrichment pipelines (search → scrape → LLM extract → dedup → insert; 4-hourly rescoring with retries/rate limits) that continuously process event data under App Service timeout budgets
- Designed a 5-dimension quantitative scoring rubric with structured JSON validation so event investment decisions use consistent numeric criteria instead of ad-hoc judgment
- Implemented contact relationship scoring from interaction recency/frequency with automated decay rules to keep CRM rankings current
- Owned production Python/FastAPI services and PostgreSQL schemas optimized for tenant-scoped analytical queries (~100+ REST endpoints, 25 tables)

# Forward Deployed

- Translated manual event-research and CRM workflows into a shipped multi-tenant platform operators use across 6 verticals (discovery → score → attend → pipeline), with real client tenants in production
- Connected attendance outcomes to deal/follow-up tooling so business users could act on events without spreadsheet handoffs
- Built operator-facing CRM/Events UIs (lifecycle funnel, scoring visualization, attendee import, Kanban deals) so non-engineers could run day-to-day workflows
- Designed systematic evaluation replacing gut-feel decisions with explainable multi-dimension scores stakeholders could discuss
- Presented the shipped system to stakeholders *(manager-confirmed)*

# Infra / Platform

- Built Azure DevOps CI/CD (4 pipeline definitions, 10+ steps) deploying frontend (Static Web Apps) and backend (App Service via Kudu zip-deploy) with health-check gating on every push to main
- Scheduled nightly discovery and 4-hourly enrichment as hands-off automation within App Service B1 timeout and DeepSeek rate-limit constraints
- Dual-environment discipline: SQLite local / PostgreSQL production behind one FastAPI codebase, with secret stripping and RLS enable steps in deploy *(db abstraction: likely ownership)*
- Operated under constrained hosting (no K8s/Docker-primary path in prod zip-deploy) — do not claim Kubernetes or multi-region HA
- Shipped and operated the multi-agent system live on Azure App Service *(manager-confirmed deploy)*
