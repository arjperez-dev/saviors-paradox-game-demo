---
factory_version: 4.3.0
---

# Contract events/attack_blocked

- **Date:** 2026-10-14
- **Outcome:** `AttackBlocked`, emitted by combat; consumed by akeris, arsenal, bosses, enemies.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
