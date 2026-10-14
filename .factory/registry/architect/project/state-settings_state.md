---
factory_version: 4.3.0
---

# Contract state/settings_state

- **Date:** 2026-10-14
- **Outcome:** `SettingsState`, owned by settings; consumed by localization, audio, home.
- **Decisions:** A small read-only snapshot, built once per step (`architecture.md` §4, §6).
- **Deviations:** none
- **Evidence:** rejected: exposing the aggregate.
