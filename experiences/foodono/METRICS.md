# Foodono — Metrics

Never invent numbers. Prefer provenance (git, README, CONTEXT).

# Technical Metrics

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Dart UI source (lib/*.dart) | ~1,249 | LOC | `wc -l lib/*.dart` | Excludes generated model.g.dart nuance; model files small |
| Lib Dart screens/modules | 6 | files | repo `lib/` | main, zipcode, locations, consumerinfo, producerinfo, confirm (+ models/) |
| Git commits (Akhil) | 29 | commits | `git shortlog` | Plus 1 ADAOS99 |
| Git commits (Vedanth) | 2 | commits | `git shortlog` | Includes merge + Firebase |
| Git commits (ADAOS99) | 1 | commits | `git shortlog` | Minor |
| Primary build window | 2020-08-30 → 2020-10-18 | dates | git log | Resume lists Aug–Dec 2020 |
| Team size (README) | 3 | people | README | Akhil, Vedanth, Shyam |
| Firebase commit insertions (Vedanth) | +845 / −347 | lines | `git show 1404746 --stat` | Large Firebase integration diff |
| `producerinfo.dart` size | ~445 | LOC | wc | Largest screen; Akhil-majority blame |
| `locations.dart` blame (Vedanth : Akhil) | ~200 : ~73 | lines | git blame | Supports Firebase ownership split |
| Maps default camera | Plano, TX area | lat/lng | `zipcode.dart` | 33.0198, -96.6989 |

# Business Metrics

| Name | Value | Unit | Source | Notes |
|------|-------|------|--------|-------|
| Production users | 0 | users | `FOODONO_CONTEXT.md` | Competition/demo only — do not invent adoption |
| Food banks onboarded (live) | 0 known | orgs | CONTEXT | Demo data only if any |

Qualitative product intent (COVID lines → reservation) is **not** a measured overcrowding reduction.

# Awards / Recognition

| Name | Value | Source | Notes |
|------|-------|--------|-------|
| Congressional App Challenge | Submitted, TX District 3 (2020) | README, repo | Confirmed competition target |
| Honorable Mention (TX-3) | Yes | Award email retained by Akhil | Confirmed. Public CAC TX-03 page lists district *winner* (UpGrade) only — HM often unlisted there; email is provenance. |

# Metrics To Avoid

| Claim | Why not claim |
|-------|----------------|
| Any user / MAU / downloads figure | Explicitly no production users |
| “Reduced overcrowding by X%” | Problem framing only; unmeasured |
| Sole Firebase / backend ownership | Vedanth’s Firebase commit + blame |
| Shyam’s specific LOC contributions | No git commits found |
| Production reliability / SLA | Student demo app |
| Invented food pounds distributed, banks served, etc. | No evidence |
