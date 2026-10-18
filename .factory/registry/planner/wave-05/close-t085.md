---
factory_version: 4.3.0
---

# Close T085's C2 finding

- **Date:** 2026-10-17
- **Outcome:** T113 and T114 make `EngagementQueue` and `StepFlights` depend on `CombatantRegistry`; T143–T145 move the roster to `infrastructure/`. They close the finding in `implementer/combat/T085.md`.
- **Decisions:** architect change-04 added `byId` to the contract, which T085 lacked.
- **Deviations:** none
- **Evidence:** rejected: keeping the concrete roster in the use cases.
