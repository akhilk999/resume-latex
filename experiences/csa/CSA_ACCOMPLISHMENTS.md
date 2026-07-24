# CSA — Accomplishments

Source: `CSA_CONTEXT.md`, git/docs analysis of `tamucsa/website` and `tamucsa/points` (temporary clones, removed after extraction).
Do not invent metrics. Do not write polished resume bullets here.

---

## Accomplishment 1 — CSA public website (PR Chair / branding)

### What I Built

Production public website for Texas A&M CSA to improve visibility and branding (including Instagram-facing presence): home, officers, interns, Jiatings, events calendar embed, GM slides, sports, photos, membership, contact, concessions, Ni Howdy, etc.

**Ownership:** Primary builder (confirmed — vast majority of commits; README PR Chair handoff contact)

**Role context:** Public Relations Chair

### Technical Implementation

- Next.js (App Router) + TypeScript + Tailwind; Framer Motion; responsive/mobile polish across pages
- Content sections for org storytelling (officers, Jiatings, sports results, GM decks, photo album links)
- Google Sheets integration for JTO medal tracker reads; contact form stack (reCAPTCHA, email)
- Deployed on Vercel at `csatamu.org`; documented domain renewal and env handoff for future PR chairs

### Engineering Challenge

Maintaining a living content site across semesters (GM slides, sports, interns) while keeping mobile layout solid and transferrable to future officers.

### Impact

Central branded web presence for recruitment/visibility beyond Instagram alone. Observed: recruitment improved **~20%** after launch (see `METRICS.md`).

### Evidence

`tamucsa/website`; https://csatamu.org; README “Public Relations Chair” section; git authorship

### Tags

Frontend, Product, Leadership

*Skills demonstrated:* Next.js, TypeScript, Tailwind, Vercel, content ops

---

## Accomplishment 2 — Points platform replacing Sheets/Forms (Secretary)

### What I Built

End-to-end points/attendance system so CSA no longer runs semester points primarily through Google Sheets + Google Forms: members sign in, see points/leaderboards, check in to events; officers/admins manage events, roster, and semester lifecycle.

**Ownership:** Primary architect and implementer (confirmed — ~88 commits; authored `docs/ARCHITECTURE.md`, `OPERATIONS.md`, migrations)

**Role context:** Secretary

### Technical Implementation

- Next.js App Router front end + Supabase Postgres/Auth/RLS backend
- TAMU Google OAuth with `@tamu.edu` enforcement; member linking by `auth_uid`/email; roles `member` / `officer` / `admin`
- Events, attendance, QR/self check-in (`/checkin/[code]`), leaderboards (individual + Jiating + standings snapshots)
- Admin CSV roster import; semester open/close RPCs; cached `member_semester_points` maintained by triggers
- Google Calendar sync for events; Google Places location autocomplete; scheduled publish via GitHub Actions cron
- Extensive operator docs for transfer (onboarding members/officers/admins, deployment, environment)

### Engineering Challenge

Encoding org rules (Jiating caps, spectator caps, categories, Howdy Week guests, spring JT clear) in SQL triggers/RPCs + RLS while keeping officer UX workable and performant (precomputed leaderboard, attendance count RPCs).

### Impact

Replaced spreadsheet/forms workflow with an authenticated operational system at `points.csatamu.org` serving **250+** members and supporting **400+ events per semester** (observed — see `METRICS.md`).

### Evidence

`tamucsa/points`; https://points.csatamu.org; `docs/*`; `supabase/migrations/*`

### Tags

Backend, Frontend, Database, Security, Cloud, Product, Leadership

*Skills demonstrated:* Next.js, Supabase, PostgreSQL, RLS, OAuth, Google APIs, systems design, documentation

---

## Accomplishment 3 — Auth, RBAC, and onboarding gates

### What I Built

Secure member lifecycle: Google sign-in → register/pending → active dashboard; officer/admin layout guards; middleware session refresh and stale-cookie cleanup.

**Ownership:** Primary (confirmed)

### Technical Implementation

- Supabase SSR clients (`server` / `action` / `admin` / `browser`); middleware public-route allowlist
- Auth callback links members; rejects non-TAMU emails; service role for roster link/import paths
- Status gates: `pending_member` → `/pending`; active members to leaderboard/events/profile
- RLS hardening migrations (`security_rls_hardening`, `security_and_cap_fixes`)

### Engineering Challenge

Separating **access** (active vs pending) from **Jiating assignment** (Pending JT) so dues-paid members can use the portal before family sorting.

### Impact

Org-scale auth model appropriate for student org data (points, rosters) vs open Sheets.

### Evidence

`middleware.ts`; `src/app/api/auth/callback/route.ts`; `docs/ARCHITECTURE.md` Auth sections

### Tags

Backend, Security

---

## Accomplishment 4 — QR check-in and automated point calculation

### What I Built

Officer QR + member self check-in flows; attendance rows drive counted points with category rules and caps recomputed in the database.

**Ownership:** Primary (confirmed)

### Technical Implementation

- Printable QR for events; `/checkin/[code]` client flow
- Triggers/RPCs recompute `member_semester_points`, JT weekly caps, spectator semester caps on attendance/event changes
- Views: `v_current_leaderboard`, `v_jt_leaderboard`; RPCs e.g. `attendance_counts_for_semester`, `top_leaderboard_members_per_jt`

### Engineering Challenge

Keeping leaderboards correct and fast without re-summing unbounded attendance in the UI (PostgREST max-rows pitfalls documented).

### Impact

Operational check-in without Forms; points stay consistent with policy encoded in SQL.

### Evidence

`src/app/checkin/*`; migrations for points/caps; `docs/OPERATIONS.md` check-in + points rules

### Tags

Backend, Database, Product

---

## Accomplishment 5 — Officer/admin operations (events, roster, semester)

### What I Built

Officer event CRUD (draft vs scheduled publish), RSVP tagging, Howdy Week guest CSV/prospects, manual points, CSV member import / spring JT transfers, semester close/start including spring JT clear.

**Ownership:** Primary (confirmed)

### Technical Implementation

- Server actions under `src/app/actions/*`; admin service-role paths for imports and `close_semester`
- Cron route `/api/cron/publish-events` + GitHub Actions workflow for keepalive/scheduled publish
- Google Calendar sync from `/events`; Places API for location names + Maps links
- Transfer-oriented docs: OPERATIONS, ONBOARDING_*, DEPLOYMENT, ENVIRONMENT

### Engineering Challenge

Supporting real semester ceremonies (GM snapshots, spring re-sort) without losing auditability (`jt_transfer_log`, guest export log).

### Impact

Secretary/officer workflows runnable in-app instead of tribal Sheets knowledge.

### Evidence

`docs/OPERATIONS.md`; recent commits (guests, calendar, cron, dark mode, security); migrations 2026-06 → 2026-07

### Tags

Backend, Product, DevOps, Leadership

---

## Accomplishment 6 — PostgreSQL schema, migrations, and performance work

### What I Built

Versioned Supabase migrations for schema, RLS, views, indexes, and RPCs; explicit perf fixes (leaderboard snapshots/precompute, attendance counts RPC, query dedupe in middleware/profile).

**Ownership:** Primary (confirmed)

### Technical Implementation

- **41** migration files in analyzed tree; **~20 unique** `public.*` SQL functions/RPCs (plus views/triggers)
- Known-issue resolutions logged in commits (KI-005, KI-007, PF-001–003)

### Engineering Challenge

Migrations are not a full bootstrap of prod (documented baseline gap) — ownership transfer requires careful apply order.

### Impact

Defendable “20+ PostgreSQL functions” style claims if tied to unique RPCs/functions in migrations; prefer “~20 SQL functions/RPCs across 40+ migrations” for precision.

### Evidence

`supabase/migrations/`; `docs/ARCHITECTURE.md`; perf-related commits

### Tags

Database, Backend

---

## Accomplishment 7 — Discord verification bot: product design + GCP hosting

### What I Built / owned

Partnered on product design for CSA’s Discord verification bot (`nnbot`) and owned **GCP hosting/ops** so the bot stays online for the org’s Discord presence.

**Ownership:**
- **Application code:** Andrew Zhang (git sole author)
- **Akhil (confirmed):** product/design collaboration + all GCP hosting management
- **Scale (observed):** **300+** Discord members; bot in **3** servers with largely the same people (count members once)

### Technical Implementation

- Bot (Andrew): Discord.js v14 / TypeScript — verify-on-join channels, real-name nicknames, verified role, mod logging, `/config` `/bannedwords` `/setnickname`
- Akhil: GCP hosting setup/ongoing management for bot runtime; design input on verification/moderation product behavior

### Engineering Challenge

Separating honest credit (design + infra vs application commits) while keeping a production bot available across multiple guilds.

### Impact

Automated member verification operations for a **300+** member Discord community (multi-server deploy, overlapping membership).

### Evidence

`CSA_CONTEXT.md` (Akhil endorsement); https://github.com/tamucsa/nnbot (Andrew’s commits); Discord server membership observation

### Tags

Cloud, Product, Leadership, Backend

*Skills demonstrated:* GCP hosting/ops, product design collaboration, Discord.js ecosystem (working knowledge via design — not primary coding claim)
