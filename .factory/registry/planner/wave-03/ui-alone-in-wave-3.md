---
factory_version: 4.3.0
---

# Wave 3 carries core/ui alone

- **Date:** 2026-10-16
- **Outcome:** wave 3 is the feature `ui`, T051–T065; no other feature is planned.
- **Decisions:** core/ui is the last shared module; every feature imports it once on main (rule 31), so ring-1 features (dungeon, combat) start in wave 4 with all five shared modules on main (operator, 2026-10-16).
- **Deviations:** none; wave-02's `ui-moves-to-wave-3` holds.
- **Evidence:** rejected: ui with dungeon and combat in parallel, a much larger wave to plan and review.
