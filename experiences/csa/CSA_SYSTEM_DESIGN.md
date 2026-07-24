# CSA — System Design

> Sources: `CSA_CONTEXT.md`, `tamucsa/points` docs/migrations, `tamucsa/website` structure.
> Two systems: public website (PR) and points platform (Secretary).

# Overview

CSA runs two Akhil-led web systems:

1. **Public website** (`csatamu.org`) — Next.js marketing/branding site for visibility (Instagram-era org presence).
2. **Points** (`points.csatamu.org`) — Next.js + Supabase operational platform replacing Google Sheets/Forms for membership points, events, check-in, and officer admin.

Points is the primary system-design interview artifact.

# Architecture

### Points

```
Browser (Next.js App Router)
  ├─ (auth) public + login/register/pending
  ├─ (dashboard) member leaderboard/events/profile
  ├─ (officer) events, check-in, QR, members
  ├─ (admin) members import/roles, semesters
  └─ /checkin/[code] QR self check-in
           │
           ▼
    Middleware (session refresh, public allowlist)
           │
           ▼
    Supabase Auth (Google / TAMU domain)
    Supabase Postgres + RLS + RPCs/triggers
           │
           ├── Google Calendar API (event sync)
           ├── Google Places API (locations)
           └── GitHub Actions → /api/cron/publish-events
```

### Website

```
Browser → Next.js (static/SSR pages + content modules)
        → Vercel
        → optional Google Sheets reads (JTO medals)
        → contact email providers
```

### Discord bot (`nnbot`)

```
Discord Gateway (3 guilds, overlapping members)
        → nnbot (Discord.js / TypeScript)  [Andrew Zhang — application]
        → GCP-hosted runtime               [Akhil — hosting/ops]
        → per-guild JSON config (verify category, roles, banned words)
```

# Components

### Points — major components

| Area | Responsibility |
|------|----------------|
| Auth callback | OAuth code exchange; TAMU email gate; link `members` |
| Dashboard shell | Sidebar, theme, member gating |
| Leaderboards | Individual, Jiating, published standings snapshots |
| Events | Member browse; officer CRUD; draft/schedule publish |
| Check-in | Officer tools + QR self check-in |
| Admin | CSV import, roles, semester close/start |
| Howdy Week | Guest CSV, prospects tab, claim-on-register |
| Docs | Architecture/ops/onboarding for officer transfer |

### Website — major pages

Home, officers, interns, Jiatings, events, GM, sports, photos, membership, contact, concessions, Ni Howdy.

# Data Flow

### Points — check-in → leaderboard

```
Officer creates event (category, point_value, scope, JT families)
  → publish now or schedule (cron)
  → member opens QR /checkin/[code] or officer checks in
  → attendance row inserted
  → triggers recompute member_semester_points (+ caps)
  → v_current_leaderboard reads cached totals
```

### Points — onboarding

```
Google OAuth @tamu.edu
  → callback links/creates path to members row
  → register (pending_member) OR imported active roster
  → admin approve / assign JT as needed
  → dashboard
```

### Legacy Sheets (replaced)

```
Google Forms responses → Sheets tallies → manual ops
  → replaced by points app (auth + attendance + SQL rules)
```

# Database Design

Core tables (points): `members`, `events`, `attendance`, `member_semester_points`, `semesters`, `jt_families`, `years`, `event_jt_families`, `event_rsvps`, `event_import_rows`, `event_guests`, `semester_summaries`, `jt_transfer_log`, snapshot tables, etc.

Key derived objects: `v_current_leaderboard`, `v_jt_leaderboard`, RPCs (`close_semester`, `attendance_counts_for_semester`, `top_leaderboard_members_per_jt`, recompute/cap functions, Howdy Week guest RPCs).

~41 migrations; ~20 unique `public` SQL functions/RPCs in analyzed tree.

# APIs

- Supabase client (server/action/admin/browser factories)
- `/api/auth/google`, `/api/auth/callback`, `/api/auth/signout`
- `/api/places/autocomplete`, `/api/places/details`
- `/api/cron/publish-events`
- Google Calendar + Places via `googleapis`
- Website: Google Sheets readonly for medals; contact form APIs

# Authentication/Security

- Supabase Auth + Google OAuth
- Domain allowlist `@tamu.edu`
- RLS on Postgres; service role only for privileged admin RPCs/imports
- Middleware clears stale auth cookies on refresh failures
- Roles: member / officer / admin

# Infrastructure

- Vercel hosting (both apps)
- Supabase hosted project
- GitHub Actions workflow for scheduled event publish / keepalive
- Env docs for local + production (`docs/ENVIRONMENT.md`, `DEPLOYMENT.md`)

# Automation

| Automation | Mechanism |
|------------|-----------|
| Point totals | DB triggers on attendance/event changes |
| Cap enforcement | JT weekly + spectator semester recompute functions |
| Scheduled event publish | Cron API + GitHub Actions |
| Calendar sync | Google Calendar from events |
| Semester archive | `close_semester` RPC (spring clears JT assignments) |
| Roster bulk load | Admin CSV import |

# AI Systems

None in these repos.

# Engineering Decisions

1. **Replace Sheets/Forms** with authenticated app + SQL-encoded policy (Secretary mandate).
2. **Supabase** for Auth + Postgres + RLS instead of a custom API server.
3. **Cached semester points** (`member_semester_points`) instead of live full re-aggregate in UI.
4. **Separate access vs Jiating** so members can use the portal before family assignment.
5. **QR self check-in** plus officer check-in for event throughput.
6. **Heavy documentation** for yearly officer transfer.
7. **Public website separate** from authenticated points app (different threat model and UX).
8. Keep some Sheets reads on marketing site (medals) without making Sheets the points system of record.

# Tradeoffs

| Decision | Benefit | Cost |
|----------|---------|------|
| Supabase RLS + RPCs | Security + business rules close to data | Migration discipline; baseline gap for local bootstrap |
| Cached points | Fast leaderboards | Must keep triggers correct on every attendance path |
| Two repos/sites | Clear public vs private surfaces | Two deploy/env surfaces to maintain |
| Cron via GitHub Actions | Cheap scheduling | Depends on Actions + APP_URL correctness |
| CSV imports | Matches existing officer spreadsheets | Validation edge cases; JT transfer logging needed |

## Failure Modes

| Failure | Mitigation direction |
|---------|----------------------|
| Stale Supabase cookies | Middleware clear + re-login |
| PostgREST row truncation | Paginated fetch / SQL aggregation RPCs |
| Non-TAMU Google account | Reject in callback |
| Cron misconfig | Documented APP_URL / workflow keepalive fixes |
| Spring close JT wipe | Explicit admin confirm; documented |

# Future Improvements

From docs/issues posture (examples): continue known-issue burn-down; stronger local baseline schema story; any remaining Sheets dependencies on marketing site; confirm org-scale metrics for resume (members/events) from live DB if desired.
