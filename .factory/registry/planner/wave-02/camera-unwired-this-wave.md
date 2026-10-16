---
factory_version: 4.3.0
---

# The camera is not wired this wave

- **Date:** 2026-10-15
- **Outcome:** FollowCamera keeps the stub's zero-argument constructor and defaults to 1920×1080 at ratio 1; no core/app note calls resize, track or confine.
- **Decisions:** its target and bounds come from AkerisState and ZoneState, so its wiring comes with Akeris's wave; T048's note builds FollowCamera() only for input's aim, and compiles against the stub or the real class.
- **Deviations:** none
- **Evidence:** rejected: a resize note from rendering, which would touch saviors_paradox_game.dart in two features of one wave.
