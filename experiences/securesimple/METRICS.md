# SecureSimple — Metrics

Never invent numbers. Prefer provenance (report, presentation, Multisim diagrams, CONTEXT).

# Technical Metrics

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Team size | 4 | people | Report title page | Akhil, Bao, Carson, Matt |
| Report date | 2024-11-23 | date | Report | Ignite Design Challenge final report |
| Presentation slides | 10 | slides | PPTX | Incl. title, problem, criteria, diagram, solution, troubleshooting ×2, why us, process, references |
| Experimental DC supply | 12 | V DC | Multisim experimental schematic | V1 on prototype |
| Final AC supply | 120 | Vrms | Multisim final schematic | 60 Hz, 0° phase |
| Transformer turns ratio | 10:1 | ratio | Multisim final schematic | T1 |
| Bridge rectifier part | G3SBA60-E3/51 | P/N | Multisim final schematic | D1 |
| Buzzer label frequency | 200 | Hz | Multisim LS1 label | Simulation component label |
| Experimental component count (as claimed) | 5 | components | Report Solution | V1, S1, S2, LED1, LS1 |
| Series control switches | 2 | SPST | Both schematics | S1 arm, S2 door (Keys A/B) |
| Alarm output channels in circuit | 2 | channels | Schematics | LED visual + buzzer audible |
| Design criteria essential alert types listed | 3 | types | Report + PPTX | Light, sound, wireless (wireless not in Multisim) |

# Business Metrics

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Target product price (team claim) | 40–60 | USD | Report + PPTX “Why Us?” | Positioning target — **not** a measured BOM rollup |
| Traditional system price band cited | 150–600 | USD | NerdWallet / report; PPTX | Competitive framing |
| Install cost cited (market) | starts ~600 | USD | Cellucci & Weimert / Forbes (report) | External citation |
| Property crime frequency cited | every 4.4 | seconds | FBI 2019 via report/PPTX | External citation — not team measurement |
| Avg burglary loss cited (2019) | 2661 | USD | FBI via report | External citation |
| Homes without security more likely broken into | 300 | % | Hunter / Forbes via report/PPTX | External citation |
| U.S. population with home security cited | 25 | % | Hunter via report/PPTX | External citation |
| Burglars who look for alarm first | 83 | % | UNC Charlotte via report | External citation |
| Burglars who seek another target if alarm present | 60 | % | UNC Charlotte via report/PPTX | External citation |
| Production users / installs | 0 known | users | CONTEXT | Design challenge / simulation — do not invent adoption |
| Refund window claimed in copy | 30 | days | Report Solution | Marketing language; unverified policy |

# Awards / Recognition

| Name | Value | Source | Notes |
|------|-------|--------|-------|
| Ignite Design Challenge | Participated (Team E4) | Report, PPTX | Placement / score / award **unknown** |

# Metrics To Avoid

| Claim | Why not claim |
|-------|----------------|
| Ignite win, placement, score, or judge ranking | Not in report/pptx/docx |
| Measured false-alarm rate or true-detection % | Proposed as success metric; no results published |
| UI satisfaction survey scores | Mentioned qualitatively only |
| Exact manufacturing cost / margin proving $40–$60 | Target price, not costed BOM |
| Wireless alerts shipped / users monitored remotely | Criterion + product narrative only |
| Power consumption (W), battery life, efficiency % | Copper efficiency argued qualitatively; no watt measurements |
| Production installs, revenue, or “homes protected” | No deployment evidence |
| Sole Multisim / circuit implementation ownership | Carson focus per report |
| Sole research ownership | Matt focus per report |
| “Expert audit / standards compliance” as certification | Asserted in report copy without artifact |
| Oscilloscope cursor voltages as polished product specs | Use as verification-method evidence only |
| FBI / UNC / Forbes statistics as original research | Always attribute |
