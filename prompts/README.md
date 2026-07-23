# Career Knowledge Base Prompt Library

## Purpose

This folder contains reusable AI prompts for maintaining the Career Knowledge Base.

The goal is to ensure every experience follows the same documentation pipeline.

The workflow is:

Experience
↓
Context Collection
↓
Repository Analysis
↓
Accomplishment Extraction
↓
System Documentation
↓
Metrics Extraction
↓
Interview Preparation
↓
Resume Bullet Generation
↓
Resume Variants
↓
Job Matching


---

# Adding a New Experience Workflow

When adding a new internship, project, or leadership experience:

## Step 1: Create Experience Folder

Create:

experiences/<experience_name>/

Example:

experiences/broadaxis/


Create:

- <NAME>_CONTEXT.md
- <NAME>_ACCOMPLISHMENTS.md
- <NAME>_SYSTEM_DESIGN.md
- <NAME>_INTERVIEW_GUIDE.md
- <NAME>_BULLETS.md
- METRICS.md


---

# Step 2: Fill Out Context File

Before running AI prompts, create:

<NAME>_CONTEXT.md


Include:

## Overview
- What was built
- Why it was built
- Who used it

## Personal Ownership
- Features personally built
- Areas owned
- Areas not worked on

## Constraints
- Team size
- Timeline
- Technologies
- Known inaccuracies

## Important Instructions

Examples:
- Git history is inaccurate
- Do not attribute Branding work
- Focus on Event and CRM ownership


This file provides project-specific instructions to every future analysis.


---

# Step 3: Run Extraction Prompts

Run in this order:

1. analyze_project_context.md
2. analyze_repository.md
3. extract_accomplishments.md


Outputs:

<NAME>_ACCOMPLISHMENTS.md


---

# Step 4: Generate Supporting Documentation

Run:

create_system_design.md

Output:

<NAME>_SYSTEM_DESIGN.md


Run:

create_metrics.md

Output:

METRICS.md


Run:

create_interview_guide.md

Output:

<NAME>_INTERVIEW_GUIDE.md


---

# Step 5: Generate Resume Material

Run:

generate_bullet_bank.md


Output:

<NAME>_BULLETS.md


Do not directly edit resume files yet.

Resume bullets should always originate from the bullet bank.


---

# Step 6: Resume Tailoring

For a specific job:

1. Add job description.
2. Run analyze_job_description.md.
3. Run compare_resume_to_job.md.
4. Select relevant bullets.
5. Update resume variant.


---

# Prompt Usage Rules

## Never:

- Generate resume bullets before extracting accomplishments.
- Invent metrics.
- Assume Git history represents ownership.
- Delete technical details during extraction.

## Always:

- Preserve evidence.
- Separate facts from assumptions.
- Document engineering decisions.
- Store outputs in the experience folder.


---

# Output Philosophy

The Career Knowledge Base should become:

- Resume source of truth
- Interview preparation system
- Portfolio documentation
- Technical growth record

Resume PDFs are generated artifacts, not the source of truth.