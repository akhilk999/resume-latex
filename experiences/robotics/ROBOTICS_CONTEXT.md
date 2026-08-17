# Robotics — Context

## Overview

- **Organization:** Aggie Robotics at Texas A&M University — **VEXU Team WHOOP** (team number / name: **WHOOP**).
- **Timeline:** Joined **August 2024 – present**.
- **Competitions / seasons:**
  1. **VEXU 2024–2025 High Stakes** — primary hands-on software + early mechanical season.
  2. **VEXU 2025–2026 Push Back** — States auton paths on Lockdown + mentoring; heavier org/webmaster focus.
- **What was built (robots Akhil worked with):**
  - **High Stakes States:** **Sonic** and **Knuckles** — largely identical builds except **mobile goal rush clamp** role (different rush targets / reach).
  - **High Stakes Worlds:** **Sonic V2** and **Shadow** — *not* drop-in copies of States bots (different CoM, subsystem implementations, packaging); Akhil focused mainly on **Shadow**.
  - **Push Back States:** **Lockdown** — same general control/odom stack idea; **custom mecanums** instead of omni + cast polyurethane traction wheels.
- **Why:** Compete in VEXU (quals, elims, skills); secure **Autonomous Win Point (AWP)** reliably; maximize skills scoring; run Aggie Robotics as an org (web, Notion, Drive, tournament hosting).
- **Who uses it:** WHOOP competition robots (fielded by ~17-person competition team in High Stakes); Aggie Robotics officers/members for org tooling (**~50+** on Notion); campus VEX community via **Aggieland Classic**.
- **Prior experience (shapes mentoring, not WHOOP ownership):** FTC teams **11472, 11419, 14523, 12977** across **2019–2020 through 2023–2024**.

### Roles over time

| Period | Role | Focus |
|--------|------|--------|
| Aug 2024 – May 2025 | Software team member (started hybrid mech+SW) | Mech CAD attempts; States/Worlds auton paths; light Reveillib PoCs |
| May 2025 – present | **Webmaster** + executive officer; software **mentor** | aggierobotics.com; Drive/Notion/permissions; advice + field help before States/Worlds; limited Push Back States paths |

---

## Personal Ownership

### Confirmed (Akhil — git-supported)

**Autonomous / firmware (`whooprobotics/WHOOP-sonic`, local full clone)**

- **`shadow` branch (~11+ commits as `akhilk999`):** Worlds Shadow auton — “first commit for shadow”, day-1 auton, red AWP, elims, post-Worlds commit; files under `src/autons/{quals,skills,elims}.cc`, rush arm, conveyor, drivetrain.
- **`knuckles2` / skills / quals commits:** Substantial path + subsystem work (mogo rush auton, skills wall stake, quals start, rush_arm fixes). **Akhil owned / worked Knuckles States paths** (confirmed) — git-backed on `knuckles2`.
- **~37 commits** total as `akhilk999` across branches (shortlog); additional work may appear under teammates’ git accounts when coding on their machines (PROS / library re-upload workaround) — still Akhil ownership per CONTEXT.
**Push Back (`whooprobotics/WHOOP_PushBack`)**

- **5 commits** as Akhil Kasamsetty — incl. `lockdown_skills.cc`, port reverses, “manual merge from lockdown”, Soundwave port updates.

**ReveilLib**

- **`motor_temp` / temperature API** on `rev::Motor`, `AnyMotor`, `MotorGroup` (PR #39).
- Minor: `knuckles sim` / `sim` commits.
- **Motor reverse wrapper:** Drew-authored; Akhil merged PR #30 only.

**Website (`whooprobotics/website`, local `web`/`wiki` branches)**

- **~8 commits** — beyond scaffold: home/outreach/vexu pages, combat page, Navbar/Footer, logos/stock images, Push Back copy, officer info, wiki PR merge, vulnerability fix, prod script. Still **not live** at aggierobotics.com per interview.

### Confirmed (Akhil — CONTEXT / interview, align with git)

**Mechanical (designed; did not ship)**

- **V5 Brain + battery TPU mount** — flexible placement / secure brain. **Did not ship** (teammate design preferred).
- **Mobile goal rush clamp** — clamp mobile goal in **<2s** after auton start for rush ownership. **Did not ship** (teammate design preferred).

**Autonomous paths (interview + git + verification)**

| Season / event | Robot | Ownership | Count / notes |
|----------------|--------|-----------|----------------|
| High Stakes States | **Sonic** | Akhil + **Dimitris** — quals + skills | **3 paths** (Akhil); git-backed |
| High Stakes States | **Knuckles** | **Akhil** (States paths) | Git-backed on `knuckles2`; prior interview naming Sean as sole owner **superseded** — Akhil worked on Knuckles States paths |
| High Stakes Worlds | **Shadow** | **Akhil** | **2 paths**; **git-backed on `shadow`** |
| High Stakes Worlds | **Sonic** (V2) | **Dimitris** | Akhil did not own |
| Push Back States | **Lockdown** | **Akhil** | **2 paths**; git touches `lockdown_skills.cc` + lockdown merge |

- Across seasons, Akhil authored **10+ autonomous routines** (CONTEXT-verified; aligns with resume).
- Recalled High Stakes path intent (exact scores not remembered): claim/control a **mobile goal**, score **wall stake**, score on the order of **~12 rings on 2 mobile goals** (quals-style); skills similar scoring push without AWP constraint.
- Consistency target when tuned: roughly **7/10** runs; with solid mechanical state, paths became highly repeatable.
- **Autonomous match scoring +35%** (CONTEXT-verified) attributed to programming those routines on ReveilLib / PROS.
- **Positioning errors −80%** (CONTEXT-verified) via debugging motion, optical, IMU, and encoder / odom integration for reliable localization.

**Org / Webmaster (May 2025 – present)**

- **Executive / board role:** Webmaster is one of **~7 executive** officers (among **~15** officers total) — top-tier org leadership with input on conflicts, overall org management, and higher leadership decisions; partners primarily with the **President**.
- **aggierobotics.com** — Next.js, React, Tailwind; intended deploy **Cloudflare**; repo **`whooprobotics/website`** (not `aggierobotics/site`). Substantial site content authoring (home/outreach/vexu/combat, nav/footer, assets). **Public launch expected ~late August 2026** (≈2 weeks from 2026-08-08). Until then: do **not** claim the public site is live.
- **Internal wiki / knowledge base** — in progress under Webmaster scope; do **not** claim shipped/live wiki yet.
- **Google Drive** — folder system + document templates (incl. meeting-note templates used by officers/subteams). **Shipped / in use.**
- **Notion** — org-wide workspace: task DBs, subteams, permissions; **~50+** members; Akhil’s push to move off Discord-only tasking. **Shipped / in use.**
- Media storage research (**Cloud vs NAS**); software permissions controls; officer transfer document templates; meeting notes / attendance support.
- Planned (not done): points tracker (after another officer defines points), Discord/Notion automations (bot or GitHub Actions).
- **Executive officer** among **~15 officers / 7 executive**; primarily partners with **President**; input into exec decisions.

**Mentoring**

- Pre–States/Worlds: second voice of reason, field setup, talking through newer members’ ideas — not day-to-day path authorship for Worlds Push Back.

**Aggieland Classic (VEX V5 tournament at A&M)**

- Not primary event planner.
- Helped: **field setup**, **Tournament Manager**, **score/match display** setup.
- **Judge** both years hosted so far.

### Teammates (essential names)

- **Drew** — software lead; owned **ReveilLib** (incl. odometry stack) and **driver control**.
- **Dimitris** — States Sonic paths (shared with Akhil); Worlds Sonic paths.
- **Sean** — teammate on software; **not** sole Knuckles States path owner (Akhil worked Knuckles States paths).

### Do not claim

- Shipping brain mount or rush clamp on competition robots.
- Owning ReveilLib implementation, odometry fusion design, driver control, or the **motor reverse wrapper** (Drew-authored; Akhil only merged PR #30).
- Owning Worlds Sonic paths (Dimitris).
- Solo credit for Texas Skills Champion or Worlds **~85%** AWP rate — those required **both robots** / whole-team auton (dual-credit always).
- Sole Aggieland Classic planning ownership.
- Vision / OpenCV / Pi stack (aspirational next year, not shipped).
- Invented path scores beyond CONTEXT-approved figures.
- **`aggierobotics/site`** as repo — use **`whooprobotics/website`**.
- Brain heat UI as shipped (library temp API shipped; Brain UI PoC only).
- **Public `aggierobotics.com` as live** until launch (~late Aug 2026) is confirmed.
- **Internal wiki/KB as shipped** — still in progress as of 2026-08-08.

### Git vs memory (paths)

- Prefer **local full clones** under `~/TAMU/Aggie Robotics/Software/` (or fetch all remote branches) — default-branch-only clones miss `shadow` / `knuckles2` / `lockdown` / `web`.
- **Git-backed under `akhilk999`:** Worlds Shadow (`shadow`), Knuckles (`knuckles2`), Lockdown skills files, ReveilLib motor_temp, website pages.
- **Also claim ownership for work committed on teammates’ machines** — Akhil often coded on someone else’s computer to avoid re-uploading ReveilLib and due to local PROS issues; git author may not be Akhil even when work is his (CONTEXT-endorsed). Do not treat missing personal git author as non-ownership.
- **Knuckles States:** Akhil worked those paths (confirmed) — supersedes earlier “Sean-only” interview line.
---

## Robot Architecture

### High Stakes (Sonic / Knuckles / Sonic V2 / Shadow)

- **Brain / OS:** VEX V5 Brain, **PROS** (C++).
- **Drivetrain:** **10-motor arcade** chassis; **custom omni wheels** with **polyurethane-cast** traction wheels (not holonomic X-drive).
- **Odometry:** **2 diagonal (45°) odom pods**; custom 3D-printed omnis, **linearly sprung** into the field; **IMU on the pods**; fused in Reveillib (**Drew**).
- **Subsystems:** intake; **linear slide lift** for climb; **rear mobile goal clamp**; **front mobile goal rush clamp**; **Lady Brown** — internal mechanism that rotates out, takes a ring off the conveyor, places on **wall stake** (auton via subsystem classes with angle setpoints/constants).
- **Sensors available:** IMU, **distance**, **color** (plus odom tracking wheels).
- **States → Worlds:** effectively different robots — CoM, subsystem implementations, and packaging changed even when concepts matched.

### Push Back (Lockdown)

- Same general stack idea (PROS + Reveillib-style waypoints/odom).
- **Custom mecanums** instead of omni + PU traction set.
- **Double-sided intake**, **rotating outtake**.
- **Color sensor** for ball sort (eject opposite color).
- Harder in practice: buggy scoring — outtake stuck / slow / mis-sort / inconsistency (see Failures).

---

## Autonomous Programming & Path Planning

### How paths were authored

- **Stack:** PROS C++; **Reveillib** in its **own repo**; tournament “frontend” repos with **one repo per tournament**, **two branches per robot** (identical concepts, different tuning). Local Reveillib instance used on-robot (exact vendoring details uncertain).
- **API shape (recalled):** waypoint/pose chaining — start pose, then motions with **location, heading, brake, speed**, etc.; combined with **PROS waits** and custom path poses. Exact API names not firmly remembered — do not invent signatures.
- **Waypoint design:** **start pose from field measurements**; rest largely **trial-and-error on field**. Tape outlines for starts; **physical aligners** (VEX metal beam against field features; 3D-printed when time allowed).
- **Auton length:** ~**30s** (VEXU). Strategy sketched on **whiteboard** (path geometry vs scoring value / risk).
- **Concurrency:** **async tasks** + motion timing — subsystem actions on motion completion or PROS timeouts.
- **Subsystem calls from paths:** custom classes per mechanism (e.g. Lady Brown angles); color **eject** as subsystem task toggled by alliance color + eject T/F.
- **Done criteria:** aim **~7/10** consistency; prioritize reliable **AWP** over max theoretical score.

### Localization

- Primary follow: Reveillib odom + IMU (Drew-owned).
- **Corrections Akhil used:** **distance sensors to side wall** — typically **one wall**, roughly every **5–10s** of auton; correction costs ~**1–2s** but bought consistency.
- Not pure open-loop from taped start — wall snaps included by design.
- **Debug odom:** logging; manually drag robot to inspect odom; compare other paths to separate mech vs code; classic failure: straight path drifted left → pod roller binding → shave roller, missing spacer, retighten to specific friction window.

### Sensors (as used in Akhil’s paths)

- **Distance:** wall localization (above).
- **Color:** High Stakes ring / Push Back ball sorting — **eject opposite color** via shared subsystem task.
- **IMU:** relied on Reveillib; Akhil not sure of separate heading hacks.
- **Aspiration:** Logitech + OpenCV on Pi + external power for future seasons — **not implemented**.

---

## Software Architecture

- **Languages / firmware:** PROS C++ on V5 Brain.
- **Split:** Reveillib (shared motion/odom/controls library, Drew) vs per-tournament robot branches (paths + tuning).
- **Driver control:** same repos as autons; **Drew only** from Akhil’s side.
- **Akhil library touchpoints:** motor **temperature** API (shipped); Brain heat UI PoC (not evidenced). **Not** motor reverse wrapper (Drew).
- **Path ↔ mechanism:** async tasks + timed/completion-gated subsystem commands (not a full formal state-machine claim unless evidenced later).

---

## Competition Strategy

### High Stakes dual-robot rush

- Two near-role-symmetric robots; differ mainly in **rush clamp / “tails” reach**.
- Place longer-reach bot on the side with **greater strategic rush advantage**.
- **Auton value:** win AWP + extra scoring only if it doesn’t jeopardize AWP.
- Controlling auton → ownership of **2 mobile goals** early → alliance partner rushes **1 more** for **3/5** majority control → match largely secured.
- **Skills vs quals:** skills = systematic max score under motion/scoring limits, **no AWP**; quals/elims prioritize **AWP / ranking**; separate AWP-oriented vs points-oriented paths existed, but strong AWP paths were sometimes reused in elims.
- **States vs Worlds rush meta:** States — few rivals contested rush hard; Worlds — top teams also rushed well → Worlds paths prioritized **rush speed and taking control** (Akhil’s Shadow work done under **~3 days at Worlds**).

### Push Back

- Lockdown States: 2 paths; no notable States result recorded for CONTEXT.
- Sorting + outtake reliability dominated practical strategy more than fancy routing.

### Team results (CONTEXT-approved)

**Texas VEXU State Championship — League City, TX, February 2025 (High Stakes)**

- **Excellence Award**
- **Robot Skills** champion (overall skills — **both robots’ paths**; Akhil on Sonic + Knuckles States; Dimitris shared Sonic)
- **Semifinalist** in match play

**VEXU World Championship 2024–2025 High Stakes**

- Announced team **~85% autonomous win rate** across the season (whole team / **both robots**; not Akhil-only).
- Seeding: **#10** before auton path fixes → climbed to **#2** in division after paths worked, before elims (**of 18 teams** — CONTEXT-verified with resume).
- Division finish: **semifinals** (Akhil’s recollection — soft).
- Climb note: among few teams with **double Tier 3 climb** in matches; **only** team recalled to **sustain a fall from Tier 3 with no robot damage**.

**VEXU World Championship 2025–2026 (CONTEXT-verified)**

- **Design Award**
- **#4 seed**

---

## Leadership & Org Engineering

- Shift May 2025: less path volume, more **mentorship + Webmaster/exec** — deliberate tradeoff so newer software members get reps; Akhil’s HS FTC background + busy schedule; not enough SW work to keep everyone busy as pure coders.
- Notion + Drive templates = lasting process; caution that **too much process** slows competition turnaround.
- Cross-team dependencies (mech, other alliances, event ops): **communicate early** when you will need something.

---

## Engineering Tradeoffs

1. **Wall localization pauses (~1–2s, every 5–10s) vs raw speed** — chose consistency / reliable AWP over uninterrupted fastest score; field + mech variance made brittle high-score paths fail in real events.
2. **AWP paths vs max-points paths** — quals ranking made AWP primary; maintained separate path goals; good AWP routes sometimes doubled as elim routes.
3. **Mentor/Webmaster vs personal path ownership** — chose org capacity + newer member growth over maximizing personal auton authorship in 2025–26 (except Lockdown States paths).
4. **Personal mech designs vs teammate designs** — clamps/mounts did not ship; correct call was best robot, not personal CAD on the bot.

---

## Biggest Technical Accomplishments

1. **Worlds Shadow paths (2)** under ~**3-day** Worlds time pressure — contributed to team auton that supported announced **~85%** season AWP rate and seeding recovery **#10 → #2** (team/both robots; Akhil owned Shadow only).
2. **States Sonic + Knuckles paths** as part of **Texas VEXU Skills Champion** + Excellence + semis run (Feb 2025, League City); Sonic shared with Dimitris; Knuckles States work by Akhil.
3. **Odom mechanical debug** on drifting straight paths (roller/spacer/tension) — software-looking bug fixed in hardware.
4. **Org tooling:** Notion adoption (**50+** members), Drive structure/templates, exec Webmaster track; site in progress.
5. **Aggieland Classic** ops support + judging (both hosted years).

---

## Biggest Failures

1. **Push Back outtake / conveyor hook** — hook caught; scoring inconsistent. Fix: find exact hook alignment so full rotation grabs and scores reliably.
2. **Odom “impossible” bad values (~40 min debug)** — taped wiring was **unplugged**. Lesson: check obvious physical/connect faults before deep software rabbit holes.
3. **Mech parts that never shipped** (brain mount, rush clamp) — time on non-fielded designs; acceptable when teammate parts were better, but ownership narrative must not claim fielded hardware.

---

## Lessons Learned

- **Consistency > peak score** when fields and mechanisms vary; a 50% hero path loses matches.
- **Check the obvious first** (power, plugs, mechanical bind) before long software debug.
- **Process helps up to a point** (Notion/Drive for safety, continuity, officer handoff); beyond that it blocks fast competition cycles — keep tooling proportional.
- **Cross-team / alliance / mech dependencies** are often outside your control — communicate needs **early and explicitly**.
- **Mentoring and org work** can be the higher-leverage move when coding seats exceed useful path work.

---

## Constraints

- **Competition team size (High Stakes WHOOP):** ~**17** — ~**11** hardware, ~**6** software. Software split ~**3 backend** (Reveillib + driver) / ~**3 frontend** (skills, quals, elims auton paths).
- **Org scale (Webmaster era):** ~**15** officers, **7** executive; Notion **50+** members.
- **Technologies:** VEX U / V5, PROS C++, **ReveilLib** (`whooprobotics/ReveilLib`) — Reckless path controller, PilonsSegment waypoints, TwoRotationInertialOdometry45Degrees, DualImu, Optical; odom pods + IMU, distance/color sensors; Webmaster: Next.js 15, React 19, Tailwind 4, Cloudflare (intended); Notion; Google Drive; Tournament Manager (Aggieland Classic).
- **Known uncertainties / soft memories:** exact path scores; which git repo/branch held Shadow Worlds / Sonic States paths Akhil edited; IMU self-corrections beyond library; Worlds division placement phrasing (“semis I think”); Brain heat UI PoC details.
- **Site:** `aggierobotics.com` **not live**; repo **`whooprobotics/website`**.

---

## Important Instructions

- Split storytelling: **High Stakes software contributor (2024–25)** vs **Webmaster / mentor / exec (2025–present)** vs light **Push Back States** paths.
- Strongest SWE/robotics interview stories: **Worlds 3-day Shadow paths**, **wall-localized AWP consistency**, **odom / sensor localization (−80%)**, **10+ routines / +35% auton scoring**, **States Sonic+Knuckles + awards**, **ReveilLib motor temperature API**.
- Strongest leadership/org stories: **Notion/Drive adoption**, exec Webmaster, **Aggieland Classic** judge/ops — not “I ran the tournament.”
- Always dual-credit team awards and **85% AWP** / Skills Champion; specify **Shadow** for Worlds path ownership; include Knuckles States as Akhil work.
- Never claim shipped clamp/mount, ReveilLib core ownership, driver control, **motor reverse wrapper authorship**, vision stack, or Lockdown States placement.
- Verified resume metrics OK to use: **+35% auton scoring**, **−80% positioning error**, **10+ routines**, **#10→#2 of 18**, **2026 Design Award / #4 seed**. Still dual-credit team awards / 85% AWP.
- Soft memories (exact ring counts, “semis I think”) stay soft — don’t harden inventively.
- High school FTC is **background only** unless a prompt explicitly asks prior robotics.
- Path work is **git-backed** on `WHOOP-sonic` (`shadow`, `knuckles2`) and Push Back Lockdown — analyze **all branches**. Ownership also covers code committed on teammates’ machines under other accounts.
- Website repo: **`whooprobotics/website`** (not `aggierobotics/site`).
