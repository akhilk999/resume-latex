# Robotics — Accomplishments

Sources: `ROBOTICS_CONTEXT.md`; temporary analysis of `whooprobotics/ReveilLib`, `whooprobotics/website`, `whooprobotics/WHOOP-sonic`, `WHOOP5_HighStakes`, `WHOOP_PushBack`, `WHOOP8_PushBack` (clones removed after extraction).
Do not invent metrics. Do not write polished resume bullets here.
Ownership: CONTEXT is authority; git is supporting evidence only.

---

## Accomplishment 1 — Worlds Shadow autonomous paths (High Stakes)

### What I Built

Two competition autonomous routines for **Shadow** at VEXU World Championship 2024–2025 High Stakes, prioritizing mobile-goal rush control and reliable **Autonomous Win Point (AWP)** under ~3 days of on-site development.

**Ownership:** Akhil — Worlds Shadow paths (CONTEXT). Worlds Sonic paths owned by Dimitris. Team AWP rate required both robots.

### Technical Implementation

- PROS C++ on V5 Brain; ReveilLib **Reckless** controller with chained `RecklessPath` / segment waypoints (pose targets: x, y, θ; motion/correction/stop params) — pattern confirmed in team firmware (e.g. `WHOOP-sonic` skills style).
- Field-measured start poses + taped starts + physical aligners; trial-and-error waypoint tuning on field.
- Periodic **distance-sensor wall localization** (~every 5–10s, ~1–2s cost) to correct odom drift.
- Async subsystem tasks (intake, clamps, Lady Brown wall-stake) gated on motion completion / PROS timeouts.
- Consistency target ~7/10 when mechanically healthy.

### Engineering Challenge

Worlds rush meta: top teams contested rush (unlike States). Had to rewrite/stabilize paths under extreme time pressure while seeding was weak (#10) before fixes.

### Impact

Contributed to team auton that supported announced season **~85% AWP rate** (whole team / both robots) and division seeding recovery **#10 → #2 of 18** before elims; division **semifinals** (soft recall). Part of verified **+35%** autonomous match scoring from 10+ routines.

### Evidence

`ROBOTICS_CONTEXT.md`; **git:** `whooprobotics/WHOOP-sonic` branch `shadow` (`akhilk999`). Work on teammates’ machines may lack Akhil git author — still owned.
### Tags

Robotics, Backend

*Skills demonstrated:* PROS C++, path planning / waypoint tuning, sensor-based localization, competition debugging under time pressure

---

## Accomplishment 2 — States Sonic + Knuckles autonomous paths (High Stakes)

### What I Built

Autonomous paths for Texas VEXU State Championship (League City, Feb 2025): **Sonic** quals/skills (shared with Dimitris; 3 paths recalled) and **Knuckles** States paths (Akhil — confirmed). Part of broader **10+** auton routines across seasons.

**Ownership:** Sonic — Akhil + Dimitris. Knuckles States — **Akhil**.

### Technical Implementation

- Same ReveilLib Reckless + subsystem stack as Worlds generation.
- Recalled routine shape: claim mobile goal, wall stake via Lady Brown, score rings onto mobile goals (~12 rings / 2 goals order-of-magnitude recall — soft).
- Separate strategic intent: quals protect AWP; skills maximize systematic scoring without AWP constraint.
- Whiteboard path planning for scoring vs risk before field tuning.
- Git (WHOOP-sonic): skills wall stake, mogo rush, quals starts, rush_arm fixes on `knuckles2` / related branches; some work may also live under teammates’ git authors when coded on their machines.

### Engineering Challenge

V1 mechanical inconsistency made skills/quals reliability hard; required tight coupling of software tuning to mechanical state.

### Impact

Part of team run that won **Excellence Award**, **Robot Skills Champion** (overall skills — both robots), and **match-play semifinalist** at Texas States 2025. Contributed to verified **+35%** autonomous match scoring lift from the broader 10+ routine set.

### Evidence

CONTEXT (verified metrics + Knuckles ownership); team awards; `WHOOP-sonic` commits as `akhilk999` (~37 across branches).

### Tags

Robotics

*Skills demonstrated:* Auton strategy, skills vs quals tradeoffs, field tuning

---

## Accomplishment 3 — ReveilLib motor temperature API

### What I Built

Temperature accessors on ReveilLib motor abstractions so firmware can read motor heat for cooldown decisions.

**Ownership:** Akhil — git-supported (`akhilk999` commits; PR #39 merged).

### Technical Implementation

- Added temperature methods on `rev::Motor`, `rev::AnyMotor`, and `rev::MotorGroup` (group = max of members).
- Implementation uses PROS `motor_get_temperature`.
- Merged into `whooprobotics/ReveilLib` (Mar–Apr 2025).

### Engineering Challenge

Exposing heat across Motor / AnyMotor / MotorGroup consistently without breaking the existing motor abstraction hierarchy.

### Impact

Shipped library capability for thermal awareness. Brain-screen “visible markers” UI from interview remains **PoC / not evidenced as shipped**.

### Evidence

`whooprobotics/ReveilLib` commits `44cdbe8`, `61b1ca6`, `3aafeec`; PR #39.

### Tags

Robotics, Backend

*Skills demonstrated:* C++ library API design, PROS hardware APIs, open-source team library contribution

---

## Accomplishment 4 — Odometry reliability debugging (software ↔ hardware)

### What I Built

Diagnosed and fixed auton straight-line left drift caused by odom pod mechanics, not path math.

**Ownership:** Akhil (CONTEXT debugging story).

### Technical Implementation

- Symptoms: robot drifted left on straight Reckless segments; odom values inconsistent.
- Root cause: tracking roller not free-rolling — shaved roller, added missing spacer, retightened to specific friction window.
- Broader debug toolkit: logging, manually dragging robot to inspect odom, comparing other paths to separate mech vs code, checking wiring (including a 40-minute false lead from an unplugged taped wire).

### Engineering Challenge

Software-looking localization failures with mechanical root causes; easy to waste time in code.

### Impact

Restored consistent odom rolling — prerequisite for reliable wall-corrected paths. Contributed to verified **−80%** positioning-error reduction from motion/optical/IMU/encoder localization debugging.

### Evidence

CONTEXT interview (no separate ticket/PR).

### Tags

Robotics

*Skills demonstrated:* Sensor/odom debugging, hardware–software co-debug, process discipline (“check obvious first”)

---

## Accomplishment 5 — Distance-sensor wall localization in auton

### What I Built

Integrated periodic single-wall distance corrections into owned paths so open-loop waypoint following stayed accurate over ~30s VEXU autons.

**Ownership:** Used in Akhil’s paths (CONTEXT); odom stack owned by Drew.

### Technical Implementation

- Primarily one side wall; corrections roughly every 5–10 seconds; ~1–2s pause cost accepted.
- Tradeoff vs continuous max-speed scoring: preferred consistent AWP.

### Engineering Challenge

Balancing correction frequency against time budget and rush race.

### Impact

Enabled AWP-first strategy with acceptable consistency (~7/10 target).

### Evidence

CONTEXT. Library support: ReveilLib `TwoRotationInertialOdometry45Degrees` + DualImu patterns in team firmware.

### Tags

Robotics

---

## Accomplishment 6 — Push Back States paths (Lockdown) + outtake reliability

### What I Built

Two States autonomous paths on **Lockdown** (Push Back 2025–26); helped debug conveyor/outtake hook consistency for scoring.

**Ownership:** Akhil — 2 States paths (CONTEXT). Otherwise mentoring/webmaster for season.

### Technical Implementation

- Mecanum drive variant; double-sided intake; rotating outtake; color-sensor eject opposite color via subsystem task.
- Hook alignment fix so conveyor completed full rotation and scored without jamming.

### Engineering Challenge

Outtake stuck / slow / mis-sort / inconsistent scoring dominated reliability more than path geometry.

### Impact

Improved scoring consistency for Lockdown States work. No States placement recorded in CONTEXT.

### Evidence

CONTEXT; `WHOOP_PushBack` commits (`lockdown_skills.cc`, lockdown merge, port fixes).

### Tags

Robotics

---

## Accomplishment 7 — Webmaster / org systems (Notion, Drive, site)

### What I Built

Executive Webmaster function for Aggie Robotics: Notion workspace, Google Drive structure/templates, permissions, transfer docs; **whooprobotics/website** (Next.js) for aggierobotics.com with real content pages (not just scaffold).

**Ownership:** Akhil — Webmaster / exec (CONTEXT). Site: primary author on `web`/`wiki` branches (~8 commits).

### Technical Implementation

- Notion: task databases, subteams, permissions; ~50+ members.
- Drive: folder system, meeting-note templates used by officers/subteams.
- Media storage research (Cloud vs NAS); software permission controls; officer transfer templates; meeting notes/attendance support.
- Website: Next.js 15, React 19, Tailwind 4; home, outreach, vexu, combat routes; Navbar/Footer; logos/stock images; intended Cloudflare deploy; **not live**.

### Engineering Challenge

Enough process for continuity/safety without blocking competition turnaround; tooling adoption across ~15 officers / 7 exec.

### Impact

Org-wide planning moved toward Notion (Akhil’s initiative) with measurable adoption (~50+). Site content in progress; not production URL yet.

### Evidence

CONTEXT; local `aggieroboticswebsite` / `whooprobotics/website` git.

### Tags

Leadership, Product, Frontend, DevOps

*Skills demonstrated:* Org tooling, Next.js, executive coordination

---

## Accomplishment 8 — Software mentoring + Aggieland Classic ops

### What I Built

Mentored software members before States/Worlds (field setup, design review as second voice). Supported **Aggieland Classic** (VEX V5 @ A&M): field setup, Tournament Manager, score/match displays; **Judge** both hosted years.

**Ownership:** Helper/judge — not primary tournament planner (CONTEXT).

### Technical Implementation

- Process/people: idea review, field readiness; TM + display stack for event ops.

### Engineering Challenge

Scaling software capacity when there isn’t enough path work for everyone; choosing mentorship over maximizing personal commits.

### Impact

Broader software bench; tournament delivery support. Qualitative productivity gains from Notion — not further quantified.

### Evidence

CONTEXT.

### Tags

Leadership, Product

---

## Explicitly not accomplishments (do not elevate)

| Item | Why |
|------|-----|
| Brain/battery TPU mount; rush clamp CAD | Designed; **did not ship** |
| Motor reverse / polarity wrapper | **Drew-authored**; Akhil merged PR #30 only |
| ReveilLib odom / Reckless / driver control | Drew-owned |
| Solo Skills Champion / solo 85% AWP | Team / both robots — dual-credit only |

**Allowed verified metrics (do elevate carefully):** +35% auton scoring; −80% positioning error; 10+ routines; #10→#2 of 18; 2026 Design Award / #4 seed; Knuckles States path ownership.

---

## Tags summary

Robotics · Backend · Frontend · Leadership · Product · DevOps
