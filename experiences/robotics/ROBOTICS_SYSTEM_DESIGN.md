# Robotics — System Design

> Sources: `ROBOTICS_CONTEXT.md`, `ROBOTICS_ACCOMPLISHMENTS.md`, `whooprobotics/ReveilLib`, representative robot firmware (`WHOOP-sonic`, Push Back repos).
> Primary interview artifact: **VEXU competition software stack** (ReveilLib + per-robot auton). Secondary: org website (early).

# Overview

Aggie Robotics **VEXU Team WHOOP** fields competition robots on VEX V5 + **PROS**, driven by the in-house control library **ReveilLib**. Auton “frontend” code lives in per-tournament / per-robot repos (or branches) that vendor ReveilLib headers + `reveillib.a`. Akhil’s deepest technical work is **auton path design/tuning** and a **motor temperature API** contribution; library core and driver control are owned by software lead **Drew**.

Org-facing: Next.js site (`whooprobotics/website`) intended for `aggierobotics.com` (not live).

# Architecture

### Competition robot stack

```
Field / Game objects
        │
        ▼
Sensors: Dual IMU, 45° odom pods (quad encoders),
         distance (wall localize), Optical (color),
         ADI (e.g. beam break)
        │
        ▼
ReveilLib (whooprobotics/ReveilLib)
  ├─ Odometry (TwoRotationInertialOdometry45Degrees, …)
  ├─ Chassis / Motor / MotorGroup abstractions
  ├─ Reckless async motion controller
  │     └─ RecklessPath → segments (PilonsSegment, turns, calls, …)
  │           ├─ Motion (Cascading / Proportional / Constant)
  │           ├─ Correction (PilonsCorrection, …)
  │           └─ Stop (SimpleStop, …)
  └─ AsyncRunner / Awaitable task model
        │
        ▼
Robot firmware (per bot / tournament)
  ├─ subsystems/  (drivetrain, intake, clamps, Lady Brown, conveyor, sensors, …)
  ├─ autons/      (quals, skills, elims)  ← Akhil primary focus
  └─ driver controls                    ← Drew
        │
        ▼
V5 Brain (PROS RTOS)
```

### Org website (early)

```
Browser → Next.js 15 App Router (React 19, Tailwind 4)
        → intended Cloudflare deploy
        → aggierobotics.com (not live)
```

# Components

| Component | Role | Ownership note |
|-----------|------|----------------|
| **Reckless** | High-speed chassis path follower; `go(path)`, `await()`, progress | Drew / ReveilLib |
| **RecklessPath** | Builder of segments (`with_segment`) | Library |
| **PilonsSegment** | Pose-targeted drive segment (x, y, θ) + motion/correction/stop | Library; used heavily in auton files |
| **45° dual-wheel + inertial odom** | Pose estimate from diagonal pods + gyro | Drew |
| **Motor / AnyMotor / MotorGroup** | Hardware abstraction; reverse flag; **get_temperature** | Wrapper/core: Drew; **temperature API: Akhil** |
| **Optical / color subsystem** | Alliance color; eject opposite | Robot firmware pattern |
| **Lady Brown** | Wall-stake mechanism; angle setpoints + async task | Robot firmware (see `WHOOP-sonic`) |
| **Rush / mogo clamps** | Mobile goal ownership | Mech + subsystem code |
| **Distance wall snap** | Correct pose vs side wall mid-auton | Used in Akhil paths (CONTEXT) |
| **Website** | Org public site scaffold | Akhil (early) |

# Data Flow

### Auton segment execution

```
Set start pose (field measure + aligner)
  → Reckless::go(RecklessPath{ segments... })
  → Async step loop:
        odom.step() → pose
        motion/correction compute chassis voltages
        optional: distance wall localization → set_position / axis snap
        optional: parallel subsystem tasks (intake, clamp, Lady Brown, eject)
  → await() until DONE or breakout
  → next path chunk / timeout-gated actions
```

### Color sort (Push Back / High Stakes pattern)

```
Optical sample → alliance color config → subsystem eject T/F
  (runs as task; paths don’t reimplement sort logic)
```

# Database Design

N/A for competition firmware. Org uses **Notion** databases (tasks/subteams) and **Google Drive** — not application DBs.

# APIs

### ReveilLib (C++), selected

- `Reckless::go` / `await` / `progress` / `breakout`
- `RecklessPath::with_segment`
- `Odometry::get_state` / `set_position` / `reset_position`
- `Motor::get_temperature` / `MotorGroup::get_temperature` (Akhil)
- Chassis voltage/velocity command path via motor abstractions

Exact public docs: Doxygen in ReveilLib repo.

# Authentication/Security

- Competition code: on-robot; no web auth.
- Org: Notion/Drive/GitHub **permissions** (Webmaster responsibility) — process controls, not app security design.
- Website: not production; no auth implemented in scaffold.

# Infrastructure

| Layer | Choice |
|-------|--------|
| Robot compute | VEX V5 Brain |
| Firmware OS | PROS |
| Library distribution | Headers + static `reveillib.a` in robot `firmware/` |
| CI / docs | ReveilLib GitHub + Doxygen |
| Org site host | Cloudflare (intended); not deployed |
| Collaboration | GitHub `whooprobotics/*`, Notion, Google Drive |

# Automation

- Auton: PROS tasks + Reckless async runner; subsystem loops (e.g. Lady Brown 10ms control loop).
- Org (planned, not built): Discord/Notion automations, points tracker, GitHub Actions — do not claim shipped.

# AI Systems

None in production competition stack. Aspirational: Logitech + OpenCV on Raspberry Pi for future vision — **not implemented**. Separate org repos (`override-sim`, etc.) exist but are **out of scope / not Akhil-owned** for this CONTEXT.

# Engineering Decisions

1. **Reckless waypoint segments over ad-hoc voltage scripts** — reusable motion/correction/stop; paths become data-like builders.
2. **45° dual tracking + IMU** — matches sprung diagonal odom pods; library class `TwoRotationInertialOdometry45Degrees`.
3. **AWP + wall localization over pure speed** — 1–2s corrections buy consistency on inconsistent fields/mechs.
4. **Per-tournament repos / per-robot branches** — identical concepts, different tuning constants (CONTEXT).
5. **Subsystem tasks for color eject** — paths set color + eject flag; sorting stays centralized.
6. **Temperature on motor API** — expose PROS motor temp through ReveilLib hierarchy for cooldown ops.

# Tradeoffs

| Decision | Cost | Benefit |
|----------|------|---------|
| Wall localize pauses | Loses 1–2s periodically | Stable AWP / pose |
| AWP paths vs max points | Lower peak score sometimes | Ranking / win rate |
| Mentor/Webmaster vs more paths | Fewer personal commits 2025–26 | Team capacity + org continuity |
| Ship teammate mech designs | Personal CAD unused | Better fielded robot |
| Mecanum Push Back | Sorting/outtake fragility | Drive characteristics for game |

# Future Improvements

- Ship aggierobotics.com beyond scaffold; Cloudflare prod.
- Vision pipeline (Pi + camera) if power/packaging solved.
- Stronger git hygiene so path authors land under personal commits (current gap vs CONTEXT ownership).
- Points tracker + Discord/Notion automations (planned).
- Do not claim Brain heat UI until re-implemented and evidenced.
