---
factory_version: 4.3.0
---

# A flight is named by its own id type

- **Date:** 2026-10-16
- **Outcome:** `Flight` is equal by `FlightId`, an extension type combat numbers itself (T077), not by `EntityId`.
- **Decisions:** projectiles have no `EntityId` in the contract, and numbering them in the zone's id space would collide with the bodies' ids; checklist A12's "equal by its id" holds with the entity's own id.
- **Deviations:** none
- **Evidence:** rejected: minting `EntityId`s inside combat.
