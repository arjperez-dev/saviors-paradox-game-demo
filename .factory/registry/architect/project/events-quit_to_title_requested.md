---
factory_version: 4.3.0
---

# Contract events/quit_to_title_requested

- **Date:** 2026-10-14
- **Outcome:** `QuitToTitleRequested`, emitted by pause; consumed by home, save.
- **Decisions:** An immutable integration event raised after an aggregate's domain event (`architecture.md` §4).
- **Deviations:** none
- **Evidence:** rejected: direct calls between features.
