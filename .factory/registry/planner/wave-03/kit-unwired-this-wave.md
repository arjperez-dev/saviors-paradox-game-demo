---
factory_version: 4.3.0
---

# The kit is not wired this wave

- **Date:** 2026-10-16
- **Outcome:** no task carries shared_file_notes; nothing in lib/core/app builds InkTheme or ScreenUiScale.
- **Decisions:** no screen exists to draw the kit; its wiring (InkTheme at the root, KeyCapButton's onInput = TranslateInput.receive) comes with the first screen feature, as the camera waited in wave 2.
- **Deviations:** none
- **Evidence:** rejected: wrapping bootstrap.dart in InkTheme now, a shared-file change nothing reads.
