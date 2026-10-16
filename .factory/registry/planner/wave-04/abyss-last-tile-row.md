---
factory_version: 4.3.0
---

# The abyss is no room, or a room's last tile row

- **Date:** 2026-10-16
- **Outcome:** `isAbyssAt` is true when no room's box holds the point, or the point lies within one tile of its room's bottom (T095).
- **Decisions:** `hazards.md`: a fall is "falling below the bottom of the room he was in"; a point-based contract cannot know which room a body was in, and a body leaving its room's bottom crosses that row first (operator, 2026-10-16).
- **Deviations:** none
- **Evidence:** rejected: only "outside every room", which misses a fall into a room in the row below.
