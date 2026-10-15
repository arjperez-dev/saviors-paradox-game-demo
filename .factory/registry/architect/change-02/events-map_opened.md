---
factory_version: 4.3.0
---

# Contract events/map_opened

- **Date:** 2026-10-15
- **Outcome:** `MapOpened` (HaltCause.map), emitted by map (stub `map_screen_flow.dart`); consumed by loop and input via the base, by hud and audio.
- **Decisions:** The map pauses the game and hides the HUD (06-ui/map §2); only the music sounds, in its light version (VISION §World; 07-audio/music).
- **Deviations:** Before it, the map raised no event and nothing could halt the loop for it.
- **Evidence:** rejected: reusing `ToggleMap` as the halt signal, a command not a fact.
