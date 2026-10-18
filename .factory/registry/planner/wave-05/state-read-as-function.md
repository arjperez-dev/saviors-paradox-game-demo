---
factory_version: 4.3.0
---

# Akeris reads ZoneState through a bound function

- **Date:** 2026-10-17
- **Outcome:** `EnterZone` (T147) takes `ReadZoneState = ZoneState Function()`; wave 6's composition root binds it to `StepZone.state`.
- **Decisions:** architect change-05 lets akeris consume `state/zone_state`; a function keeps akeris from importing dungeon (architecture §2.2) and needs no new contract.
- **Deviations:** none
- **Evidence:** rejected: a state-reader port in `core/contracts` (the architect's); a snapshot handed in by a test-only caller.
