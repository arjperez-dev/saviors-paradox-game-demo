---
factory_version: 4.3.0
---

# Contract ports/zone_presence

- **Date:** 2026-10-17
- **Outcome:** `ZonePresence.movedTo(Vec2 position)`, offered by dungeon, called by akeris once per step; stub `presence_in_zone.dart`.
- **Decisions:** dungeon's `RoomEntered`, `BossRoomEntered` and `WayDownReached` need Akeris's position; architecture §2.3 rule 2 (an outer feature calls a port the inner one offers) keeps dungeon knowing nobody, like its other four ports. The position means what `AkerisState.position` means. The three events keep their shape. Note for the planner: one dungeon task implements `movedTo` (rooms entered, boss room, way down); one akeris task calls it in its step.
- **Deviations:** architecture §2.3's dungeon and akeris rows do not list it yet; the operator updates the reference.
- **Evidence:** rejected: a client-owned `Vec2 get position` declared by dungeon and implemented by akeris (rule 3) — legal, but a second edge style for one value; rejected: dungeon hearing akeris's events — forbidden by §2.3.
