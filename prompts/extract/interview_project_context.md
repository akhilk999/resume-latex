# Interview Project Context

You are gathering information for a Career Knowledge Base experience.

Do **NOT** generate `<NAME>_CONTEXT.md` immediately.

Instead, interview the project owner **one question at a time** until you have enough depth for future prompts to produce accomplishments, system design, metrics, interview guides, and resume bullets without re-asking the same questions.

==========================================================
INPUTS
==========================================================

The user will specify:

- Experience folder name / `<NAME>` (e.g. `securesimple`, `robotics`, `broadaxis`)
- Optional: rough overview, dates, teammates, links, docs already on hand

If documents or a repo already exist, use them only to ask better questions — do not silently invent ownership or metrics from them during the interview. Confirm contested details with the owner.

==========================================================
OUTPUT (ONLY AFTER THE INTERVIEW)
==========================================================

Generate:

`experiences/<experience_name>/<NAME>_CONTEXT.md`

Follow the standard CONTEXT sections used in this repo:

- Overview
- Personal Ownership (confirmed / shared / do not claim)
- Constraints (team size, timeline, technologies, known inaccuracies)
- Important Instructions

Plus any domain-depth sections needed so later prompts do not lose technical detail (architecture, decisions, tradeoffs, failures, lessons).

Clearly separate:

- Confirmed
- Likely / needs verification
- Unknown

==========================================================
INTERVIEW RULES
==========================================================

1. Ask **one question per turn**.
2. Ask follow-ups when answers are vague, missing numbers, missing ownership, or missing “why.”
3. Do not advance to the next major topic until the current one has enough detail.
4. Prefer concrete artifacts: systems touched, APIs, tables, PRs, metrics with provenance, failure modes.
5. Never invent metrics, awards, users, or ownership.
6. If the owner says they barely remember, help them recover structure with narrower questions (timeline → teammates → what shipped → what they personally did → hardest bug).
7. When the interview is complete, say you are ready to write CONTEXT, confirm `<NAME>` / path, then generate the file.

==========================================================
TOPIC CHECKLIST
==========================================================

Cover every relevant topic below. Skip topics that truly do not apply (e.g. no DB for a pure circuit lab), but explicitly note skips as N/A so later prompts do not assume missing work.

## 1. Project framing

- What was built?
- Why was it built?
- Who used it (or was it demo/course/competition only)?
- What problem did it replace or solve?
- Timeline and team

## 2. Personal ownership

- What did they personally build or own?
- What was shared?
- What should they **never** claim?
- How does evidence work here (git, docs, memory, manager)?

## 3. Architecture / system shape

Adapt to the domain:

**Software:** frontend, backend, DB, APIs, auth, infra, integrations  
**Hardware / embedded:** sensors, actuators, power, MCU/FPGA, protocols  
**Robotics:** drivetrain, auton, localization, sensors, control, mech integration  
**Product / ops:** workflows, users, tools replaced, process changes

## 4. Implementation depth

- Important modules / circuits / subsystems they can still explain
- Algorithms, data flows, control loops
- Tooling (languages, frameworks, CAD, simulation, cloud)

## 5. Engineering decisions and tradeoffs

- Alternatives considered
- Why the chosen approach
- What they would change now

## 6. Debugging and failures

- Hardest bug or failure
- How they diagnosed it
- What broke in prod/comp/demo
- Lessons learned

## 7. Impact and metrics

- Only numbers they can source
- Explicitly mark unsupported metrics to avoid

## 8. Collaboration and leadership

- Teammates and splits
- Mentoring, reviews, coordination
- Conflicts or communication lessons

## 9. Interview / resume angles

- Strongest technical story for SWE interviews
- Weak spots / overclaim risks
- Whether this experience is supporting vs headline on the resume

==========================================================
SUGGESTED QUESTION ORDER
==========================================================

Start broad, then narrow:

1. One-sentence: what was the project and when?
2. Team size / notable teammates / their role title
3. What shipped vs demo/course-only?
4. “If you had to defend ownership in an interview, what 2–3 things were yours?”
5. Walk the system architecture at a high level
6. Deep-dive the owned subsystem
7. Hardest technical challenge + debugging story
8. Metrics with provenance (or confirm none)
9. What must never appear on a resume for this project?
10. Anything else future-you would regret forgetting?

==========================================================
SUCCESS CRITERIA
==========================================================

The finished CONTEXT file should be detailed enough that:

- `analyze_project_context.md`
- `extract_accomplishments.md`
- `create_system_design.md`
- `create_metrics.md`
- `create_interview_guide.md`
- `generate_bullet_bank.md`

can run without re-interviewing the owner on the same facts.
