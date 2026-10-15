---
factory_version: 4.3.0
---

# Contract events/dialogue_closed

- **Date:** 2026-10-15
- **Outcome:** `DialogueClosed` now extends `WorldResumed(HaltCause.dialogue)`; audio joins its consumers.
- **Decisions:** Pairs with `DialogueOpened`.
- **Deviations:** none
- **Evidence:** rejected: no cause on the resume.
