%------------------------------------------------------------------------------
% Modular LaTeX Resume
% Based on Jake's Resume template (https://github.com/sb2nov/resume)
%------------------------------------------------------------------------------

This folder is the **LaTeX compile / selection surface** for resume PDFs.

Career facts, ownership, and bullet *candidates* live in `experiences/` and are produced via `prompts/` — see the repo [README.md](../README.md), [docs/RESUME_WORKFLOW.md](../docs/RESUME_WORKFLOW.md), and [prompts/README.md](../prompts/README.md). Promote candidates into `bullets/*.tex`; variants select what to include and in what order.

## Structure

```
resume/
├── main.tex                 # Shared document body (do not compile directly)
├── resume.cls               # Jake's Resume styling (fonts, margins, helpers)
├── backend.tex              # Compilable variants (open these — next to resume.cls)
├── master.tex
├── ai.tex
├── robotics.tex
├── product.tex
├── fdse.tex                 # Forward deployed / applied engineering
├── sections/
│   ├── header.tex           # Name + contact
│   ├── education.tex        # Uses \RelevantCoursework from the variant
│   ├── skills.tex           # Uses \Skills* macros from the variant
│   ├── experience/          # One file per role (headers only)
│   ├── projects/            # One file per project (headers only)
│   └── leadership/          # Optional leadership roles
├── bullets/                 # Reusable bullet banks per role/project
├── variants/                # Legacy folder — see variants/README.md
├── Makefile
└── README.md
```

## Compile

Always run commands from the `resume/` directory so `\input` paths resolve. **Open `backend.tex` (etc.), not anything under `variants/`.**

```bash
cd resume

# Single variant
make backend
# or
latexmk -pdf -jobname=backend backend.tex

# All variants
make all
```

Outputs: `master.pdf`, `backend.pdf`, `ai.pdf`, `robotics.pdf`, `product.pdf`, `fdse.pdf`.

## How customization works

Each of `backend.tex` / `master.tex` / `ai.tex` / `robotics.tex` / `product.tex` is the configuration surface for that resume:

1. **Bullet selection** — after `\input{bullets/flags}`, turn bullets off:
   ```latex
   \baBulletBfalse
   \khBulletAfalse
   ```
2. **Coursework** — override the ordered list (most important first; trim from the end if tight):
   ```latex
   \renewcommand{\RelevantCoursework}{Data Structures and Analysis of Algorithms, Software Engineering, Computer Systems}
   ```
3. **Skills** — override category macros the same way (order = priority; trim from the end):
   ```latex
   \renewcommand{\SkillsLanguages}{Python, C++, TypeScript, SQL}
   \renewcommand{\SkillsFrameworks}{FastAPI, React, Next.js}
   ```
   To drop an entire skills row, redefine `\SkillsContent` in the variant.
4. **Experience / projects / order** — edit `\ExperienceEntries` and `\ProjectEntries`.
5. **Leadership** — set `\ShowLeadershiptrue` and list entries in `\LeadershipEntries` (CSA Secretary + Aggie Robotics Webmaster on `product` / `fdse`).
6. **`fdse` variant** — Palantir-style applied/forward-deployed SWE: eng-forward stakeholder shipping; use instead of `product` when the role is embedded customer engineering, not PM.

**Space rule:** within coursework and each skills line, put must-keep items first and cut from the end when the PDF spills past one page.

### Adding a new experience

1. Add on/off flags in `bullets/flags.tex`.
2. Create `bullets/myrole.tex` with `\if... \resumeItem{...} \fi` entries.
3. Create `sections/experience/myrole.tex` with the `\resumeSubheading` header + `\input{bullets/myrole}`.
4. Add `\input{sections/experience/myrole}` to that variant's `\ExperienceEntries`.

No other copies of the wording are required.

## Visual styling

Do not change `resume.cls` unless you intend to update the look of **all** variants.
Section spacing, fonts, and helpers match Jake's Resume template.

## Notes

- All five variants currently emit the same content as the original monolithic resume (verified identical PDF content streams).
- Inactive roles (Preseed, Legal AI, CSA leadership) are preserved as optional `\input`s.
- Alternate bullet wording from the old file is kept as comments inside `bullets/`.
