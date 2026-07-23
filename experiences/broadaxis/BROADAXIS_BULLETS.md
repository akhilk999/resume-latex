# Broadaxis — Resume Bullets

Formula: Accomplished X as measured by Y by doing Z.
Rules: Do not invent metrics. Do not exaggerate ownership. Prioritize impact. Keep bullets concise.

Sources: `BROADAXIS_ACCOMPLISHMENTS.md`, `METRICS.md`, `BROADAXIS_SYSTEM_DESIGN.md`.
Ownership caveats: multi-tenant / RBAC / dbconn bullets must stay aligned with **likely** ownership unless evidence is upgraded; do not claim Branding.

# Backend SWE

- Designed and implemented ~100+ REST API endpoints in a monolithic FastAPI application with resource-oriented URL structure, server-side pagination, and consistent error handling
- Built an automated event discovery pipeline: web search → multi-strategy scraping (curl_cffi TLS impersonation + Playwright JS rendering) → LLM extraction → dedup → insert
- Implemented a 4-hourly enrichment pipeline scoring unscored events and backfilling speaker data with retry logic, rate limiting, and graceful degradation on LLM failures
- Designed PostgreSQL schema with 25 tables, 60+ foreign key relationships, per-tenant unique constraints, and optimized indexing for tenant-scoped queries
- Built a contact lifecycle pipeline (7 stages) with relationship scoring from interaction recency/frequency and automated decay rules
- Implemented CSV/XLSX attendee import with auto-column mapping, fuzzy matching, email deduplication, and two-phase commit
- Created a unified activity audit system merging 7 heterogeneous data sources into a single chronological feed with real actor attribution and RBAC-scoped visibility
- Built automated CI/CD pipelines on Azure DevOps deploying frontend (Static Web Apps) and backend (App Service via Kudu zip-deploy) with health-check gating on every push to main
- Led the multi-tenant migration of a production application, implementing PostgreSQL Row-Level Security across 25 tables without downtime or data leaks *(likely ownership)*
- Built a dual-database abstraction layer enabling a single Python/FastAPI codebase to run transparently on SQLite (local dev) and PostgreSQL (production) *(likely ownership)*
- Implemented granular RBAC with 4 roles and per-resource view/edit/delete permissions enforced at both middleware and database levels *(likely ownership)*

# Full Stack SWE

- Architected and built the entire Event Discovery and CRM platforms for Cirklo, a B2B event-intelligence platform serving BroadAxis across 6 industry verticals, using Python/FastAPI and React
- Built CRM frontend with 1,986-line React ContactsPage featuring lifecycle funnel bar, inline editing, server-side pagination, and document preview
- Built Events frontend with 1,775-line EventsPage featuring category tabs, scoring visualization, document management, and attendee import
- Implemented Kanban deal pipeline board with drag-and-drop stage transitions using @dnd-kit, probability tracking, and value aggregation
- Built tasks + follow-ups unified view with AI draft generation, refinement, and status management
- Designed permission-gated frontend routing with PermGate components and admin-only sections

# AI/ML

- Designed a 5-dimension AI scoring system using DeepSeek LLM to automatically evaluate industry events, replacing manual, inconsistent evaluation with data-driven recommendations
- Designed and implemented a 5-dimension LLM scoring rubric (Meeting Potential, Attendee Quality, Vertical Alignment, Strategic Opportunity, Cost Efficiency) with structured JSON output parsing and validation
- Built AI follow-up draft generation using DeepSeek with user refinement capability (suggest edits → LLM revises)
- Implemented LLM-powered aggregator mining: extracting official event URLs from aggregator listing pages to expand discovery reach
- Built contact AI summaries from interaction history with persistent storage and template fallback

# Robotics

_(Not applicable — no robotics work in this experience.)_

# Product

- Translated BroadAxis's manual event research workflow into an automated platform handling 6 industry verticals with nightly discovery
- Connected event attendance directly to CRM pipeline: contacts met at events → lifecycle tracking → deals pipeline
- Designed systematic event evaluation replacing gut-feel decisions with data-driven scoring, enabling ROI-based event investment decisions
- Built a platform that can serve multiple client organizations with guaranteed data isolation via database-level tenant separation *(capability; likely ownership on RLS)*
- Leveraged AI throughout: event evaluation, contact summarization, follow-up drafting — making AI a product feature, not a demo
