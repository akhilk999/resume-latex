# Foodono — Context

## Overview

- **What was built:** FooDono — a Flutter mobile app connecting food banks (“producers”) with visitors (“consumers”) via signup / appointment flows, zip-code + Google Maps discovery, and Firebase Realtime Database storage of food-bank appointment listings.
- **Why it was built:** Inspired by COVID-era news of people lining up outside food banks that could run out of food before arrivals knew — the team’s solution centered on **reserving / signing up for distribution slots** to reduce overcrowding and wasted trips.
- **Who used it:** **No production users.** Built and submitted for the **2020 Congressional App Challenge (Texas District 3)**. Demo video exists on YouTube. Not a deployed consumer product.
- **Team:** Akhil Kasamsetty, Vedanth Venkatesh, and Shyam Bhagavatula (per README). Git contributors with commits: Akhil (majority), Vedanth (Firebase DB commit), ADAOS99 (1 minor commit — same GitHub id family as Akhil).

## Personal Ownership

Use git history as primary ownership evidence (Akhil’s memory of exact file ownership is incomplete). CONTEXT overrides overclaiming Firebase.

### Confirmed (Akhil — git-supported)

- Initial Flutter project setup and ongoing UI development (Aug–Oct 2020)
- Main screen (Visitor vs food-bank / producer entry)
- Zip-code screen: Google Maps embed, zip text input, navigation into visitor flow
- Producer (food bank) appointment form UI: date pickers, time pickers, form fields, navigation to confirm
- Consumer / confirm screens and multi-screen routing merges
- App icons, app bar branding, main-screen logo, aesthetics / layout polish
- ~29 commits under Akhil Kasamsetty (plus 1 ADAOS99 commit)

### Likely / shared

- Product idea and Congressional App Challenge framing (team)
- Some post-merge touch of Firebase call sites inside screens Akhil owned (e.g. `producerinfo.dart` write path coexists with Vedanth’s Firebase commit)

### Not claimed as primary / uncertain

- **Firebase Realtime Database implementation** — git: Vedanth Venkat commit `Added Firebase DB` (2020-10-13) added `google-services.json`, `firebase_core` / `firebase_database` deps, `locations.dart` Firebase read path, and large Firebase-related diffs. Akhil did **Firebase research** but does **not** confidently claim Firebase implementation ownership.
- Shyam Bhagavatula’s specific code contributions (named on README; **no git commits** found)
- Production ops, real food-bank partnerships, or live user metrics (none)

## Constraints

- **Team size:** 3 (Akhil, Vedanth, Shyam)
- **Timeline:** ~Aug 2020 – Oct 2020 primary build (resume: Aug 2020 – Dec 2020); light README/lockfile updates in 2022–2023
- **Technologies:** Flutter / Dart; Google Maps Flutter plugin; Firebase Core + Firebase Realtime Database; Android `google-services`; `intl` date formatting; json_annotation models
- **Competition:** 2020 Congressional App Challenge, TX District 3. **Honorable Mention** confirmed — Akhil retains the award email (not committed to this repo).
- **Known inaccuracies:**
  - Do **not** invent user counts, food banks served, or overcrowding reduction %
  - Do **not** claim sole Firebase ownership
  - Package name in `pubspec.yaml` is still `zipcode_screen` (prototype naming) — cosmetic only
  - Git is good for UI ownership; memory is weak — prefer git over recollection

## Important Instructions

- Frame as a **high-school / early competition team app** addressing COVID food-bank line problems via **appointment reservation / signup**, not a scaled production system.
- Lead with **Flutter UI, Maps, navigation, producer appointment UX** for Akhil.
- Firebase: say **team used Firebase RTDB**; attribute primary DB wiring to **Vedanth** unless Akhil later upgrades evidence.
- **No actual users** — impact is competition submission + demo, not production adoption.
- Demo: https://www.youtube.com/watch?v=XauwXcqWI1g
- Repo: https://github.com/akhilk999/FooDono
