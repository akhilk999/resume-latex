# SecureSimple — Accomplishments

Source: `SECURESIMPLE_CONTEXT.md`; Multisim / report / presentation artifact analysis (no software repository).
Do not invent metrics. Do not write polished resume bullets here.

**Ownership rule:** Report assigns Multisim/technical focus to **Carson**, research/background deep-dive to **Matt**, solutions narrative to **Bao**, and **Akhil** to background + design criteria + presentation. Equal overall contribution claimed; specialize claims accordingly.

---

## Accomplishment 1 — Design criteria and essential-function definition

### What I Built

The project’s **design criteria** framing: essential alert channels (light, sound, wireless), plus ideal attributes (cost, energy efficiency, reliability, simple UI, ease of use for homeowners), and proposed success metrics (false alarms vs true detections, UI surveys, cost/energy comparisons).

**Ownership:** Confirmed — report Conclusion (“Akhil … contributed to … design criteria”); presentation speaker notes for Design Criteria slide (Akhil).

### Technical Implementation

- Separated **essential** functions (LED/light, buzzer/sound, wireless alert) from **ideal** differentiators (affordability, efficiency, reliability, minimal UI)
- Tied criteria to measurable evaluation ideas: true/false alarm comparison, consumer UI/ease surveys, sample-home detection tests, manufacturing-cost and energy comparisons vs market products
- Presentation Slide 3 criteria list: Alarm (light, sound, wireless), Reliable, Energy efficient, Accessible, Cost effective, Easy to activate

### Engineering Challenge

Translate an open-ended Ignite prompt (“activation + alarm method of your choosing”) into concrete, testable requirements that still fit a student Multisim deliverable and a $40–$60 product story.

### Impact

Gave the team a shared filter for later choices (button vs motion; LED+buzzer vs autodialer; AC→DC supply). Wireless remained a criterion without a Multisim implementation — criteria honesty matters for interviews.

### Evidence

`SECURESIMPLE_CONTEXT.md` Design Criteria; report Design Criteria section; PPTX Slide 3 + Akhil notes; flowchart intent notes on Slides 3–4

### Tags

Product, Security, Leadership

*Skills demonstrated:* requirements definition, tradeoff framing, security-product thinking

---

## Accomplishment 2 — Background research synthesis (shared with Matt)

### What I Built

Contribution to the report **background**: closed- vs open-circuit burglar loops, door-switch vs motion activation, siren+light vs telephone autodialer, and market/crime statistics motivating affordability.

**Ownership:** Confirmed shared — Akhil “contributed to the background”; Matt had “more of a focus on the research and background.” Do not claim sole research ownership.

### Technical Implementation

- Documented closed-circuit vs open-circuit security properties (wire-cut defeat modes)
- Compared activation methods (frame button/contact vs microwave/PIR motion) on cost, power, false-alarm risk
- Compared alarm methods (local siren+light vs autodialer) on cost vs remote notification
- Cited FBI, Hunter/Forbes, UNC Charlotte, Harris/HowStuffWorks, cost sources (Forbes/NerdWallet)

### Engineering Challenge

Use domain research to justify a **simple button + LED/buzzer** path without pretending it matches premium motion + autodialer systems.

### Impact

Informed the team’s stated preferences (button for cost/false alarms; light+sound for cost) and later self-critique that the Multisim topology behaved like an **open-circuit** trip path despite preferring closed-circuit in research.

### Evidence

Report Background / Purpose / References; CONTEXT problem statement; Akhil ownership sentence in Conclusion

### Tags

Security, Product

*Skills demonstrated:* technical research synthesis, competitive/product analysis

---

## Accomplishment 3 — System block flowchart (control logic)

### What I Built

**Security Alarm System** block flowchart (report Figure 1): power conditioning → arm state → door sensor → LED + buzzer outputs.

**Ownership:** Confirmed presentation of the design diagram (Akhil speaker notes Slides 3–4). Diagram authorship vs team co-design is **not** individually proven — claim **explanation / criteria linkage**, not sole schematic drawing, unless clarified later.

### Technical Implementation

Nested decision flow:

```text
Power Supply
 → if AC → convert to DC with rectifier
 → if Home Alarm on (armed)
 → if Door Sensor activated
 → Turn on LED and buzzer
 else → No Output
```

Hardware realization (team Multisim): series S1 (arm) ∧ S2 (door) → parallel LED ∥ buzzer.

### Engineering Challenge

Express product requirements as a control loop that maps cleanly onto a 2-switch series AND without a microcontroller.

### Impact

Became the conceptual bridge between design criteria and the Multisim circuits; used in presentation to explain system behavior.

### Evidence

`REFERENCES/diagram_alarm_system_block_flowchart.png`; report Figure 1 caption; PPTX Slides 3–4 notes

### Tags

Security, Product

*Skills demonstrated:* system decomposition, digital/analog control logic framing

---

## Accomplishment 4 — Ignite presentation ownership (criteria, diagram, framing)

### What I Built

Substantial **presentation** ownership: title, design criteria, design diagram, and references slides (per speaker notes), including spoken explanation of essential vs ideal criteria and the flowchart.

**Ownership:** Confirmed — report (“worked on the presentation”); notes: Slides 1, 3, 4, 10 = Akhil.

### Technical Implementation

- Slide narrative: problem stats → criteria → flowchart → (teammates) circuit/troubleshooting/positioning → process → references
- Speaker notes emphasize light/sound/wireless essentials; reliability/energy/cost/accessibility; flowchart checks current type, arm state, door sensor to drive LED/buzzer

### Engineering Challenge

Communicate a Multisim-heavy design challenge to judges/class with clear requirements and architecture before diving into schematics.

### Impact

Aligned the team’s story: affordable perimeter alarm with explicit criteria and a simple control model. Did not create competition ranking evidence.

### Evidence

PPTX notes ownership table in CONTEXT; report contribution sentence

### Tags

Product, Leadership

*Skills demonstrated:* technical communication, presentation ownership

---

## Accomplishment 5 — Team circuit deliverable (shared; not Akhil-primary Multisim)

### What I Built (team)

Multisim **experimental** 12 V DC alarm (S1–S2 series, LED ∥ 200 Hz buzzer) and **final** 120 Vrms → 10:1 transformer → G3SBA60-E3/51 bridge → same switch/load topology; verified silent Multisim buzzer via oscilloscope (XSC1) and voltmeter probes (PR1/PR2).

**Ownership:** Team deliverable; report assigns Multisim/technical **focus to Carson**. Akhil may discuss as teammate who co-owned the overall project, **not** as primary circuit implementer.

### Technical Implementation

- Experimental: V1 = 12 V DC; Keys A/B; 5-component simplicity; battery/outage narrative
- Final: V1 = 120 Vrms 60 Hz; T1 10:1; D1 G3SBA60-E3/51; pulsating DC loads (no filter cap visible)
- Verification: full-wave rectified scope trace; PR1 nonzero / PR2 zero pass rule for buzzer path

### Engineering Challenge

Multisim learning curve; silent buzzer component; reconciling AC wall power with DC loads; open- vs closed-circuit security tradeoff.

### Impact

Met Ignite “design a circuit with activation + alarm method” requirement with a documented, tested simulation path and product positioning ($40–$60 DIY kit concept).

### Evidence

CONTEXT architecture/circuit sections; `diagram_experimental_dc_prototype.png`, `diagram_final_ac_transformer_rectifier.png`, `diagram_oscilloscope_verification.png`, `diagram_voltmeter_probes_PR1_PR2.png`; report Solution / Buzzer difficulty / Conclusion

### Tags

Security, Product

*Skills demonstrated (team):* Multisim, AC/DC conversion, series-AND sensing logic, simulation instrumentation

---

## Non-accomplishments / do-not-claim (for extraction hygiene)

| Item | Why |
|------|-----|
| Primary Multisim authorship | Carson focus per report |
| Wireless alert implementation | Criterion only |
| Production UI / firmware / PCB fab | Not evidenced |
| Measured false-alarm rate or survey scores | Mentioned, not quantified |
| Ignite placement / award | Not in sources |
| Sole background research | Matt primary focus |
)
