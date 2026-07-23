%------------------------------------------------------------------------------
% Modular LaTeX Resume
% Based on Jake's Resume template (https://github.com/sb2nov/resume)
%------------------------------------------------------------------------------

This repository maintains multiple resume variants from one shared codebase.
Edit content once; each variant chooses what to include and in what order.

## Structure

```
resume/
├── main.tex                 # Shared document body (do not compile directly)
├── resume.cls               # Jake's Resume styling (fonts, margins, helpers)
├── sections/
│   ├── header.tex           # Name + contact
│   ├── education.tex
│   ├── skills.tex           # Overridable skill category macros
│   ├── experience/          # One file per role (headers only)
│   ├── projects/            # One file per project (headers only)
│   └── leadership/          # Optional leadership roles
├── bullets/                 # Reusable bullet banks per role/project
├── variants/                # One compilable entry point per resume target
│   ├── master.tex
│   ├── backend.tex
│   ├── ai.tex
│   ├── robotics.tex
│   └── product.tex
├── Makefile
└── README.md
```

## Compile

Always run commands from the `resume/` directory so `\input` paths resolve.

```bash
cd resume

# Single variant
latexmk -pdf -jobname=master variants/master.tex
# or
pdflatex -jobname=master variants/master.tex

# All variants
make all
```

Outputs: `master.pdf`, `backend.pdf`, `ai.pdf`, `robotics.pdf`, `product.pdf`.

## How customization works

Each file under `variants/` is the configuration surface for that resume:

1. **Bullet selection** — after `\input{bullets/flags}`, turn bullets off:
   ```latex
   \baBulletBfalse
   \khBulletAfalse
   ```
2. **Skills** — override category macros before the body:
   ```latex
   \renewcommand{\SkillsLanguages}{Python, Go, SQL, TypeScript}
   ```
3. **Experience / projects / order** — edit `\ExperienceEntries` and `\ProjectEntries`.
4. **Leadership** — set `\ShowLeadershiptrue` and list entries in `\LeadershipEntries`.

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
