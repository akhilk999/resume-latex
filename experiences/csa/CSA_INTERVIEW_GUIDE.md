# CSA — Interview Guide

> Sources: `CSA_CONTEXT.md`, `CSA_ACCOMPLISHMENTS.md`, `CSA_SYSTEM_DESIGN.md`, `METRICS.md`

# Project Summary

Two production systems for Texas A&M **Chinese Student Association**:

1. **PR Chair — Website** (`csatamu.org`): Next.js public site for branding/visibility (Instagram-era).
2. **Secretary — Points** (`points.csatamu.org`): Next.js + Supabase platform replacing **Google Sheets + Google Forms** for points, events, QR check-in, and officer workflows.

### Elevator pitch (30–60s)

> In CSA I built our public Next.js site as Public Relations Chair to improve visibility and branding. After becoming Secretary, I replaced our Google Sheets and Forms points process with a full Next.js and Supabase app—TAMU Google login, RBAC, QR check-in, automated point totals with Postgres triggers, leaderboards, Google Calendar sync, and semester admin tools—so officers aren’t managing membership points in spreadsheets anymore.

# My Role

| Level | Scope |
|-------|--------|
| **PR Chair** | Primary builder of `tamucsa/website` |
| **Secretary** | Primary builder of `tamucsa/points` (architecture, migrations, app, docs) |
| **Do not claim** | Sole Discord.js coding (`nnbot` app = Andrew); invented metrics beyond CONTEXT-approved observed set |

# Technical Challenges

## Challenge 1 — Replacing Sheets/Forms without breaking semester ops

### Situation

Points lived in Google Sheets/Forms; error-prone and hard to enforce rules.

### Problem

Ship an authenticated system officers will actually use mid-org-lifecycle.

### Solution

Supabase members/events/attendance model; CSV import to match existing rosters; ops docs and onboarding guides.

### Tradeoffs

CSV still exists at the edges (import), but Sheets is no longer the system of record for points.

### Result

Live `points.csatamu.org` with officer/admin workflows documented for transfer.

---

## Challenge 2 — Encoding points policy in the database

### Situation

Categories, JT weekly caps, spectator caps, counted flags must stay consistent.

### Problem

UI-only math drifts; unbounded selects hit PostgREST limits.

### Solution

Triggers + recompute RPCs writing `member_semester_points`; leaderboard views; aggregation RPCs for officer pages.

### Tradeoffs

More SQL complexity; every new attendance path must respect triggers.

### Result

Cached leaderboards + documented perf fixes (PF/KI issues).

---

## Challenge 3 — Auth, RBAC, and onboarding edge cases

### Situation

Mix of self-register and roster-import members; Jiating assignment lags dues.

### Problem

Don’t lock paying members out while families are unsorted.

### Solution

Separate `pending_member` access gate from Pending JT assignment; TAMU domain enforcement; RLS + layout guards.

### Tradeoffs

More statuses to teach officers; clearer than one overloaded “pending” state.

### Result

Documented member lifecycle in OPERATIONS/ARCHITECTURE.

---

## Challenge 4 — Public branding site vs private ops app

### Situation

Instagram/visibility needs differ from sensitive points data.

### Problem

One site can’t safely be both brochure and roster database.

### Solution

Split `website` vs `points`; different auth models.

### Tradeoffs

Two codebases/deploys; clearer security boundaries.

### Result

csatamu.org for PR; points.csatamu.org for Secretary ops.

# Debugging Stories

1. Stale auth cookies / refresh_token errors → middleware cookie clear
2. Calendar sync bugs → dedicated fix commits
3. Scheduled publish cron / APP_URL → workflow + route fixes
4. Leaderboard/query performance → precompute + SQL RPCs
5. RLS/security hardening passes

# Architecture Decisions

1. Next.js + Supabase over Sheets
2. RLS + role layouts
3. Cached semester points
4. QR + officer check-in
5. Google Calendar / Places integrations
6. Cron publish via GitHub Actions
7. Separate marketing website
8. Write transfer docs as a first-class deliverable

# Lessons Learned

- Org software fails if officers can’t operate it — docs matter
- Policy belongs in the database when many clients touch attendance
- Split public and private surfaces early
- Resume metrics: use CONTEXT-confirmed set (20% recruitment, 250+ members, 400+ events/semester, Discord 300+ + design/GCP roles)

# Behavioral Stories

### Role-driven engineering

- PR Chair → branding site; Secretary → points reform (same org, different jobs)

### Replacing legacy process

- Saw Sheets/Forms pain → built the replacement and documented handoff

### Ownership transfer

- README/ops docs explicitly written for next year’s officers

# Potential Interview Questions

- Why not keep Google Sheets with Apps Script?
- How do points stay correct after check-in/uncheck?
- Explain RLS vs layout checks.
- How does QR check-in work end-to-end?
- What happens at spring semester close?
- How do you prevent non-TAMU accounts?
- Website vs points — threat model differences?
- Where’s the Discord bot? (Answer: `tamucsa/nnbot` — Andrew wrote Discord.js code; I co-designed it and run GCP hosting for 300+ members across 3 overlapping servers)

# Do Not Claim

- Sole authorship of the Discord.js bot codebase (Andrew Zhang); inventing 900+ by summing servers
- Unconfirmed 20% recruitment, 250+ members, 400+ events/semester
- That the marketing site alone is the points system
- Solo credit for minor website commits by others
