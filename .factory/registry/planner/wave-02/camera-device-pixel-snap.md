---
factory_version: 4.3.0
---

# The camera snaps to the device pixel

- **Date:** 2026-10-15
- **Outcome:** FollowCamera.resize(ScreenVec2 viewport, double devicePixelRatio); k = ratio × height ÷ 750 (T040).
- **Decisions:** ScreenVec2 is logical pixels (glossary screen point); dungeon.md §2's round(cam·k)/k uses device pixels, which matters at Windows' 125–150 %. No allocation in step is a Constraint plus checklist A10, not a criterion; never shaking is two criteria (comes to rest, deterministic) and no shake API (operator, 2026-10-15).
- **Deviations:** none
- **Evidence:** rejected: snapping to the logical pixel; an allocation criterion no test can observe.
