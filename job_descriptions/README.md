# Job Descriptions

Store and annotate job descriptions (or representative samples) for keyword mining, variant recommendation, and gap analysis.

**Methodology:** [docs/JOB_DESCRIPTION_ANALYSIS.md](../docs/JOB_DESCRIPTION_ANALYSIS.md)  
**Prompts:** [prompts/jobs/analyze_job_description.md](../prompts/jobs/analyze_job_description.md), [prompts/jobs/compare_resume_to_job.md](../prompts/jobs/compare_resume_to_job.md)  
**Template:** [_templates/JD_ANALYSIS_TEMPLATE.md](_templates/JD_ANALYSIS_TEMPLATE.md)

This is the **next active workflow step** after experience documentation.

---

## Layout

```
job_descriptions/
├── README.md
├── _templates/
│   └── JD_ANALYSIS_TEMPLATE.md
├── backend/
├── full_stack/
├── ai/
├── robotics/
├── product/
├── solutions/
├── quant/                 # NEW — trading / market-making SWE & quant-dev
├── forward_deployed/      # NEW — FDSE / embedded customer engineering
└── infra/                 # NEW — platform / cloud / production infrastructure
```

Put each analysis note in the **primary** category folder. If a posting blends categories, pick one primary and tag secondary categories inside the note.

Suggested filename: `Company_Role_YYYY-MM.md` (or `Company_Role_sample.md` / `*_watchlist.md` for evergreen or not-yet-live postings).

---

## Current analyses (2026-07-24)

### Backend

| File | Company / role |
|------|----------------|
| [backend/Google_SWE_Intern_BS_Summer2027.md](backend/Google_SWE_Intern_BS_Summer2027.md) | Google SWE Intern BS Summer 2027 |
| [backend/Amazon_SDE_Intern_2027.md](backend/Amazon_SDE_Intern_2027.md) | Amazon 2027 SDE Intern |
| [backend/TradeDesk_SWE_Intern_NA_2027.md](backend/TradeDesk_SWE_Intern_NA_2027.md) | Trade Desk NA SWE Intern 2027 |
| [backend/Anduril_SWE_Intern_2027.md](backend/Anduril_SWE_Intern_2027.md) | Anduril SWE Intern 2027 |
| [backend/ASM_SWE_Intern_Spring2027.md](backend/ASM_SWE_Intern_Spring2027.md) | ASM SWE Intern Spring 2027 (Phoenix) |
| [backend/Etched_Infrastructure_Intern.md](backend/Etched_Infrastructure_Intern.md) | Etched Infrastructure Intern |
| [backend/Virtu_SWE_Intern_2027.md](backend/Virtu_SWE_Intern_2027.md) | Virtu SWE Internship 2027 |
| [backend/CTC_SWE_Intern_Summer2027.md](backend/CTC_SWE_Intern_Summer2027.md) | CTC SE Internship Summer 2027 |
| [backend/Serval_SWE_Intern_Backend.md](backend/Serval_SWE_Intern_Backend.md) | Serval SWE Intern Backend |
| [backend/WesternDigital_SWE_Intern_Summer2027.md](backend/WesternDigital_SWE_Intern_Summer2027.md) | Western Digital SWE Internship Summer 2027 |
| [backend/Roblox_SWE_Intern_Summer2027.md](backend/Roblox_SWE_Intern_Summer2027.md) | Roblox SWE Intern Summer 2027 |

### Full Stack

| File | Company / role |
|------|----------------|
| [full_stack/Rippling_FullStack_SWE_Intern_Winter2027.md](full_stack/Rippling_FullStack_SWE_Intern_Winter2027.md) | Rippling Full Stack SWE Intern Winter 2027 |

### AI

| File | Company / role |
|------|----------------|
| [ai/Apple_ML_AI_Undergrad_Internships.md](ai/Apple_ML_AI_Undergrad_Internships.md) | Apple ML/AI Undergrad Internships |
| [ai/Monogram_SWE_Intern.md](ai/Monogram_SWE_Intern.md) | Monogram SWE Intern |
| [ai/Deepgram_SWE_Intern_Fall2026_Summer2027.md](ai/Deepgram_SWE_Intern_Fall2026_Summer2027.md) | Deepgram SWE Internship |

### Quant / Trading SWE

| File | Company / role |
|------|----------------|
| [quant/Akuna_Python_SWE_Intern_Summer2027.md](quant/Akuna_Python_SWE_Intern_Summer2027.md) | Akuna Python SWE Intern Summer 2027 |
| [quant/Akuna_Cpp_SWE_Intern_Summer2027.md](quant/Akuna_Cpp_SWE_Intern_Summer2027.md) | Akuna C++ SWE Intern Summer 2027 (stretch) |
| [quant/FiveRings_Software_Developer_Intern_Summer2027.md](quant/FiveRings_Software_Developer_Intern_Summer2027.md) | Five Rings Software Developer Intern 2027 |
| [quant/Jump_Campus_SWE_Intern.md](quant/Jump_Campus_SWE_Intern.md) | Jump Campus SWE Intern (Chicago) |
| [quant/Walleye_Quantic_QD_Intern_Summer2027.md](quant/Walleye_Quantic_QD_Intern_Summer2027.md) | Walleye Quantic QD Intern Summer 2027 (**deadline Jul 31, 2026**) |
| [quant/Walleye_Quantic_QR_Intern_Summer2027.md](quant/Walleye_Quantic_QR_Intern_Summer2027.md) | Walleye Quantic QR Intern Summer 2027 (stretch) |
| [quant/Optiver_SWE_Intern_watchlist.md](quant/Optiver_SWE_Intern_watchlist.md) | Optiver SWE Intern (watchlist — no live posting at capture) |

### Forward Deployed

| File | Company / role |
|------|----------------|
| [forward_deployed/Palantir_FDSE_Intern_Commercial.md](forward_deployed/Palantir_FDSE_Intern_Commercial.md) | Palantir FDSE Intern Commercial |
| [forward_deployed/Palantir_FDSE_Intern_USG.md](forward_deployed/Palantir_FDSE_Intern_USG.md) | Palantir FDSE Intern USG (eligibility-sensitive) |

### Infra / Platform

| File | Company / role |
|------|----------------|
| [infra/Akuna_Platform_Engineer_Intern_Summer2027.md](infra/Akuna_Platform_Engineer_Intern_Summer2027.md) | Akuna Platform Engineer Intern Summer 2027 |
| [infra/Palantir_SWE_Intern_Infrastructure.md](infra/Palantir_SWE_Intern_Infrastructure.md) | Palantir SWE Intern Infrastructure |

### Empty / reserved

`robotics/`, `product/`, `solutions/` — ready for future notes. Defense/autonomy SWE currently lives under `backend/` (Anduril) with robotics secondary tags.

---

## How to add a JD

1. Copy `_templates/JD_ANALYSIS_TEMPLATE.md` into the right category folder; rename it.
2. Paste or link the posting; fill keywords, technologies, responsibilities, impact themes.
3. Map to `experiences/` (strong / partial / gap) — **do not fabricate matches**.
4. Optionally run the job prompts to refine matching and bullet selection.
5. Record recommended variant + bullets to enable in `resume/variants/`.

---

## Principles

- Representative samples are enough; you do not need every posting you apply to.
- Match **truthful** experience only.
- One strong matched story beats five shallow keyword hits.
- Reuse category-level patterns so each new JD is incremental.
- Prefer **Quant Developer / SWE** over pure QR unless research evidence is strong.
- For FDSE, lead with stakeholder shipping (CSA/Broadaxis), not fake consulting travel.
