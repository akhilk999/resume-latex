# SecureSimple — System Design

> Interview-ready notes for an Ignite Design Challenge **electronic security circuit** (Multisim + report/presentation).  
> Sources: `SECURESIMPLE_CONTEXT.md`, `SECURESIMPLE_ACCOMPLISHMENTS.md`, docx Multisim diagrams.  
> Only technically supported information. Software sections that do not apply are marked N/A.

# Overview

**SecureSimple** is a student design-challenge home perimeter alarm concept (Team E4 / Surge Squad branding, Nov 2024). The engineering deliverable is a **NI Multisim** circuit that arms with one switch, trips on a door-sensor switch, and alerts via **LED + buzzer**, fed from residential AC through a **step-down transformer and bridge rectifier** in the final design.

**Not** a shipped IoT product. **No** production users, MCU firmware, or confirmed physical PCB build in sources.

Challenge prompt: design a circuit for an electronic security system with an activation and alarm method of your choosing.

# Architecture

```
                    ┌─────────────────────────────────────────┐
                    │         Final Multisim design           │
 Wall outlet AC     │                                         │
 120 Vrms 60 Hz ──► │ V1 ──► T1 (10:1) ──► D1 bridge rectifier│
                    │              │                          │
                    │              ▼                          │
                    │         DC rail (+ / GND)               │
                    │              │                          │
                    │         S1 arm (Key A)                  │
                    │              │  series AND              │
                    │         S2 door (Key B)                 │
                    │              │                          │
                    │        ┌─────┴─────┐                    │
                    │        ▼           ▼                    │
                    │      LED1        LS1                    │
                    │   (visual)   (buzzer 200 Hz)            │
                    └─────────────────────────────────────────┘

Logical control (Figure 1 flowchart):
  Power → (if AC) rectify to DC → if armed → if door active → LED+buzzer
```

**Experimental predecessor:** same series-AND + parallel loads, but **V1 = 12 V DC** only (battery narrative).

# Components

| Component | Role |
|-----------|------|
| **V1 (final)** | AC source 120 Vrms, 60 Hz |
| **T1** | Step-down transformer, turns ratio **10:1** (~12 Vrms secondary) |
| **D1** | Full-wave bridge rectifier **G3SBA60-E3/51** |
| **S1** | Arm / control-panel SPST (Multisim Key A) |
| **S2** | Door-sensor SPST (Multisim Key B); report: closed when door opens / intrusion |
| **LED1** | Visual alarm |
| **LS1** | Audible alarm, Multisim **BUZZER 200Hz** |
| **XSC1** | Oscilloscope (verification only) |
| **PR1 / PR2** | Voltmeter probes (verification only) |

**Product-concept extras (not in Multisim BOM):** adhesive mounts, optional remote UI, wireless alerts, 30-day refund marketing copy.

# Data Flow

Not a software data flow — **signal / energy flow**:

### Armed + door trip

```
AC → transform → rectify → S1 closed → S2 closed → current through LED ∥ buzzer → audible + visual alarm
```

### Disarmed or door inactive

```
Either S1 or S2 open → open series path → no load current → No Output
```

### Flowchart view

```
IF power_ok_as_DC AND home_alarm_on AND door_sensor_activated
THEN turn_on(LED, buzzer)
ELSE no_output
```

# Database Design

**N/A** — no database.

# APIs

**N/A** — no application APIs. Multisim interactive keys (A/B) are simulation controls only.

# Authentication/Security

| Layer | What exists |
|-------|-------------|
| **Physical security product intent** | Deter / detect perimeter intrusion; alert occupants/neighbors |
| **Circuit security topology** | Team researched closed-circuit loops (harder to defeat by cutting wires) but Conclusion states the Multisim solution behaves as an **open-circuit** trip (alarm when current flows). Self-identified weakness. |
| **Access control** | Arm switch S1 only — **no keypad, code latch, or auth** in schematic |
| **Wireless / app auth** | Described as future/product UI needing internet — **not implemented** |

# Infrastructure

| Item | Status |
|------|--------|
| Simulation toolchain | **NI Multisim** |
| Documentation | Final report (md/docx), Ignite PPTX |
| Hosting / cloud | N/A |
| Physical install | Concept: DIY adhesive door/window kit — not evidenced as built |

# Automation

**N/A** (no CI, no firmware automation). Closest analog: Multisim interactive simulation + instrument readouts for pass/fail of the buzzer path.

# AI Systems

**N/A.**

# Engineering Decisions

1. **Door contact / button activation** over motion — lower cost, lower false-alarm risk vs wind/dust, less power  
2. **LED + buzzer** over telephone autodialer — cost control  
3. **Series arm + door switches** — hardware AND so alarm only when armed and door condition met  
4. **Final supply: AC → transformer → rectifier → DC loads** — match wall outlet, run electronics on DC  
5. **Keep simple component count** on experimental model (5 parts) for manufacturability / teaching clarity  
6. **Copper conductors** argued for conductivity, malleability, thermal behavior (Altium citation)  
7. **Verify silent Multisim buzzer** with oscilloscope waveform + voltmeter polarity/nonzero checks  

# Tradeoffs

| Choice | Upside | Downside |
|--------|--------|----------|
| Button vs motion | Cost, false alarms, power | Perimeter-only; weak interior coverage |
| Local alarms vs autodialer | Cheap, simple | No automatic remote notify/police call |
| Open-circuit-style series trip | Easy Multisim AND | Weaker if wires cut; team prefers closed-circuit as future work |
| No post-rectifier filter cap (as drawn) | Simpler | Pulsating DC to LED/buzzer (scope shows ripple) |
| No LED series resistor visible | Simpler student schematic | Real hardware typically needs current limiting (undiscussed) |
| Wireless/UI as criteria | Product story | Not in electrical deliverable |
| Battery outage story vs final AC schematic | Reliability narrative | Explicit battery not shown on final Multisim sheet |

# Future Improvements

From team Conclusion / CONTEXT (supported):

1. Redesign toward a **closed-circuit** sensing loop for better cut-wire security  
2. Implement or drop the **wireless alert** criterion honestly  
3. Add proper **latching / keypad** behavior discussed in background research  
4. Add **filtering / LED current limiting** for a hardware-realistic BOM  
5. Quantify false-alarm and user-test metrics (proposed but not published)

# Ownership note (for design interviews)

- **Akhil:** design criteria, background contribution, flowchart presentation, Ignite slides  
- **Carson:** Multisim / technical focus  
- **Matt:** research / background focus  
- **Bao:** solutions narrative / Why Us positioning  
)
