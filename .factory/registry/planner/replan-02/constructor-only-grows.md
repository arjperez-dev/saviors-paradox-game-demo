---
factory_version: 4.3.0
---

# Loop constructors only grow, with defaults

- **Date:** 2026-10-15
- **Outcome:** `GameLoop` gains `interfaceSystems = const []` and `drain = _drainNothing`; `systems` keeps its name as the world systems; no `shared_file_notes`.
- **Decisions:** factory gap: `verify-task` runs the suite and the analyzer in the task worktree before the integrator applies `shared_file_notes`, so a signature change its callers in `lib/core/app/` or another module's tests must follow can never pass (operator confirmed, 2026-10-15). Worth a factory change.
- **Deviations:** none
- **Evidence:** rejected: renaming `systems` to `worldSystems` with a note for `saviors_paradox_game.dart`, which leaves `verify-task` red. T009's test runs unchanged under the probe.
