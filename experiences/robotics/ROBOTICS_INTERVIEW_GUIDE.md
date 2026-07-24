# Robotics — Interview Guide

> Sources: `ROBOTICS_CONTEXT.md`, `ROBOTICS_ACCOMPLISHMENTS.md`, `ROBOTICS_SYSTEM_DESIGN.md`, `METRICS.md`

# Project Summary

**Aggie Robotics / VEXU Team WHOOP** (Texas A&M), Aug 2024–present.

1. **2024–25 High Stakes** — Software (auton paths on Sonic / Shadow); light ReveilLib contribution (`motor_temp`); early mech CAD that did not ship.
2. **2025–26 Push Back** — Lockdown States paths + mentoring; **Webmaster / executive** (Notion, Drive, website scaffold); Aggieland Classic ops/judge.

### Elevator pitch (30–60s)

> On VEXU Team WHOOP I focused on autonomous: waypoint paths in our ReveilLib/PROS stack with wall-sensor localization so we could win Autonomous Win Point consistently. At Worlds I owned Shadow’s two paths under a three-day rewrite when seeding was 10th—we got auton reliable again and climbed to 2nd seed before elims. Our team hit about an 85% AWP rate for the season and won Excellence and Skills at Texas States. I also shipped motor temperature APIs into ReveilLib, and as Webmaster I’ve moved the org onto Notion and Drive templates while building aggierobotics.com.

# My Role

| Level | Scope |
|-------|--------|
| **Auton author** | States Sonic (w/ Dimitris) + **Knuckles States**; Worlds Shadow (`shadow` git); Push Back Lockdown; **10+** routines overall; teammate-machine commits still count |
| **ReveilLib (git)** | `get_temperature` on Motor / AnyMotor / MotorGroup — **not** reverse wrapper |
| **Webmaster / exec** | Notion, Drive, permissions, site pages (`web`/`wiki`); mentor |
| **Verified metrics** | +35% auton scoring; −80% positioning error; #10→#2 of 18; 2026 Design Award / #4 seed |
| **Do not claim** | ReveilLib core, driver control, motor reverse wrapper (Drew), shipped clamps/mounts, solo team awards / solo 85% AWP |
# Technical Challenges

## Challenge 1 — Worlds auton rewrite under time pressure

### Situation

At Worlds 2024–25, seeding sat around **#10** before auton was solid; rush meta was much harder than States.

### Problem

Need reliable rush + AWP paths for **Shadow** in ~**3 days** on-site.

### Solution

Whiteboard strategy → field-measured starts/aligners → Reckless waypoint chains → distance wall snaps every ~5–10s → tune to ~7/10 consistency with healthy mech.

### Tradeoffs

Gave up some raw scoring speed for localization pauses and AWP priority.

### Result

Paths contributed to team auton supporting **~85%** season AWP callout and seeding climb to **#2** before elims; division semis (recalled). Credit is **team/both robots**; personal ownership = Shadow.

---

## Challenge 2 — Software-looking bugs that were mechanical

### Situation

Straight paths drifted left; odom readings looked wrong.

### Problem

Easy to chase controller/gains forever.

### Solution

Drag-test odom; compare paths; inspect pods → roller friction/spacer/tension; separately learned from a **40-minute** debug that ended on an **unplugged** taped wire.

### Tradeoffs

None major — process change: check power/plugs/mechanics first.

### Result

Reliable rolling pods; faster future debug.

---

## Challenge 3 — AWP consistency vs max score

### Situation

Inconsistent fields and V1 mech made hero paths fail.

### Problem

High-scoring 50% routes lose matches and ranking.

### Solution

Separate AWP-oriented vs points-oriented paths; accept wall localize cost; skills paths optimize systematic scoring without AWP.

### Tradeoffs

Lower peak theoretical score; higher win probability.

### Result

Texas States Excellence + Skills Champion + semis; strong Worlds AWP rate (team).

---

## Challenge 4 — Push Back outtake inconsistency

### Situation

Conveyor hook jammed / incomplete rotations; scoring unreliable on Lockdown.

### Problem

Paths irrelevant if scoring mechanism fails.

### Solution

Find exact hook alignment for full rotation + consistent score; color eject as subsystem task.

### Tradeoffs

Mechanical/process fix over more path complexity.

### Result

More consistent scoring behavior (qualitative).

---

## Challenge 5 — Mentoring / Webmaster vs personal coding volume

### Situation

Not enough SW work for everyone; busy schedule; HS FTC experience useful for mentoring.

### Problem

Maximize team output, not personal commit count.

### Solution

Shift to mentor + exec Webmaster (Notion/Drive/site); still write Lockdown States paths.

### Tradeoffs

Fewer git-visible firmware commits; stronger org leverage.

### Result

Notion adoption **50+**; Drive templates in use; site early-stage.

# Debugging Stories

1. **Odom drift left** → pod roller tension/spacer (see Challenge 2).
2. **Unplugged odom wiring** under tape → 40 min wasted → “check obvious first.”
3. **Push Back hook jam** → alignment for full rotation.
4. **Wall localize tuning** — frequency vs time budget for AWP.

# Architecture Decisions

- ReveilLib **Reckless** + pose segments vs raw voltage scripts.
- **45° dual wheel + IMU** odometry (library; Drew).
- **Distance wall snaps** as explicit localization layer on top of dead reckoning.
- **Subsystem tasks** for color eject / Lady Brown angles.
- Per-robot branches for tuning isolation.

Be ready to sketch RecklessPath → segment → odom → chassis loop on a whiteboard. Cite Drew for library internals if pressed deep.

# Lessons Learned

- Consistency beats peak score when field/mech variance is high.
- Check obvious physical faults before deep software rabbit holes.
- Process (Notion/Drive) helps until it slows competition cycles — keep proportional.
- Communicate early across mech/alliance/event dependencies.
- Mentoring/org work can out-leverage another personal path when seats exceed useful coding work.

# Behavioral Stories

| Prompt | Angle |
|--------|-------|
| Leadership without authority | Mentored SW before events; second voice of reason |
| Conflict / ego | Personal clamp/mount lost to better teammate design — shipped the better robot |
| Ambiguity / time pressure | Worlds 3-day Shadow rewrite |
| Cross-functional | Software–mech odom debug; Aggieland Classic TM/displays/judging |
| Process improvement | Notion instead of Discord-only tasking |

# Potential Interview Questions

**Technical**

- How does your auton path representation work? (RecklessPath / segments / await)
- How do you correct odometry mid-auton without vision?
- Walk through Lady Brown wall-stake actuation in auton.
- What did your ReveilLib PR actually change? (motor temperature — not reverse wrapper)
- Arcade 10-motor + 45° pods vs mecanum Push Back — what broke?

**Ownership / honesty**

- Which paths did you personally own vs Dimitris/Sean/Drew?
- Why might some code not show your git author? (Worked on teammates’ machines for PROS / library re-upload reasons — ownership still yours; also ~37 commits under `akhilk999` on `shadow`/`knuckles2`.)
- Did your CAD ship? (No.)
- Who owned Knuckles States paths? (**You** — confirmed.)

**Metrics**

- Can you claim 85% AWP personally? (**No** — team/both robots; dual-credit.)
- Are +35% / −80% / 10+ routines real? (**Yes** — CONTEXT-verified.)
- 2026 Design Award / #4 seed? (**Yes** — CONTEXT-verified; team awards.)

**Leadership**

- What did you ship as Webmaster that’s real today vs planned?
- How do you avoid process theater before competitions?
