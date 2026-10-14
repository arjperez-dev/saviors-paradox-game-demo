---
factory_version: 4.3.0
---

# Input waits for the architect

- **Date:** 2026-10-14
- **Outcome:** `input` is out of wave 1; it is planned in wave 2 after an architect `change-02`.
- **Decisions:** `PlayerCommand` leaves two points open: keys whose command depends on context (Q/E, W/S, A/D, wheel in game, map, menu — `abilities` cannot know the map is open, and only `pause` emits `PauseOpened`), and `PanMap`'s unit and continuous panning without `dt` (operator, 2026-10-14). `Aim` can take an injected screen→world function.
- **Deviations:** wave 1 holds `loop`, `localization` and `rendering`; input takes ids after T033.
- **Evidence:** rejected: input emitting every meaning of a key, which fires abilities when the map closes.
