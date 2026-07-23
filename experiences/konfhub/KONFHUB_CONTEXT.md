# KonfHub — Context

## Overview

- **What was built:** A backend proof of concept (POC) that turns structured event details into marketing assets — persuasive event description, SEO keywords, and thematic poster/visual imagery — using LLMs and image generation models. Two approaches were explored: a direct prompt-chained LLM pipeline and a multi-agent (Strands) workflow.
- **Why it was built:** KonfHub is an AI-powered event management / ticketing platform (event websites, registrations, check-in, attendee engagement). Organizers currently create event copy and promotional visuals manually (e.g. writing descriptions, designing in tools like Canva). The intended product direction is: when a user creates an event and enters details on KonfHub, the system automatically generates a poster (and supporting copy) immediately afterward.
- **Who used it:** Internship/internal POC — not shipped as a production KonfHub UX feature based on available evidence. Intended eventual users: event organizers / conference hosts creating events on KonfHub.
- **Company product (external):** KonfHub (konfhub.com) — India-headquartered event tech platform with ticketing, check-in, AI networking, AI photo gallery, etc. Native AI poster generation after event creation was the **internship POC intent**, not a documented live product feature as of research.

## Personal Ownership

- **Role:** Unpaid Software Engineering Intern (Remote), Jun 2025 – Jul 2025
- **Features personally built (confirmed — sole committer on internship repo `akhilk999/konfhub-internship`):**
  - Direct LLM pipeline (`llm-testing`): 5W event input → description + keywords → intermediate image prompt → poster/image generation
  - Provider-agnostic OOP generation layer (`BaseModel`, `Generator`, Nova Micro / SD 3.5 / Gemini image adapters)
  - Multi-model Bedrock bake-off and prompt iteration
  - Bedrock Guardrails on text path
  - Strands multi-agent POC (`DescriptionAgent` → `PosterAgent`) with custom filesystem tools
  - 5-scenario agent evaluation harness + large visual artifact corpus
  - Flask Video CRUD learning API (SQLite)
  - Jira Forms Cloud API client (5 operations)
  - Canva MCP via Strands MCPClient — produced **20+ branded designs** during internship experimentation (observed); later de-emphasized/removed as the primary automated path after Canva Connect API limitations for AI generation
- **Areas owned:** Backend/AI POC for event description + poster generation; learning modules for Flask REST and Jira Forms
- **Areas not worked on:** Production KonfHub product surface (event CMS, ticketing, check-in, AI networking, photo gallery, etc.); shipping this POC into live event-creation UX; Branding/design systems for KonfHub marketing site

## Constraints

- **Team size:** Solo on this internship repo (sole git committer). Broader KonfHub engineering team size unknown.
- **Timeline:** ~6 weeks (repo activity 2025-06-19 → 2025-07-29; resume dates Jun 2025 – Jul 2025)
- **Compensation:** Unpaid internship
- **Technologies:** Python; Amazon Bedrock (Nova Micro, Claude Sonnet 4, Stability SD 3.5, Titan, Guardrails, Prompt Management); Google Gemini 2.0 Flash image; Strands Agents SDK; Flask / Flask-RESTful / SQLAlchemy / SQLite; Atlassian Jira Forms API; MCP client scaffolding (Canva — deactivated); `.env` secrets; argparse CLIs
- **Scope:** POC / CLI and local artifact pipelines — not a horizontally scaled production microservice with auth, queues, or SLOs
- **Known inaccuracies / provenance notes:**
  - **Repo evidence** supports code/artifact counts (models, PNGs, PRs, etc.) but does not encode personal eval percentages.
  - **Internship observations (Akhil)** support: **~65% content accuracy improvement**, formatting errors **~25% → ~3%** after prompt/chaining iteration, and **20+ branded designs** via Canva MCP experimentation. Treat as **observed** metrics (see `METRICS.md`), not invented.
  - **70% manual design time reduction** appears on current resume TeX but was **not** reconfirmed here — verify before using.
  - Canva MCP: claim **20+ designs observed during experimentation**; also note later **de-scope as primary path** due to Canva Connect API AI-generation limits — do not imply a shipped production Canva integration inside KonfHub.
  - Do not claim production deployment into KonfHub event-creation UX unless confirmed outside the repo.
  - Git history supports POC ownership of this repo only — not company-wide product ownership.

## Important Instructions

- Emphasize **backend / AI POC** for automatic poster (+ description/keywords) generation from event details — product intent: generate right after organizers enter event details on KonfHub.
- Treat work as **internship POC ownership**, not ownership of KonfHub’s live AI features (networking, photo gallery, etc.).
- Prefer **repo-confirmed** artifact metrics plus **CONTEXT-approved observed** eval metrics; do not invent new percentages.
- For Canva MCP: OK to claim **20+ designs from internship Canva MCP work**; pair with honesty about API limits / not shipping MCP as the final primary generator.
- Flask and Jira modules are **learning / stack onboarding** work — label them clearly vs the core AI generation POC.
- Prefer this CONTEXT + `METRICS.md` over older “unsupported” notes in extraction docs when they conflict on observed eval metrics.
