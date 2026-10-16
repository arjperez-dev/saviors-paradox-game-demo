---
factory_version: 4.3.0
---

# Every aggregate root has a repository

- **Date:** 2026-10-16
- **Outcome:** `Engagement` (the pending ones), `StatusEffects`, `Flights` and `Zone` each get a port in `application/ports/` and an in-memory implementation in `infrastructure/` (T074, T076, T079, T099).
- **Decisions:** use cases and systems load their root, call it, save it and hold no state (checklist A7, A14) (operator, 2026-10-16). The two systems keep scratch buffers, and `StepZone` a derived memo; none is game state.
- **Deviations:** none
- **Evidence:** rejected: use cases holding the aggregates as fields, which made `ZoneCollisionWorld` and `CombatantRoster` hold state.
