# SecureSimple — Context

> **Primary source of truth:** `Team E4 Ignite Design Challenge Report.md` (Final Report, November 23, 2024).  
> **Diagrams:** parsed from the matching `.docx` (Multisim schematics, oscilloscope, voltmeter probes, block flowchart, team logo).  
> **Supplement:** `IGNITE Presentation.pptx` (design criteria framing, process timeline, speaker-note ownership, market/positioning slides).  
> **Do not invent competition placements, survey scores, BOM unit costs, or fabricated hardware beyond what these sources state.**  
> **Resume bullets are not generated here** — this file is extraction only.

---

## Project metadata (confirmed)

| Field | Value |
|--------|--------|
| **Product / project name** | SecureSimple (report also writes “Secure Simple”) |
| **Course / challenge** | Ignite Design Challenge — Security System |
| **Team ID** | Team E4 |
| **Team branding** | “Surge Squad” (logo in report docx: maroon background, yellow lightning bolt, circuit/resistor/ground motifs) |
| **Report date** | November 23, 2024 |
| **Team members** | Akhil Kasamsetty, Bao Le, Carson Chandler, Matt Dumrongthai |
| **Deliverables evidenced** | Written final report; Multisim circuit prototypes + verification screenshots; Ignite presentation (10 slides) |
| **Physical hardware build** | **Not confirmed** in sources — work product is Multisim simulation + design documentation / product concept |

---

## Project overview (confirmed)

SecureSimple is a proposed **affordable, easy-to-install home door/window security alarm** designed for the Ignite Design Challenge. The team’s stated goal is an alarm that is **cost-effective, accessible, energy-conscious, and simple to use**, targeting lower- to middle-income homeowners who may not buy typical $150–$600 systems.

**What was actually engineered in the documented prototype:**

- A **Multisim electronic security circuit** with:
  - Arming control (switch)
  - Door-sensor activation (switch)
  - Visual alarm (**LED**)
  - Audible alarm (**buzzer**, Multisim label **BUZZER 200Hz**)
- An **experimental DC-only model**, then a **final AC-mains → step-down → rectified DC** model
- Verification that Multisim’s silent buzzer still “works” via **oscilloscope waveforms** and **digital voltmeter / probe readings**
- A **system block flowchart** (“Alarm System Block Diagram”) describing the control loop over power type, arm state, and door sensor
- Product/business narrative: adhesive mountable kit, ~**$40–$60** price target, optional UI / remote monitoring concept, 30-day refund claim in report copy

**What the challenge prompt required (presentation Slide 2):**

> Design a circuit for an electronic security system with an activation and alarm method of your choosing.

---

## Problem statement (confirmed)

### Challenge framing

Design an electronic security system circuit that includes:

1. An **activation method** (how intrusion / perimeter breach is detected)
2. An **alarm method** (how occupants / neighbors are alerted)

### Market / safety motivation (cited in report + presentation)

| Claim | Source cited in report |
|--------|-------------------------|
| Property crime occurs every **4.4 seconds** in the U.S. | FBI (2019 UCR) |
| Average loss per burglary (2019) **$2,661** | FBI |
| Homes **without** security systems **300% more likely** to be broken into; only **~25%** of U.S. population has a home security system | Hunter / Forbes Home |
| **83%** of burglars look for an alarm before attempting; **60%** seek another target if an alarm is present | UNC Charlotte study |
| Typical install cost starts ~**$600**; market systems often **$150–$600** | Cellucci & Weimert / Forbes Home; NerdWallet (Ramirez); presentation “Why Us?” |

**Target users (report Purpose):** lower- to middle-income families/individuals seeking home protection who are priced out of or overwhelmed by complex commercial systems.

### Domain research they used to choose topology (confirmed)

From Harris / HowStuffWorks-style background in the report:

**Circuit classes**

- **Closed-circuit system:** door closed → circuit closed → current flows; door open → switch opens → current stops → alarm. Harder for an intruder to defeat by simply cutting wires (cutting open-circuits the loop and can still trip depending on design).
- **Open-circuit system:** current flowing *through* the alarm path is what trips the alarm. Report notes this is easier to defeat by cutting wires.

**Activation methods considered**

| Method | Pros (as stated) | Cons (as stated) |
|--------|------------------|------------------|
| Door/window **button / contact switch** in frame | Affordable; good for perimeter; low false-alarm rate vs motion in wind/dust | Mainly perimeter; needs control box / latching logic so closing door doesn’t just re-arm/clear awkwardly |
| **Motion detector** (microwave Doppler / PIR) | Better once intruder is inside | More expensive; more power; higher false-alarm risk (weather, dust, small frequency changes) |

**Alarm / notification methods considered**

| Method | Pros | Cons |
|--------|------|------|
| **Siren + light** | Deters intruder; alerts nearby people | Local only |
| **Telephone autodialer** | Can notify owners / police remotely | Extra cost |

**Team’s stated preference in Background:** closed-circuit better for security; button activation favored for affordability; siren+light favored over autodialer to control cost.

**Important design outcome (Conclusion — confirmed):** the implemented Multisim solution is described as an **open-circuit** style path (alarm activates when electricity flows through the completed series path with both switches closed). They explicitly call this a drawback vs a closed-circuit design and list closed-circuit as future improvement.

---

## Engineering requirements / design criteria (confirmed)

### Essential functions (report Design Criteria + presentation Slide 3 + Akhil speaker notes)

Must have:

1. **Source of light** (visual alert) — implemented as **LED**
2. **Source of sound** (audible alert) — implemented as **buzzer**
3. **Wireless alert system** — listed as essential in criteria / slides

**Implementation gap (confirmed vs aspirational):** the Multisim final circuit implements LED + buzzer only. Wireless / remote UI is described in the Solution narrative as a product feature requiring internet for live remote monitoring, with physical controls still available offline — **no Multisim / firmware / app implementation is shown**. Treat wireless as a **design criterion / product claim**, not a verified prototype feature, unless later evidence appears.

### Ideal / differentiating criteria

- Cost efficiency / affordability
- Energy efficiency
- Reliability (incl. power-outage thinking in narrative)
- Simple / minimalistic UI
- Ease of use / accessibility for homeowners
- Easy to activate / assemble (presentation)

### Success metrics they proposed (confirmed as *intended* test plan — not as measured results)

**System-level**

- True intruder detections vs **false alarms**
- Consumer feedback surveys on UI satisfaction and ease of use

**Component / field**

- Sample-home object/door detection tests to tune detection behavior

**Cost / energy**

- Compare manufacturing cost and energy efficiency vs market products and vs individual component choices

**Report does not publish numerical false-alarm rates, survey scores, or measured wattage.** Customer feedback is mentioned qualitatively (“received customer feedback from participants in tests”) without tabulated data.

---

## Architecture

### Logical / control architecture — Figure 1 block flowchart (confirmed from docx `diagram_alarm_system_block_flowchart.png`)

Title on diagram: **Security Alarm System**

Control flow (nested conditionals):

1. Start from **Power Supply**
2. **If Power Supply is Alternating Current** → **Convert to Direct Current with rectifier** (else proceed; intent: system runs on DC)
3. **If Home Alarm is on** (armed) → else **No Output**
4. **If Door Sensor is activated** → else **No Output**
5. **Turn on LED and buzzer**

Equivalent boolean:

```text
IF (power_conditioned_to_DC)
AND (home_alarm_armed)
AND (door_sensor_activated)
THEN activate(LED, buzzer)
ELSE no_output
```

Presentation speaker notes (Akhil, Slides 3–4) restate the same: check correct current type, home-alarm state, and door-sensor state to manage LED and buzzer.

### Electrical architecture — experimental prototype (confirmed)

**Diagram:** `REFERENCES/diagram_experimental_dc_prototype.png` (docx image3; report “Experimental Model”)

| Element | Role |
|---------|------|
| **V1** | **12 V DC** source (battery / DC supply narrative) |
| **S1** | SPST, Multisim **Key = A** — security alarm **control panel / arm** switch; closed when user activates system |
| **S2** | SPST, Multisim **Key = B** — **door sensor**; report states closed when intruder opens the door |
| **LED1** | Visual output |
| **LS1** | **BUZZER 200Hz** audible output |
| Topology | **S1 and S2 in series** (hardware AND); **LED1 ∥ LS1** in parallel across the load rails after the series switches |

Report narrative strengths of this model:

- Simple to manufacture; **5 components**
- Cost-effective
- Stored energy (battery) → works during power outage

Report weaknesses:

- DC / battery only → batteries must be replaced; not infinite supply

### Electrical architecture — finalized product circuit (confirmed)

**Diagram:** `REFERENCES/diagram_final_ac_transformer_rectifier.png` (docx image2; report “Finalized Product”)  
**Also shown with probes:** `REFERENCES/diagram_oscilloscope_verification.png`, `REFERENCES/diagram_voltmeter_probes_PR1_PR2.png`

Power path:

```text
V1 AC mains (120 Vrms, 60 Hz, 0°)
  → T1 step-down transformer (turns ratio 10:1)  ≈ 12 Vrms secondary
  → D1 full-wave bridge rectifier (G3SBA60-E3/51)
  → series S1 (Key A) then S2 (Key B)
  → parallel loads: LED1 || LS1 (BUZZER 200Hz)
  → DC return / ground from rectifier negative rail
```

| Component (as labeled in Multisim) | Confirmed detail |
|------------------------------------|------------------|
| **V1** | AC voltage source **120 Vrms**, **60 Hz**, phase **0°** |
| **T1** | Transformer, **10:1** turns ratio |
| **D1** | Bridge rectifier part **G3SBA60-E3/51** |
| **S1 / S2** | Series SPST switches (Keys A / B) — arm + door |
| **LED1** | Alarm light |
| **LS1** | Buzzer **200 Hz** |

Report rationale for AC→DC:

- Home outlets supply **AC**; alarm electronics need **DC**
- AC stepped/transformed then rectified for alarm operation
- Cite Anker: DC systems can reduce power losses vs AC (used as energy-efficiency argument)
- Narrative: use AC from outlet for primary power; DC for alarm function; battery/DC thinking for outage resilience (exact battery + AC dual-feed hardware **not shown** on the final Multisim schematic — schematic is AC→transformer→rectifier→switches→loads)

### Product / packaging architecture (confirmed as product concept text)

- Pre-packaged set, easy install for homeowners
- **Adhesive-based mountable** parts for doors/windows
- No separate paid install fee claimed (DIY)
- Price band **$40–$60** max vs **$150–$600** traditional
- 30-day refund language in report
- “Audited by experts… compliant with security standards” — **asserted in report marketing copy; no audit artifact attached**

---

## Circuit design (confirmed)

### Logic

Series switches implement **AND**:

- Arm switch closed **AND** door switch closed → current to LED + buzzer
- Either switch open → no alarm output

Report mapping:

- **S1 closed** = user has armed the system (so alarm does not fire on the owner casually)
- **S2 closed** = door open / intrusion condition (per report wording)

### Open- vs closed-circuit classification (confirmed tension)

- Background argued **closed-circuit** is safer against wire-cutting
- Conclusion states the built solution is effectively **open-circuit** (alarm when current flows) and recommends researching a closed-circuit redesign (more components/time, better if wiring is cut/damaged)

### Materials / efficiency claims (confirmed as written rationale)

Copper chosen as main circuit-board conductor because (Altium citation):

- High electrical conductivity → fewer random shutdowns from insufficient current
- Malleability → larger wire cross-section possible → easier current flow, less heat
- Thermal conductivity → heat spreads rather than trapping
- Inexpensive, corrosion resistant vs alternatives discussed (aluminum / silver)

### UI / software concept (confirmed as narrative; not as implemented code)

- Minimalist UI to show alerts, emergencies, power outages
- Remote live monitoring needs **stable internet**
- All functions also accessible via **physical** alarm configuration
- Presentation: “simple User Interface that provides critical feedback”

**No app stack, MCU firmware, wireless module, or keypad code appears in Multisim diagrams.**

---

## Components used (confirmed from Multisim + report)

### Experimental model

- 1× DC supply **V1 = 12 V**
- 2× SPST switches **S1, S2**
- 1× **LED1**
- 1× **LS1** buzzer (**200 Hz** label)
- Total highlighted as **5 components**

### Final model (additional / changed)

- 1× AC source **120 Vrms / 60 Hz**
- 1× transformer **T1 (10:1)**
- 1× bridge rectifier **D1 = G3SBA60-E3/51**
- Same series **S1, S2** + parallel **LED1, LS1**

### Simulation / instrumentation (not product BOM, but used)

- **NI Multisim**
- Oscilloscope instrument **XSC1** (Channel A / Channel B)
- Digital voltage meters / probes **PR1, PR2**

### Explicitly considered but not used in final Multisim alarm path

- Motion detectors (microwave / PIR)
- Telephone autodialer
- Closed-circuit door loop topology (preferred in research; not what they shipped in sim)

---

## Software / firmware

| Item | Status |
|------|--------|
| Multisim schematic + interactive keys (A/B) | **Confirmed** — primary engineering tool |
| Embedded firmware / MCU | **Not present** in sources |
| Mobile/web UI implementation | **Described only** |
| Wireless protocol (Wi-Fi, cellular, RF) | **Named as requirement**, not implemented in shown circuit |
| Keypad / code latch control box | Discussed in background research; **not in Multisim final schematic** |

---

## Testing methodology (confirmed)

### Problem: Multisim buzzer is silent

Even with a correctly wired circuit, Multisim **does not produce audible sound** for the buzzer. Team devised two verification methods.

### Method 1 — Oscilloscope

**Diagram:** `REFERENCES/diagram_oscilloscope_verification.png`

- Attach oscilloscope across the buzzer path (report: Channel A before buzzer, Channel B after; screenshot shows **XSC1** with Channel A on the post-switch positive rail / load side and Channel B associated with the buzzer node, common ground)
- Observe waveform changes correlating with a continuous “buzz”
- Screenshot shows a **full-wave-rectified pulsating DC** trace on Channel A (consistent with unsmoothed bridge rectifier output), timebase on the order of **10 ms/div**, Channel A vertical scale **5 V/div** in the captured UI

### Method 2 — Digital voltmeters / probes

**Diagram:** `REFERENCES/diagram_voltmeter_probes_PR1_PR2.png`

- **PR1** on positive side of buzzer path; **PR2** on negative side
- Pass criterion per report: **nonzero** on positive (PR1), **zero** on negative (PR2) ⇒ circuit configured correctly and buzzer would produce noise in hardware

### Other testing mentioned (qualitative / planned)

- Trials with customer/participant feedback on prototype effectiveness
- False alarm vs true detection comparison framing: button activation expected to have **lower false alarms** than motion sensors in windy/dusty conditions
- No published contingency tables or percentages from those trials in the report

---

## Engineering decisions (confirmed)

1. **Activation = door button/contact switch**, not motion — cost, energy, false-alarm argument  
2. **Alarm outputs = LED + buzzer only** — skip autodialer to keep cost down  
3. **Series arm + door switches** — prevent armed-home false trips when owner is present / only trip when armed **and** door condition met  
4. **Start from AC mains + transformer + rectifier** for final design — match residential outlet power, run loads on DC  
5. **Keep experimental battery/DC model** for simplicity and outage narrative; evolve to AC-fed final schematic  
6. **Copper conductors** as efficiency/reliability material choice  
7. **Product positioning at $40–$60**, DIY adhesive install, minimal UI  
8. **Verify silent Multisim buzzer** with scope + voltmeters instead of audio  

---

## Tradeoffs (confirmed)

| Decision | Gain | Cost / risk |
|----------|------|-------------|
| Button vs motion | Lower cost, lower false alarms, less power | Weaker interior coverage; perimeter-only |
| Light+buzzer vs autodialer | Cheaper, simpler | No automatic remote police/owner call in the electrical design |
| Open-circuit-style series trip path | Simple 2-switch AND in Multisim | Weaker against wire cutting; team acknowledges closed-circuit would be more secure |
| AC→DC final supply | Matches wall power; DC for electronics | More components (transformer, rectifier); batteries still needed for true outage backup (not fully shown) |
| No filter capacitor visible after bridge | Simpler BOM | Pulsating DC to LED/buzzer (scope shows ripple); potential flicker / tone modulation in real hardware |
| No LED series resistor visible in Multisim screenshots | Simpler student schematic | Real LED would typically need current limiting — **not discussed in report** |
| Wireless/UI as criterion | Competitive product story | Not demonstrated in circuit deliverable |
| Equal team contribution claim | Collaborative course dynamic | Roles still specialized (see Personal Ownership) |

---

## Innovation (as claimed by team — confirmed wording)

Presentation “Why Us?” / report Solution:

- **Affordability:** **$40–$60** vs traditional **$150–$600**
- **Energy efficiency** via copper conductivity / malleability / thermal properties
- **Simple UI** with critical feedback
- **Button activation method** framed as a measurable, lower-false-alarm alternative to motion-heavy market products
- DIY adhesive install, no install fee
- Multisim buzzer workaround (scope + voltmeters) as process innovation for their toolchain limitation

**Do not inflate “revolutionary” marketing language from the slide into a novel patented sensing method** — the activation mechanism is a standard series door-switch alarm topology; the differentiator they emphasize is **cost + simplicity + false-alarm argument vs motion**.

---

## Competition results

| Item | Status |
|------|--------|
| Ignite Design Challenge participation / Team E4 deliverables | **Confirmed** |
| Placement, score, awards, judges’ feedback | **Not stated** in markdown report, docx, or presentation |

---

## Market analysis (confirmed citations + team positioning)

### Problem market facts they cite

- High property-crime frequency (FBI 4.4 s)
- Average burglary loss $2,661 (2019)
- Security systems deter (UNC Charlotte 83% / 60%; Hunter 300% / 25%)
- Cost barrier: install from ~$600; retail systems often $150–$600

### Positioning

- Price: **$40–$60**
- Segment: lower- to middle-income homeowners
- Differentiation: affordable, efficient, simple UI, button-based reliability narrative, DIY adhesive kit
- Risk mitigation copy: 30-day refund; “expert audit / standards compliance” claim (unverified artifact)

### Competitive alternatives discussed

- Closed- vs open-circuit commercial door loops
- Motion (microwave / PIR)
- Siren+light vs telephone autodialer
- Copper vs aluminum/silver conductor arguments (efficiency literature)

---

## Process / timeline (presentation Slide 9 — confirmed)

1. **Brainstorm**
2. **Research phase** — electric circuits, electronic security systems, Multisim; gather knowledge from resources
3. **Drafting circuits in Multisim**
4. **Testing** electrical circuits (incl. buzzer workarounds)
5. **Finalizing** electronic circuit

### Team challenges / lessons learned (report Conclusion — confirmed)

**Technical**

- Little initial Multisim experience → significant explore/play time
- Multisim buzzer silence → oscilloscope + voltmeter verification methods
- Design tension: open- vs closed-circuit security properties

**Team / process**

- Conflicting schedules and work environments made meetings hard
- Learned importance of **communication**
- Learned electric circuits, how electronic security systems function, and Multisim

**Future improvement they name**

- Research / redesign toward a **closed-circuit** system despite more components and time

---

## Personal ownership — Akhil Kasamsetty

### Confirmed (report Conclusion)

> “Carson had more of a focus on the technical aspects and the MultiSim simulation, Matt had more of a focus on the research and background, Bao was tasked with discussing the solutions, and **Akhil also contributed to the background and design criteria and worked on the presentation.**”

Also: “each team member contributed to every part, and every member contributed equally” — treat as **shared overall credit**, with the specialization sentence as the concrete split.

### Confirmed (presentation speaker notes — who presented which slide)

| Slide | Topic | Speaker note owner |
|-------|--------|--------------------|
| 1 | Title — SecureSimple | **Akhil** |
| 2 | Problem | Matt |
| 3 | Design Criteria | **Akhil** (detailed notes on essential light/sound/wireless; reliability/energy/cost; accessibility; flowchart intent) |
| 4 | Design Diagram (flowchart) | **Akhil** |
| 5 | Solution | Carson |
| 6 | Troubleshooting | Carson |
| 7 | Additional Troubleshooting | Bao |
| 8 | Why Us? (affordability, copper, UI, button method) | Bao |
| 9 | Process | Carson & Matt |
| 10 | References | **Akhil** |

### Practical ownership summary for interviews / resume (confirmed-only)

**Akhil — claim with source support**

- Co-authored **background** and **design criteria** sections of the final report
- Owned / presented **design criteria** and **system block-diagram** explanation
- Worked on the **Ignite presentation** (title, criteria, diagram, references slides per notes)
- Shared equal team contribution across the project per report

**Do not claim as Akhil-primary without extra evidence**

- Primary Multisim schematic authorship / simulation debugging → report assigns focus to **Carson**
- Primary research deep-dive → **Matt**
- Solution write-up / “Why Us” product narrative presentation → **Bao**
- Sole inventor of the circuit topology
- Shipped physical PCB / installed field hardware
- Implemented wireless stack or production UI
- Competition win / ranking (unknown)

---

## Teammate roles (confirmed)

| Member | Report focus | Presentation notes |
|--------|--------------|--------------------|
| **Carson Chandler** | Technical aspects + Multisim simulation | Solution; Troubleshooting; Process (with Matt) |
| **Matt Dumrongthai** | Research + background | Problem; Process (with Carson) |
| **Bao Le** | Discussing / writing solutions | Additional troubleshooting; Why Us? |
| **Akhil Kasamsetty** | Background + design criteria + presentation | Title; Design Criteria; Design Diagram; References |

---

## Diagram index (docx → workspace)

Stored under `experiences/securesimple/REFERENCES/`:

| File | Content |
|------|---------|
| `diagram_alarm_system_block_flowchart.png` | Figure 1-style Security Alarm System flowchart (power → rectifier → armed → door → LED+buzzer) |
| `diagram_experimental_dc_prototype.png` | 12 V DC, S1–S2 series, LED ∥ buzzer |
| `diagram_final_ac_transformer_rectifier.png` | 120 Vrms → 10:1 transformer → G3SBA60 bridge → S1–S2 → LED ∥ buzzer |
| `diagram_oscilloscope_verification.png` | Final circuit + XSC1 full-wave rectified waveform |
| `diagram_voltmeter_probes_PR1_PR2.png` | PR1/PR2 probes on buzzer path |
| `branding_surge_squad_logo.png` | Surge Squad team logo |

---

## Assumptions / unverified (explicitly separated)

Mark these as **assumptions** unless confirmed later by Akhil or new artifacts:

1. **Team name “Surge Squad”** is the official Ignite team name (logo present; report header says Team E4 / SecureSimple — relationship assumed).
2. **Physical prototype** was built beyond Multisim (sources show simulation screenshots only).
3. **Wireless alert** was prototyped (listed as essential; not in electrical deliverable).
4. **UI** existed as software (described; no screenshots/code).
5. **$40–$60** is a real BOM-backed manufacturing cost (presented as product target, not a measured cost rollup).
6. **Customer tests** produced usable quantitative metrics (mentioned, not tabulated).
7. **Expert audit / standards compliance / 30-day refund** are real operational policies (report marketing language).
8. **Battery backup** is part of the final electrical design (narrative yes; final Multisim shows AC→DC path without an explicit battery symbol).
9. Oscilloscope cursor voltages / probe microvolt readings in screenshots are authoritative absolute calibrations (use them as **evidence of method**, not as polished measured product specs).
10. Any Ignite **award or ranking**.
11. Course department, grade, or credit hours (not in these three files).

---

## Source map

| Source | Use |
|--------|-----|
| Markdown final report | Problem, criteria, solution narrative, AC/DC rationale, copper, UI, testing story, conclusion, contributions, references |
| DOCX media | Authoritative Multisim component values, flowchart structure, verification setups, Surge Squad branding |
| PPTX slides + notes | Challenge one-liner, criteria list, process steps, “Why Us” claims, slide-level presentation ownership |

### References listed by the team (confirmed)

- Altium — copper efficiency (2018)
- Anker — AC vs DC (2023)
- Cellucci & Weimert / Forbes Home — security system cost (report); presentation also lists Perry, Christin Forbes Home cost article
- FBI — property crime (2019)
- Harris, Tom — HowStuffWorks burglar alarms (2001)
- Hunter, Samantha — Forbes Home burglary facts (2022)
- Ramirez, Dalia — NerdWallet home security cost 2024
- UNC Charlotte — burglar habits study (2013)

---

## Important instructions (for later resume / interview / system-design docs)

- Prefer **Multisim circuit + verification methods + design criteria ownership** as Akhil’s sharpest technical story; pair with **Carson** for deep Multisim implementation questions.
- Always note the deliverable is a **design-challenge circuit simulation + report/presentation**, not a shipped IoT product, unless new evidence appears.
- When discussing security topology, be ready to explain the **open- vs closed-circuit** tradeoff and that the team’s own conclusion flags open-circuit as a limitation.
- Keep market statistics **attributed** (FBI, Hunter, UNC Charlotte, Forbes/NerdWallet) — do not present them as original measurements.
- **Do not generate resume bullets in this file**; extract accomplishments elsewhere from confirmed ownership only.
)
