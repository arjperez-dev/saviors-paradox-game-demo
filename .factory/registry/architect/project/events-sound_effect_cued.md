---
factory_version: 4.3.0
---

# Contract events/sound_effect_cued

- **Date:** 2026-10-14
- **Outcome:** `SoundEffectCued`, emitted by abilities, akeris, bosses, chain, combat, dungeon, enemies, hazards, inventory, run; consumed by audio.
- **Decisions:** One generic cue carrying an id of `07-audio/sfx/sfx.md` and a position. An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: one event per sound, hundreds of contracts audio would have to know.
