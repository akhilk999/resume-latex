# Foodono — Interview Guide

> Sources: `FOODONO_CONTEXT.md`, `FOODONO_ACCOMPLISHMENTS.md`, `FOODONO_SYSTEM_DESIGN.md`, `METRICS.md`
> Rule: Prefer git-backed ownership. Do not invent users or overcrowding %. Soften Firebase claims.

# Project Summary

**FooDono** — Flutter app for the **2020 Congressional App Challenge (TX-03)** that lets food banks post appointment/signup slots and visitors reserve them, inspired by COVID news of people lining up at food banks that ran out before arrivals knew.

**Your role:** Majority Flutter UI contributor (main, maps/zip, producer form, confirm flow). Teammate Vedanth added Firebase RTDB. Shyam credited on README without git commits found. **No production users.**

### Elevator pitch (30–60s)

> In 2020 my team built FooDono for the Congressional App Challenge after seeing COVID coverage of food-bank lines where people waited only to find food already gone. We designed a Flutter app where food banks publish appointment slots and visitors sign up—closer to a reservation than a blind queue. I built most of the Flutter UI: the main dual-role screen, Google Maps zip-code flow, and the producer date/time appointment form. A teammate wired Firebase Realtime Database for storing listings. We didn’t ship to real users; it was a competition demo with a public walkthrough video.

# My Role

| Level | Scope |
|-------|--------|
| **Confirmed** | Flutter UI/navigation, Google Maps zip screen, producer appointment form UI, confirm/consumer screens, branding/icons (~29 commits) |
| **Shared / light** | Touching Firebase call sites after teammate integration; product ideation |
| **Teammate (Vedanth)** | Primary Firebase RTDB setup (`Added Firebase DB`, `locations.dart` majority) |
| **Do not claim** | Sole Firebase implementation; production users; measured overcrowding reduction |

# Technical Challenges

## Challenge 1 — Encoding a COVID queue problem as an app flow

### Situation

News showed food-bank shortages and long outdoor lines during COVID.

### Problem

Turn that into a student-shippable app mechanic without real pantry partners or inventory telemetry.

### Solution

Dual roles: producers create dated/timed signup slots; visitors find and confirm appointments instead of only lining up.

### Tradeoffs

Reservation UX is clearer than full inventory tracking; doesn’t literally detect “food ran out” in real time.

### Result

Coherent competition narrative + demo path; no live deployment metrics.

---

## Challenge 2 — Multi-screen Flutter navigation under a deadline

### Situation

Several screens evolved quickly (main, zip, locations, consumer, producer, confirm).

### Problem

Keep routing and merges stable while features landed in parallel (including teammate Firebase).

### Solution

`Navigator.push` graph; merge commits combining confirm/consumer with producer/main/zipcode; iterative UI polish.

### Tradeoffs

Some screens still create nested `MaterialApp` widgets (student-code smell); fine for demo, not for scale.

### Result

End-to-end demo: visitor and producer paths both reach confirmation.

---

## Challenge 3 — Maps + forms as the visitor/producer UX

### Situation

Needed geographic context and usable appointment creation.

### Problem

Deliver Maps + date/time pickers in Flutter as a relatively new stack for the team.

### Solution

`google_maps_flutter` on zip screen; `showDatePicker` / `showTimePicker` + `intl` on producer form.

### Tradeoffs

Default map camera is fixed (Plano area); zip isn’t a full geoquery implementation.

### Result

Polished enough for CAC demo video; clear UI ownership story for interviews.

---

## Challenge 4 — Honest ownership when Firebase isn’t yours

### Situation

Resume historically bundled “Flutter + Firebase + Maps” together.

### Problem

Git shows Vedanth’s Firebase commit as the DB integration; Akhil mainly researched Firebase.

### Solution

In interviews: “I owned Flutter UI/Maps/appointment forms; teammate implemented Firebase RTDB; I understand the `foodbanks` schema and write/read call sites.”

### Tradeoffs

Slightly less “full stack” brag; much higher credibility.

### Result

Clean ownership boundary aligned with CONTEXT/METRICS.

# Debugging Stories

1. **Compile / icon issues** — commits fixing compile errors and app icon iterations (Oct 2020).
2. **Merge conflicts across screens** — merge of confirm/consumer with producer/main/zipcode.
3. **Firebase init / empty lists** — discuss teammate’s `initializeFlutterFire` + FutureBuilder pattern without claiming you wrote it.
4. **What you’d harden first** — RTDB rules, auth, capacity limits, real geo search (system design “future”).

# Architecture Decisions

1. Flutter for Android/iOS student delivery
2. Visitor vs producer entry points
3. Google Maps on discovery screen
4. Firebase RTDB for shared demo data (teammate)
5. Simple appointment documents over inventory engine
6. Competition demo over production launch

# Lessons Learned

- Git history beats fuzzy memory for ownership — use it
- Split work (UI vs data) only works if you can still explain the full system
- Problem framing (COVID lines → reservations) is as important as widgets for product interviews
- Don’t inflate “users” for challenge apps
- Attribute teammates’ Firebase work explicitly

# Behavioral Stories

### News → product

- Saw coverage of food-bank lines / scarcity → team brainstormed reservation/signup app for CAC

### Teamwork

- Parallelized UI (Akhil) and Firebase (Vedanth); credited Shyam on README

### Integrity under resume pressure

- Willing to say “I researched Firebase but didn’t primarily implement it”

# Potential Interview Questions

- Walk me through visitor and producer flows.
- How would you detect “food ran out” for real?
- Why Flutter? Why Firebase?
- Who wrote the database layer? How do you know?
- How would you add auth and prevent fake food-bank posts?
- What’s wrong with using list length as RTDB keys?
- Did anyone actually use this? (Answer: no — competition/demo.)
- Honorable Mention — defend with award email (retained); note public site may only list the district winner

# Do Not Claim

- Production users or food banks served at scale
- Measured overcrowding / wait-time reduction %
- Sole Firebase Realtime Database implementation
- That FooDono won TX-03 outright (district winner was UpGrade) — you earned **Honorable Mention**, which is accurate and email-backed
- Modern production security posture
