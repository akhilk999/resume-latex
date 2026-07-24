# CSA — Metrics

Never invent numbers. Prefer git/docs provenance. Resume org-size claims need explicit confirmation.

# Technical Metrics

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Website commits (Akhil Kasamsetty) | 247 | commits | `git shortlog` on website | Plus 15 as `akhilk999` |
| Points commits (Akhil) | 88 | commits | `git shortlog` on points | Dominant author |
| Website created | 2025-06-10 | date | GitHub / first commits | PR Chair era |
| Points created | 2026-03-14 | date | GitHub / first commits | Secretary era |
| Points migrations | 41 | files | `supabase/migrations` | Analyzed tree |
| Unique `public` SQL functions/RPCs | ~20 | functions | migration parse | Supports “20+ PostgreSQL functions” with slight rounding caution — prefer “~20” |
| Points docs pages | 8 | markdown files | `docs/` | Architecture, ops, onboarding, deploy, env, local |
| Website major page routes | 13+ | pages | `src/app/**/page.tsx` | Marketing surface |
| Live sites | 2 | URLs | CONTEXT | csatamu.org, points.csatamu.org |

# Business Metrics

| Name | Value | Confidence | Source | Notes |
|------|-------|------------|--------|-------|
| Replaced Sheets/Forms points workflow | Yes (qualitative) | Confirmed | CONTEXT + points docs | Core Secretary motivation |
| Recruitment improvement (after website) | ~20% | **Observed (confirmed)** | `CSA_CONTEXT.md` | PR Chair / branding site impact |
| Members on points platform | 250+ | **Observed (confirmed)** | `CSA_CONTEXT.md` | Org/roster scale for points system |
| Events tracked per semester | 400+ | **Observed (confirmed)** | `CSA_CONTEXT.md` | Points platform event capacity / volume |
| Discord community size | 300+ | **Observed (confirmed)** | `CSA_CONTEXT.md` | Count once across overlapping servers |
| Discord servers running bot | 3 | **Observed (confirmed)** | `CSA_CONTEXT.md` | Overlapping membership |
| `nnbot` application code by Akhil | No | Confirmed absent in git | git shortlog | Andrew Zhang sole committer |
| `nnbot` product design (Akhil) | Yes | CONTEXT-endorsed | `CSA_CONTEXT.md` | Collaborated with Andrew |
| `nnbot` GCP hosting (Akhil) | Yes | CONTEXT-endorsed | `CSA_CONTEXT.md` | All GCP hosting managed by Akhil |

# Awards / Recognition

None specific beyond officer roles (PR Chair, Secretary).

# Metrics To Avoid

| Claim | Why |
|-------|-----|
| Claiming sole Discord.js bot development / 900+ Discord members | Code is Andrew’s; Akhil = design + GCP; Discord 300+ once |
| Invented metrics beyond CONTEXT | Stick to confirmed observed set |
| Any invented attendance %, retention %, or Instagram follower lift | Not in sources |
| “Computer Science Association” | README typo; org is Chinese Student Association |
| Treating website and points as one repo | Two systems, two roles |
