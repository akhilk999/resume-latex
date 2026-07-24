# CSA — Resume Bullets

Formula: Accomplished X as measured by Y by doing Z.
Rules: Do not invent metrics. Do not exaggerate ownership. Prioritize impact. Keep bullets concise.

Sources: `CSA_ACCOMPLISHMENTS.md`, `METRICS.md`, `CSA_CONTEXT.md`.

**Split by role:** website = PR Chair; points = Secretary.  
**Hold:** none of the prior org-scale soft metrics — 20% / 250+ / 400+ / Discord 300+ are CONTEXT-confirmed.
**Discord wording:** design collab + GCP hosting (not sole Discord.js authorship).

# Backend SWE

- Replaced CSA’s Google Sheets/Forms points workflow with a Next.js and Supabase platform (Postgres, Auth, RLS) automating tracking for 400+ events per semester
- Implemented TAMU Google OAuth with `@tamu.edu` enforcement, member linking, and role-based access for members, officers, and admins
- Encoded points policy in PostgreSQL triggers and RPCs that maintain cached `member_semester_points` totals, Jiating weekly caps, and spectator caps
- Built QR/self check-in and officer check-in flows so attendance writes drive automated leaderboard updates for 250+ organization members
- Added Google Calendar event sync and GitHub Actions–triggered scheduled event publishing for officer operations
- Authored ~20 PostgreSQL functions/RPCs across 40+ Supabase migrations, plus transfer docs for architecture and day-to-day ops
- Managed GCP hosting for CSA’s Discord verification bot (`nnbot`) supporting automated member onboarding for 300+ members

# Full Stack SWE

- Built the production CSA points app (Next.js, TypeScript, Tailwind, Supabase) with member leaderboards, profiles, officer event tools, and admin roster/semester consoles at points.csatamu.org for 250+ members
- Developed the public CSA website (Next.js, TypeScript, Tailwind) at csatamu.org for org branding and visibility across officers, events, GMs, Jiatings, sports, and photos
- Delivered QR check-in, CSV roster import, Howdy Week guest tracking, and dark-mode theming as end-to-end product features on the points platform

# AI/ML

_(Not applicable.)_

# Robotics

_(Not applicable.)_

# Product

- As Public Relations Chair, launched a branded CSA web presence that improved recruitment by ~20% versus Instagram-only outreach
- As Secretary, redesigned membership points operations from spreadsheet/forms into an authenticated product tracking 400+ events per semester for 250+ members
- Co-designed CSA’s Discord verification bot with a teammate and managed GCP hosting so automated onboarding runs for 300+ members across three Discord servers
- Wrote onboarding and operations documentation so future officers can administer points without relying on tribal Sheets knowledge
