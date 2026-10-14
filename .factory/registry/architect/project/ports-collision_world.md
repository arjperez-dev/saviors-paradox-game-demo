---
factory_version: 4.3.0
---

# Contract ports/collision_world

- **Date:** 2026-10-14
- **Outcome:** `CollisionWorld`, implemented by dungeon; consumed by akeris, bosses, chain, combat, enemies, hazards.
- **Decisions:** The name `architecture.md` §2.3 gives; sweeps and casts against the zone, abyss checks and hook points. An interface owned by its client's need, or a value type introduced by one (`docs/CONTRACT_SPEC.md` §2).
- **Deviations:** none
- **Evidence:** rejected: a `core/physics` shared module; integration of velocity stays with each body.
