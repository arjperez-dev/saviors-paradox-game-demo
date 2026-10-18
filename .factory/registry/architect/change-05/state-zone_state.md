---
factory_version: 4.3.0
---

# Contract state/ZoneState

- **Date:** 2026-10-17
- **Outcome:** `ZoneState` unchanged; akeris now consumes it (akeris `CLAUDE.md` row).
- **Decisions:** Akeris starts a zone at `ZoneState.start`, read when `ZoneEntered` arrives; an outer feature reads an inner one's state (architecture §2.3, way 1). Note for the planner: one akeris task places Akeris at `ZoneState.start` on `ZoneEntered`. Until dungeon implements `CollisionWorld.isStaticSolidAt`, no firm ground is ever recorded, so akeris defines the abyss return with no firm ground yet (the zone's start) and tests it.
- **Deviations:** architecture §2.3's akeris row does not list "reads `ZoneState`" yet; the operator updates the reference.
- **Evidence:** rejected: `ZoneEntered` carrying the start (see `events-zone_entered`).
