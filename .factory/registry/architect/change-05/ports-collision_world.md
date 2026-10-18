---
factory_version: 4.3.0
---

# Contract ports/CollisionWorld

- **Date:** 2026-10-17
- **Outcome:** `CollisionWorld` gains `isStaticSolidAt(Vec2)` and `carry(WorldBox)`; `zone_collision_world.dart` answers `false` and `Vec2.zero`, each marked not implemented.
- **Decisions:** zone 1 hazards.md: firm ground is stone, never a platform, and a platform carries Akeris and lifts him on top when it rises into him. `carry` answers for the zone's last step: the platform's displacement under the box, or the shift out of one that rose into it (`Sweep` passes solids already overlapped). Notes for the planner: one dungeon task implements both (each platform keeps its previous box); the akeris task sweeps the displacement `carry` returns; the composition root steps dungeon before akeris and every body that asks.
- **Deviations:** none
- **Evidence:** rejected: a kind or a motion on `CollisionHit` — a value combat's test builds; rejected: akeris resolving platform overlap, which only dungeon can see.
