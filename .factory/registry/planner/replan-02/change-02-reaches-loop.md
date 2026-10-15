---
factory_version: 4.3.0
---

# Change-02 reaches the integrated loop only

- **Date:** 2026-10-15
- **Outcome:** four new loop tasks T034–T037; no task rewritten or dropped, no blocked task.
- **Decisions:** T005–T009 are integrated (§8.1), so new tasks carry the fix: the loop heard only `PauseOpened`/`PauseClosed` as one flag (an unmatched resume freed the world), had one step and no command drain. Input, `FollowCamera`, `core/ui` and the lettering (font added, 40b9e2d) are new work, left to wave-02.
- **Deviations:** the integrated rendering and localization code needs no change for change-02 (k = 1; strokes and palette now match the sandbox).
- **Evidence:** rejected: planning the new shared modules here, outside what the finding reaches. No `task/` branch is reused or discarded: none exists.
