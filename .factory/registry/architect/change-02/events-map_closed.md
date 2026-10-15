---
factory_version: 4.3.0
---

# Contract events/map_closed

- **Date:** 2026-10-15
- **Outcome:** `MapClosed` (HaltCause.map), emitted by map; consumed by loop, input, hud and audio.
- **Decisions:** Pairs with `MapOpened` (06-ui/map §2: M or Esc closes).
- **Deviations:** none
- **Evidence:** rejected: closing the map through `PauseClosed`.
