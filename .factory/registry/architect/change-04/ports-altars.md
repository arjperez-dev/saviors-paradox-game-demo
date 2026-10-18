---
factory_version: 4.3.0
---

# Contract ports/altars

- **Date:** 2026-10-17
- **Outcome:** `Altars` gains `AltarItem? takeWithin(Vec2 point)`; `zone_altars.dart` holds a stub-level `takeWithin` returning null; dungeon no longer consumes `PlayerCommand`.
- **Decisions:** G is a body action (on the ground, the 0.5 s pickup, items.md §2), so akeris decides it and calls `takeWithin` with his position. The 80 su reach and the altar's invariants stay behind the `Zone` root (`Zone.takeFrom`, T097), and dungeon raises `ItemTaken`. The returned item only tells akeris it took something; inventory and arsenal learn the item from `ItemTaken`, never from akeris (ring 2 never calls ring 3). Note for the planner: one dungeon task replaces the stub (`altarWithinReach`, `takeFrom`, save, publish `ItemTaken` and `sfx.item.take`); one akeris task handles `Take` and the pickup.
- **Deviations:** architecture §2.3's dungeon, akeris and inventory rows still say otherwise; the operator updates the reference. The architect revised `zone_altars.dart` so `main` compiles.
- **Evidence:** rejected: dungeon hearing `Take` itself — it cannot know Akeris's posture without `movedTo` carrying it; rejected: deferring to inventory (ring 3) — inventory is not the one who picks up.
