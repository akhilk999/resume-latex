# SecureSimple — Interview Guide

> Sources: `SECURESIMPLE_CONTEXT.md`, `SECURESIMPLE_ACCOMPLISHMENTS.md`, `SECURESIMPLE_SYSTEM_DESIGN.md`, `METRICS.md`  
> Rule: Do not claim primary Multisim ownership (Carson). Do not invent awards, users, or measured false-alarm rates. Attribute crime/cost statistics.

# Project Summary

**SecureSimple** — Ignite Design Challenge (Nov 2024), Team E4 (Surge Squad branding). Affordable home door/window alarm concept. Engineering deliverable: **Multisim** circuit with arm switch + door switch (series AND), LED + buzzer outputs, final design powered by **120 Vrms → 10:1 transformer → bridge rectifier**.

**Your role:** Background + **design criteria** contribution; owned/presented criteria and system flowchart slides; worked on the presentation. Equal overall team contribution claimed; Multisim focus was Carson’s.

### Elevator pitch (30–60s)

> For the Ignite Design Challenge my team designed SecureSimple—an affordable perimeter home alarm aimed at people priced out of $150–$600 systems. We had to pick an activation method and an alarm method, then prove a circuit in Multisim. I focused on background and design criteria—what “good” meant: light, sound, and ideally wireless alerts, plus cost, energy, reliability, and simple UX—and I presented those criteria and our control flowchart. We chose a door contact over motion for cost and false alarms, and LED plus buzzer over an autodialer. The final sim takes wall AC, steps it down, rectifies to DC, and trips only when the system is armed and the door switch closes. A teammate led Multisim; we also had to verify the silent Multisim buzzer with a scope and voltmeters. We didn’t ship hardware or win a documented award—this was a design-challenge circuit and report.

# My Role

| Level | Scope |
|-------|--------|
| **Confirmed** | Design criteria; background contribution; presentation (title, criteria, diagram, references); flowchart explanation |
| **Shared** | Overall report sections; team product narrative ($40–$60 DIY kit) |
| **Teammate-primary** | Multisim schematics + troubleshooting (**Carson**); research deep-dive (**Matt**); solutions / Why Us write-up (**Bao**) |
| **Do not claim** | Sole circuit design; wireless/app implementation; physical PCB; Ignite ranking; measured detection metrics |

# Technical Challenges

## Challenge 1 — Turning an open-ended prompt into requirements

### Situation

Ignite asked only for a security circuit with some activation and alarm method.

### Problem

Without criteria, the team could overbuild (motion + autodialer) or under-specify success.

### Solution

Defined essential alerts (light, sound, wireless) and ideal attributes (cost, energy, reliability, simple UI, ease of use), plus proposed tests (false vs true alarms, surveys, cost/energy comparisons).

### Tradeoffs

Wireless stayed on the criteria list without appearing in Multisim—creates interview honesty pressure.

### Result

Clear decision filter used for button vs motion and LED+buzzer vs autodialer. Criteria slides you can walk through.

---

## Challenge 2 — Activation and alarm method selection

### Situation

Background research covered closed/open loops, door switches, motion (microwave/PIR), siren+light, autodialer.

### Problem

Balance security effectiveness against affordability for lower/middle-income homeowners.

### Solution

Chose **door button/contact** activation and **LED + buzzer** alarm; argued lower false alarms than motion and lower cost than autodialer.

### Tradeoffs

Perimeter-only coverage; no automatic remote notification; open-circuit-style trip path weaker against wire cutting than closed-circuit.

### Result

Coherent product story at a **$40–$60** target vs **$150–$600** cited market band (target, not BOM).

---

## Challenge 3 — AC wall power vs DC loads (team Multisim)

### Situation

Homes supply AC; alarm loads in the design are DC-oriented.

### Problem

Make a final design realistic for outlet power while keeping simulation tractable.

### Solution

Final schematic: 120 Vrms → 10:1 transformer → G3SBA60 bridge → series switches → LED ∥ buzzer. Experimental model remained 12 V DC for simplicity/outage narrative.

### Tradeoffs

More components; no filter capacitor visible (pulsating DC on scope); battery backup claimed narratively but not explicit on final sheet.

### Result

Documented final Multisim design matching the flowchart’s “rectify if AC” step.

---

## Challenge 4 — Silent Multisim buzzer (team)

### Situation

Even a correct circuit produced no audio from Multisim’s buzzer model.

### Problem

Could not “hear” pass/fail.

### Solution

Oscilloscope across the buzzer path (full-wave rectified waveform) and voltmeter probes (nonzero on positive, zero on negative).

### Tradeoffs

Indirect verification; absolute probe readings are simulation artifacts, not lab-calibrated product specs.

### Result

Team could defend that the load path was energized under the armed+door condition.

---

## Challenge 5 — Honest ownership on a 4-person equal-credit team

### Situation

Report says everyone contributed equally, then lists specialization.

### Problem

Interviewers will ask “what did *you* build?”

### Solution

Lead with criteria, flowchart presentation, and background contribution; credit Carson for Multisim depth; discuss circuit at systems level without claiming sole authorship.

### Tradeoffs

Weaker “I drew every net” story; stronger requirements/systems story.

### Result

Credible, non-overclaiming narrative aligned with written evidence.

# Debugging Stories

| Story | Punchline |
|-------|-----------|
| Multisim buzzer silent | Don’t trust the UI metaphor—instrument the node (scope + meters) |
| Open vs closed circuit | Research preferred closed; implementation landed open—call out the gap and how you’d fix it |
| Criteria vs deliverable (wireless) | Separating “required for product” from “proven in prototype” is an engineering maturity signal |

# Architecture Decisions

1. Series S1 ∧ S2 as hardware AND (arm + door)  
2. Parallel LED ∥ buzzer as dual-channel local alert  
3. Final linear supply: transformer + bridge, no MCU  
4. Prefer button over motion for false-alarm/cost story  
5. Document flowchart before/alongside schematic for communication  

# Lessons Learned

- Requirements and success metrics should be written before schematic rabbit holes  
- Simulation tools have silent failure modes—plan alternate oracles  
- Security topology (open vs closed) is a first-class decision, not a footnote  
- Equal team grades ≠ interchangeable ownership in interviews  
- Product claims (wireless, $40–$60, audits) need the same evidence bar as circuits  

# Behavioral Stories

| Prompt type | Angle |
|-------------|--------|
| Teamwork / conflict | Scheduling friction across four people; communication as the fix (report Conclusion) |
| Ambiguity | Open Ignite prompt → criteria you drove |
| Integrity | Admitting open-circuit limitation and unimplemented wireless |
| Communication | Presenting criteria + flowchart to the class/judges |

# Potential Interview Questions

**Expect**

1. Walk me through the alarm from wall power to LED/buzzer.  
2. Why series switches? What happens if the owner leaves the system disarmed?  
3. Open-circuit vs closed-circuit—which did you build, and what’s the attack?  
4. Why not motion detection?  
5. How did you know the buzzer “worked” in Multisim?  
6. What was *your* contribution vs Carson’s?  
7. You listed wireless as essential—where is it?  
8. What’s between 12 Vrms secondary and ~peak DC after the bridge? Any filtering?  
9. How would you add a keypad latch so closing the door doesn’t clear the alarm awkwardly?  
10. Which crime/cost stats are yours vs cited?

**Red-flag answers to avoid**

- “I built the whole Multisim circuit myself.”  
- “We reduced false alarms by X%.”  
- “We won Ignite / protected N homes.”  
- “We shipped a wireless app.”  
- Presenting FBI/UNC numbers as personal measurements.
