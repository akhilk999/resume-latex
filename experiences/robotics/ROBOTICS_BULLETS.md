# Robotics — Resume Bullets

Formula: Accomplished X as measured by Y by doing Z.
Rules: Do not invent metrics. Do not exaggerate ownership. Prioritize impact. Keep bullets concise.

Sources: `ROBOTICS_ACCOMPLISHMENTS.md`, `METRICS.md`, `ROBOTICS_CONTEXT.md`.

**Split by era:** High Stakes auton (2024–25) vs Webmaster/mentor (2025–present).  
**Verified OK:** +35% scoring, −80% positioning error, 10+ routines, #10→#2 of 18, 2026 Design Award / #4 seed.  
**Always dual-credit:** Skills Champion, ~85% AWP, team awards.  
**Never:** motor reverse wrapper authorship; `aggierobotics/site`; shipped personal clamp/mount.

# Backend SWE

- Extended ReveilLib’s motor abstractions with temperature APIs on Motor, AnyMotor, and MotorGroup (max-of-group) so competition firmware can read PROS motor heat for cooldown decisions
- Built VEXU autonomous routines in PROS C++ on ReveilLib’s Reckless waypoint controller, chaining pose segments with async subsystem actions for clamps, intake, and wall-stake scoring
- Improved auton pose reliability by adding periodic distance-sensor wall localization (~every 5–10s) on top of 45° dual-wheel + IMU odometry, trading 1–2s per snap for consistent Autonomous Win Point performance

# Full Stack SWE

- Built out Aggie Robotics’ public site (`whooprobotics/website`) in Next.js 15, React 19, and Tailwind 4 — home, outreach, VEXU, and combat pages plus shared nav/footer toward aggierobotics.com (not yet live)

# AI/ML

_(Not applicable to shipped WHOOP work. Vision/OpenCV-on-Pi is aspirational only — do not bullet.)_

# Robotics

- Increased autonomous match scoring by 35% by programming 10+ autonomous routines in C++ with ReveilLib, helping raise division seeding from 10th to 2nd of 18 teams at VEXU Worlds
- Reduced robot positioning errors by 80% by debugging motion, optical, IMU, and encoder integration for reliable localization (including odom-pod mechanical root causes and distance-sensor wall snaps)
- Programmed Worlds autonomous paths for Shadow (git: `WHOOP-sonic` `shadow`) under a ~3-day on-site rewrite, contributing to team auton with an announced ~85% season Autonomous Win Point rate (team/both-robot metric)
- Authored States autonomous paths for Sonic (with Dimitris) and Knuckles supporting Texas VEXU Excellence Award, Robot Skills Champion, and match-play semifinalist results (League City, Feb 2025)
- Wrote Push Back States autonomous paths for Lockdown and fixed conveyor/outtake hook alignment so full rotations scored without jamming
- Designed brain/battery TPU mount and mobile-goal rush clamp concepts early on—designs did not ship after teammate parts performed better (optional honesty bullet; usually omit)

# Product

- As Webmaster and executive officer, rolled out Notion task databases/subteams/permissions adopted by 50+ members and standardized Google Drive folder and meeting-note templates for officers
- Mentored software members through pre–States/Worlds field setup and design reviews to grow path-authoring capacity beyond personal ownership
- Supported Aggieland Classic (VEX V5 @ A&M) via field setup, Tournament Manager, score/match displays, and judging both hosted years

# Quant / Trading SWE

_(No trading domain — C++ / real-time systems / performance under constraint.)_

- Programmed VEXU autonomous routines in PROS C++ on ReveilLib’s Reckless waypoint controller, chaining pose segments with async subsystem actions under match time pressure
- Reduced positioning errors by 80% by debugging motion, optical, IMU, and encoder integration (including mechanical odom-pod root causes and distance-sensor wall snaps)
- Extended ReveilLib motor abstractions with temperature APIs so firmware can read PROS motor heat for cooldown decisions on competition robots
- Delivered 10+ autonomous routines contributing to +35% autonomous scoring and #10→#2 seeding at VEXU Worlds (team context; dual-credit awards)

# Forward Deployed

- Mentored software members through pre–States/Worlds field setup and design reviews so path-authoring capacity scaled beyond personal commits
- Supported Aggieland Classic tournament ops (field setup, Tournament Manager, score/match displays, judging) for hosted VEX V5 events
- As Webmaster, shipped Notion/Drive operating systems adopted by 50+ members so subteams could run without tribal knowledge
- Rewrote Worlds auton paths on-site under a ~3-day window — high-ambiguity delivery against a hard competition deadline

# Infra / Platform

_(Not applicable as cloud/platform engineering. Org tooling is Product/FDSE; firmware is Robotics/Quant-systems.)_

# Awards (team — dual-credit)

- Team: Excellence Award and Robot Skills Champion @ Texas VEXU 2025; #2 seed @ 2025 VEXU Worlds; Design Award and #4 seed @ 2026 VEXU Worlds
