---
factory_version: 4.3.0
---

# Combat and dungeon are not wired this wave

- **Date:** 2026-10-16
- **Outcome:** no task carries `shared_file_notes`; nothing in `lib/core/app` builds combat or dungeon. T088 and T106 build them in `test/integration/`.
- **Decisions:** no body registers a combatant and no run generates a zone yet; wiring comes with the first feature that drives them, as wave-03 left the kit unwired. T088 mocks `CollisionWorld`, a dungeon port, because no task may depend on another feature's tasks (rule 34).
- **Deviations:** none
- **Evidence:** rejected: wiring both into `SaviorsParadoxGame` now, shared-file changes nothing reads.
