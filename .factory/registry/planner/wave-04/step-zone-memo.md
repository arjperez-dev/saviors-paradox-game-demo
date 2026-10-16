---
factory_version: 4.3.0
---

# StepZone keeps its last snapshot as a memo

- **Date:** 2026-10-16
- **Outcome:** `StepZone.state` rebuilds `ZoneState` only when the zone or its revision changes (T105); platforms moving do not change the revision.
- **Decisions:** four features will read `ZoneState`; architecture §4 and §6.5 ask for one snapshot per step and small ones. The memo is derived data, not game state (operator, 2026-10-16).
- **Deviations:** none
- **Evidence:** rejected: a fresh snapshot on every read.
