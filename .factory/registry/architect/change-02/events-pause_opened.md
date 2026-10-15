---
factory_version: 4.3.0
---

# Contract events/pause_opened

- **Date:** 2026-10-15
- **Outcome:** `PauseOpened` now extends `WorldHalted(HaltCause.pauseMenu)`; hud joins its consumers.
- **Decisions:** The pause menu hides the HUD (06-ui/pause-menu §2, hud §2).
- **Deviations:** Earlier, hud did not hear it.
- **Evidence:** rejected: hud reading the loop's halt set, which is not a contract.
