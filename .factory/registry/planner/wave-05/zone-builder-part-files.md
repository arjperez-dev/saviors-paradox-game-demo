---
factory_version: 4.3.0
---

# zone_builder.dart becomes three part files

- **Date:** 2026-10-17
- **Outcome:** T107 moves `_Placement` and `_Attacher` into part files, verbatim; it closes T092's open finding C4.
- **Decisions:** the file is 435 lines; a split along its existing classes keeps every `Random` call in order, so every seed lays out the same zone.
- **Deviations:** none
- **Evidence:** rejected: public helper classes, which would widen dungeon's domain for one builder.
