# Foodono — System Design

> Interview-ready notes for a competition Flutter app. Only technically supported information.
> Sources: `FOODONO_CONTEXT.md`, `FOODONO_ACCOMPLISHMENTS.md`, `akhilk999/FooDono` git analysis.

# Overview

FooDono is a Flutter mobile app built for the **2020 Congressional App Challenge (TX-03)**. It connects food banks and visitors through **appointment signup / reservation** flows so people are less likely to wait in COVID-era lines only to find food gone.

**Not** a production multi-tenant platform. **No** real end-user deployment metrics. Demo video available.

Team: Akhil (majority Flutter UI), Vedanth (Firebase DB commit), Shyam (credited; no commits found).

# Architecture

```
┌──────────────────────────────────────────────┐
│              Flutter App (Dart)              │
│  MainScreen                                  │
│    ├─ Visitor → ZipCode (Google Map + zip)   │
│    │              → LocationList (Firebase)  │
│    │              → Consumer → Confirm       │
│    └─ Producer → appointment form → Confirm  │
└───────────────────────┬──────────────────────┘
                        │
                        ▼
            ┌───────────────────────┐
            │ Firebase Realtime DB  │
            │   foodbanks/* records │
            └───────────────────────┘

Maps: google_maps_flutter (client SDK)
Android: google-services plugin + google-services.json
```

# Components

1. **MainScreen** — role choice (visitor vs food bank)
2. **ZipCode** — map + zip entry; navigates into listing flow
3. **LocationList** (`locations.dart`) — Firebase init + read `foodbanks` list (Vedanth-primary)
4. **Consumer** — appointment detail view for a selected `FoodBank`
5. **Producer** — form to create appointment slot (+ RTDB write present; Firebase wiring teammate-primary)
6. **Confirm** — success UI
7. **FoodBank model** — JSON serialize/deserialize for RTDB fields

# Data Flow

### Visitor

```
Main → ZipCode (map + zip)
    → LocationList loads foodbanks from Firebase RTDB
    → tap bank → Consumer (details + map)
    → Confirm
```

### Food bank (producer)

```
Main → Producer form (name/address/date/time pickers)
    → write FoodBank JSON under foodbanks/<index>
    → Confirm
```

# Database Design

Firebase Realtime Database collection/path: `foodbanks`

Record fields (from `FoodBank.toJson` / `fromJson`):

| Field | Meaning |
|-------|---------|
| name | Food bank / listing name |
| address | Street address |
| city | City |
| date | Appointment date string |
| time | Appointment time string |

Client model also uses prefixed getters (`aname`, `aaddress`, …). Index keys appear to be stringified list indices on write (`foodbanks/<length>`).

No server-side security rules captured in this repo analysis.

# APIs

- **Google Maps Flutter plugin** — map render / camera
- **Firebase Core + Realtime Database** client SDKs — read/write `foodbanks`
- No custom REST backend

# Authentication/Security

- No end-user auth flow found in Dart screens analyzed
- Android Firebase config via `google-services.json` (committed — typical student-project risk; do not rotate secrets in docs)
- Not production-hardened

# Infrastructure

- Flutter mobile (Android project present; iOS runner present)
- Firebase project linked for RTDB
- GitHub-hosted source; YouTube demo
- No CI/CD found

# Automation

None beyond client form submit → RTDB write and list refresh reads. No scheduled jobs.

# AI Systems

None.

# Engineering Decisions

1. Flutter for cross-platform student mobile delivery
2. Dual entry points (visitor vs producer) to model both sides of reservation
3. Google Maps on zip screen for geographic context (Plano-area default camera)
4. Firebase RTDB for quick shared persistence without a custom server (teammate-implemented)
5. Simple `FoodBank` JSON documents rather than a normalized relational schema
6. Competition/demo scope over production auth, waitlists, inventory counts, or push notifications

# Tradeoffs

| Decision | Benefit | Cost |
|----------|---------|------|
| RTDB + Flutter client only | Fast for CAC deadline | Weak security/auth, limited query model |
| Maps on zip screen | Visual polish / location context | Zip not deeply geocoded to markers in analyzed code |
| Index-as-key writes | Simple append | Race conditions / overwrite risk under concurrency |
| No real users | Fine for challenge demo | No production impact metrics |
| Split UI vs Firebase owners | Parallel work | Akhil should not overclaim Firebase |

## Failure Modes

| Failure | Notes |
|---------|-------|
| Firebase init failure | `_error` / `_initialized` flags in locations flow |
| Empty `foodbanks` | UI depends on FutureBuilder over `.once()` |
| Concurrent producer writes | Length-based child keys are fragile |
| Maps API key / device setup | Local run configuration required |

# Future Improvements

(Not shipped — interview “what would you do next”)

- Auth for food-bank accounts vs public write
- Real inventory / “food remaining” signal (closer to original news problem)
- Proper geoquery by zip; map markers for banks
- Waitlist / capacity limits per slot
- Push notifications when slots open or cancel
- iOS/Android release hardening; remove secrets from git
- Analytics only if ever piloted with a real pantry partner
