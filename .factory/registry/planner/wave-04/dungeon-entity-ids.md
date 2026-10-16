---
factory_version: 4.3.0
---

# Dungeon numbers its own ids by block

- **Date:** 2026-10-16
- **Outcome:** `ZoneIds` gives `1 000 000 × zone + n`: rooms from 0, rings 1000, altars 2000, spirits 3000, platforms 4000 (T089).
- **Decisions:** no contract hands out `EntityId`s; a block per zone and kind keeps dungeon's ids apart while other features' ids do not exist yet (operator, 2026-10-16).
- **Deviations:** none; change-04 is asked to decide an allocator or a block per feature.
- **Evidence:** rejected: plain counters from 0, which would collide with other features' ids.
