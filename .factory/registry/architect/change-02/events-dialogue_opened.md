---
factory_version: 4.3.0
---

# Contract events/dialogue_opened

- **Date:** 2026-10-15
- **Outcome:** `DialogueOpened` now extends `WorldHalted(HaltCause.dialogue)`; audio joins its consumers.
- **Decisions:** The dialogue stops the game (06-ui/dialogue §2); the music ducks −6 dB (07-audio/audio.md A4).
- **Deviations:** Earlier, audio did not hear it.
- **Evidence:** rejected: audio inferring a dialogue from `SpiritWhispered`.
