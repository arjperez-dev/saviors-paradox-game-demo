---
factory_version: 4.3.0
---

# Entities live behind their root

- **Date:** 2026-10-16
- **Outcome:** `Flight`, `Room`, `Altar` and `DriftingPlatform` are `part of` their root's library, with private constructors and mutators; roots answer only with ids, value objects, views or events.
- **Decisions:** checklist A7, A12 as a hard rule (operator, 2026-10-16). It is written into each root task's `Constraints`, and each root has a criterion where the root refuses a change and the invariant still holds.
- **Deviations:** part files get no test file of their own; they are tested through their root's.
- **Evidence:** rejected: public entity classes kept away from outside code by convention only; returning a `Room` or an `Altar` from a query.
