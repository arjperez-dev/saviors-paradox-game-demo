---
factory_version: 4.3.0
---

# Contract state/weapon_slot_snapshot

- **Date:** 2026-10-14
- **Outcome:** `WeaponSlotSnapshot`, a companion type of the contracts that name it.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
