# CSA — Context

## Overview

- **Organization:** Texas A&M Chinese Student Association (CSA) — student org for community, events, Jiatings (family groups), sports, membership points.
- **What was built (three systems):**
  1. **`tamucsa/website`** ([csatamu.org](https://csatamu.org)) — public marketing / branding site for visibility (esp. Instagram-facing presence), officers, events, GMs, Jiatings, sports, photos, membership info.
  2. **`tamucsa/points`** ([points.csatamu.org](https://points.csatamu.org)) — full-stack points / attendance platform replacing the prior **Google Sheets + Google Forms** workflow for managing member points, events, check-in, and officer ops.
  3. **`tamucsa/nnbot`** — Discord.js verification bot for the CSA Discord (private verify channels, real-name nicknames, verified role, mod logging, admin slash commands).
- **Why:**
  - As **Public Relations Chair**: improve org visibility and branding online.
  - As **Secretary**: reform operational points tracking away from spreadsheet/forms chaos into a proper app with auth, RBAC, QR check-in, leaderboards, and semester workflows.
- **Who uses it:** CSA members and officers (points: TAMU Google `@tamu.edu`). Public website: prospective members, Instagram audience, campus community. Discord: **300+** members across **3** servers (overlapping). Live production systems (not throwaway demos).

## Personal Ownership

### Roles

| Role | Focus | Primary artifact |
|------|--------|------------------|
| **Public Relations Chair** (prior year; website work from ~Jun 2025) | Visibility, branding, Instagram support | `tamucsa/website` |
| **Secretary** (current; points work from ~Mar 2026) | Points / attendance ops reform | `tamucsa/points` |

### Confirmed (Akhil — git-supported)

- **Website:** ~247+ commits as Akhil Kasamsetty (+ `akhilk999`); primary builder of Next.js/TypeScript/Tailwind public site; README lists Akhil as contact for PR Chair / webmaster handoff; domain notes for Vercel `csatamu.org`.
- **Points:** ~88 commits; sole meaningful human committer (one “TAMU CSA” merge bot-style entry); authored architecture/ops docs, Supabase migrations, Next.js app, Google Calendar sync, QR check-in, cron publish, RLS/security work, etc.

### Confirmed (Akhil — non-git, CONTEXT-endorsed)

- **`nnbot` product design:** Collaborated with Andrew Zhang on product/design of the Discord verification bot (flows, behavior, moderation tooling intent).
- **`nnbot` GCP hosting:** Owned/managed **all GCP hosting** for running the Discord bot (ops/infra — not application git commits).
- **Discord scale:** CSA Discord presence has **300+ members**; bot deployed across **3 Discord servers** with largely overlapping membership (do **not** sum to 900+).
- **Website impact:** Recruitment improved **~20%** after launching the branded public site (observed — Akhil).
- **Points / org ops scale:** **250+** organization members on the points platform; system supports tracking **400+ events per semester** (observed — Akhil).

### Teammates

- **Website (minor):** `alockinalock` (Andrew Zhang) — landing/sections; Andrew Zhang — CSS restructure.
- **Points:** effectively Akhil-owned (one “TAMU CSA” merge entry).
- **`nnbot` (Discord):** **Implementation / git:** Andrew Zhang (`alockinalock`), 3 commits 2026-03-27→28. **Akhil:** product design collab + GCP hosting/ops.

### Do not claim without extra evidence

- **Sole / primary Discord bot application coding** — git author is Andrew Zhang; Akhil’s confirmed roles are **design collab + GCP hosting**.
- **900+ members** by multiplying 3 Discord servers — membership largely overlaps; claim **300+** Discord members once (separate from points-platform **250+** members if those refer to org/roster scale — see METRICS).
- Invented percentages beyond CONTEXT-approved observed metrics.

## Constraints

- **Stack — website:** Next.js 15, React 19, TypeScript, Tailwind 4, Framer Motion, Google Sheets API (JTO medals / legacy point-sheet env notes), Resend/nodemailer, reCAPTCHA, Vercel
- **Stack — points:** Next.js 16, React 19, TypeScript, Tailwind 4, Supabase (Postgres + Auth + RLS), Google OAuth (TAMU domain), Google APIs (Calendar sync, Places), QR (`qrcode.react`), GitHub Actions cron for scheduled event publish, Biome, Vercel
- **Stack — nnbot:** TypeScript, Node.js, Discord.js v14, dotenv, fs-extra; env `DISCORD_TOKEN`, `CLIENT_ID`; per-guild JSON config under `data/`
- **Prior workflow (points):** Google Sheets + Google Forms for points/attendance — replaced by `points` app.
- **Known inaccuracies:**
  - Website README says “Computer Science Association” in one line — org is **Chinese Student Association**.
  - Resume project card titled “CSA Website” but links to **points** GitHub/URL — naming drift; keep systems distinct in this knowledge base.
  - Resume leadership Discord bullet as “I developed the bot in Discord.js” — **overclaims coding**; prefer design + GCP hosting wording (Andrew wrote application code).
  - Leadership resume dates (“Secretary May 2025”) may not match PR → Secretary timeline; prefer role narrative in this CONTEXT over stale TeX dates until updated.

## Important Instructions

- Split storytelling: **PR Chair → website/branding**; **Secretary → points platform replacing Sheets/Forms**.
- Points is the stronger SWE/backend story (Supabase, RLS, triggers, QR, Calendar, cron).
- Website is the product/frontend/branding story (Next.js marketing site + Instagram visibility).
- **`nnbot`:** Andrew implemented Discord.js verification bot; Akhil **co-designed** it and **managed GCP hosting**; serves **300+** members across **3** overlapping Discord servers. Do not claim sole code authorship.
- Prefer CONTEXT-approved observed metrics (20% recruitment, 250+ members, 400+ events/semester, Discord 300+) plus repo-confirmed technical metrics; do not invent new percentages.
- Live URLs: https://csatamu.org · https://points.csatamu.org
- Repos: https://github.com/tamucsa/website · https://github.com/tamucsa/points · https://github.com/tamucsa/nnbot
