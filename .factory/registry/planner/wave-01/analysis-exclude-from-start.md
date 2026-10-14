---
factory_version: 4.3.0
---

# analysis_options carries pub get's exclude

- **Date:** 2026-10-14
- **Outcome:** T002 writes `analyzer: exclude: [build/**, windows/**]` from the start.
- **Decisions:** `flutter pub get` adds those lines itself (`windows/**` once `windows/` exists); written up front, no later `pub get`, the launcher's included, leaves the file changed in a worktree.
- **Deviations:** none
- **Evidence:** rejected: the bare file, rewritten by the first `pub get`. Probed: with the block written, `pub get` leaves the file unchanged.
