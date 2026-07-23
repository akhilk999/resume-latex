# Foodono — Accomplishments

Source: `FOODONO_CONTEXT.md`, git analysis of `akhilk999/FooDono` (cloned for analysis then removed).
Do not invent metrics. Do not write polished resume bullets here.

---

## Accomplishment 1 — Flutter app shell and dual-role main screen

### What I Built

FooDono’s entry experience: branded main screen routing visitors vs food banks into separate flows.

**Ownership:** Primary UI implementer (confirmed — `main.dart` blame ~100% Akhil; commits for buttons, aesthetics, logos)

### Technical Implementation

- Flutter `MaterialApp` + `MainScreen` with Visitor → `ZipCode` and food-bank → `Producer` navigation
- Green-themed branding; main-screen logo asset; consistent button sizing/layout
- App bar iconography across screens

### Engineering Challenge

Early Flutter project structure and multi-screen navigation for a small team shipping to a competition deadline.

### Impact

Clear dual-sided product entry (visitor vs food bank) matching the reservation concept. No production user metrics.

### Evidence

`lib/main.dart`; commits `main screen added buttons`, aesthetics, logos; git blame

### Tags

Frontend, Product

*Skills demonstrated:* Flutter, Dart, navigation, UI layout

---

## Accomplishment 2 — Zip code + Google Maps visitor discovery screen

### What I Built

Visitor flow screen with embedded Google Map and zip-code input to start finding food-bank appointments nearby.

**Ownership:** Primary implementer (confirmed — maps/zip commits and majority `zipcode.dart` blame Akhil)

### Technical Implementation

- Added `google_maps_flutter` dependency; embedded `GoogleMap` with initial camera near Plano, TX (`LatLng(33.0198, -96.6989)`)
- Zip text field with length tracking / validation affordances; submit dialog; navigation into locations / consumer flow
- Map sizing constraints and layout polish

### Engineering Challenge

Integrating Maps in Flutter on a student timeline; coordinating navigation into Firebase-backed listing screens (listing read path largely teammate-owned).

### Impact

Gave visitors a geographic / zip-oriented entry instead of a blind line at a food bank. Competition/demo scope only.

### Evidence

`lib/zipcode.dart`; commits Sep 2020 maps/zip series; `pubspec.yaml` `google_maps_flutter`

### Tags

Frontend, Product

*Skills demonstrated:* Flutter, Google Maps API, forms, navigation

---

## Accomplishment 3 — Food-bank producer appointment form (date/time signup)

### What I Built

Producer-side form for food banks to publish appointment slots (name/address/date/time-style fields) so visitors can reserve rather than queue blindly.

**Ownership:** Primary UI/form author (confirmed — `created producerinfo`, date/time picker commits; `producerinfo.dart` majority Akhil blame). Firebase **write** helpers present in file but introduced/expanded in Vedanth’s Firebase commit — treat persistence as **shared / teammate-primary**.

### Technical Implementation

- Large Flutter form (`producerinfo.dart`, ~445 LOC) with controllers, date pickers (`showDatePicker`), time pickers (`showTimePicker`), `intl` formatting
- Navigation to confirmation screen on submit
- Uses `FoodBank` model `toJson` shape (`address`, `city`, `date`, `name`, `time`) aligned with RTDB records

### Engineering Challenge

Building a usable appointment-creation UX that encodes the COVID problem (reserve capacity) without a full production backend ownership story.

### Impact

Core product mechanic: food banks create signup slots; visitors later select them. Supports “reduce overcrowding / wasted trips” narrative qualitatively — **no measured overcrowding %.

### Evidence

`lib/producerinfo.dart`; commits `created producerinfo`, `finalized date pickers & started time pickers`

### Tags

Frontend, Product

*Skills demonstrated:* Flutter forms, date/time pickers, Dart

---

## Accomplishment 4 — Multi-screen visitor confirmation flow

### What I Built

Visitor path screens for viewing a selected food-bank appointment and confirming (“Your appointment is confirmed”), returning to main.

**Ownership:** Primary for screen structure/merges (confirmed — `confirm.dart`, `consumerinfo.dart` majority Akhil; Vedanth Firebase commit also touched these files)

### Technical Implementation

- `Consumer` screen shows bank name/address/appointment day-time and map widget
- `Confirm` success screen with return-to-main navigation
- Merged confirm/consumer with producer/main/zipcode navigation graph

### Engineering Challenge

Keeping navigation coherent across rapidly evolving screens while Firebase listing integration landed from a teammate.

### Impact

End-to-end demo path: discover → select → confirm appointment. Competition submission / YouTube demo.

### Evidence

`lib/confirm.dart`, `lib/consumerinfo.dart`; merge commits Oct 12 2020

### Tags

Frontend, Product

*Skills demonstrated:* Flutter navigation, UI composition

---

## Accomplishment 5 — Team Congressional App Challenge submission (FooDono)

### What I Built

Team contribution to a competition app addressing COVID food-bank lines via reservation/signup; public README, demo video, GitHub repo.

**Ownership:** Major engineering contributor on UI/maps/appointment forms (confirmed by commit volume). Co-authors: Vedanth (Firebase), Shyam (README-listed; no commits found).

### Technical Implementation

- Shipped Flutter app with Maps + Firebase stack for CAC TX-03 2020
- Documented purpose in README; demo at YouTube link in repo homepage

### Engineering Challenge

High-school team coordination under challenge timeline; splitting UI vs data-layer work.

### Impact

**No production users.** **Honorable Mention (Texas District 3)** confirmed via award email retained by Akhil. Strong behavioral/product story from news-inspired problem framing.

### Evidence

README team credits; https://github.com/akhilk999/FooDono; https://www.youtube.com/watch?v=XauwXcqWI1g; resume TeX award line

### Tags

Product, Leadership, Frontend

*Skills demonstrated:* teamwork, problem framing, competition delivery

---

## Non-accomplishment (explicit) — Firebase RTDB primary implementation

### What I Built

Firebase **research** only at a confidence level Akhil endorses; not claimed as primary implementation.

### Technical Implementation (team)

- Vedanth commit `Added Firebase DB`: `firebase_core`, `firebase_database`, `google-services.json`, `locations.dart` with `Firebase.initializeApp` + `foodbanks` reads, producer write path expansions
- RTDB path `foodbanks` storing appointment records

### Engineering Challenge

N/A for sole ownership claims.

### Impact

Enabled persistent listings for the demo. **Do not attribute primary Firebase implementation to Akhil.**

### Evidence

`git show 1404746`; blame majority on `locations.dart` = Vedanth; CONTEXT

### Tags

Cloud, Database

*Skills demonstrated:* (team) Firebase Realtime Database
