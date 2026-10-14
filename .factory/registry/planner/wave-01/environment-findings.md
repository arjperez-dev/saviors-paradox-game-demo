---
factory_version: 4.3.0
---

# Environment findings for the operator

- **Date:** 2026-10-14
- **Outcome:** three facts outside the plan that can stop a task.
- **Decisions:** the local Flutter is 3.47.5 / Dart 3.13.4 and the stack pins 3.47.7 / 3.13.5: upgrade before `tooling`. Long paths break CMake and flutter_soloud's build hooks (Windows MAX_PATH): keep worktrees short. `dart format` would change five architect files (`kernel/tile_coord`, `vec2`, `world_box`, `zone_number`, `cinematics/application/cinematic_director`), so wave 0 formats only its own files.
- **Deviations:** none
- **Evidence:** probed in the scratchpad: the native build passed only under a `subst` drive.
