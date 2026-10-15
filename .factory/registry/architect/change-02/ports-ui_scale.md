---
factory_version: 4.3.0
---

# Contract ports/ui_scale

- **Date:** 2026-10-15
- **Outcome:** `UiScale` (`toUi`, `toScreen`), implemented by core/ui (stub `screen_ui_scale.dart`); consumed by map and hud.
- **Decisions:** A pure scale by screen height ÷ `referenceHeight`, no offset (centring is layout); injected by core/app (coding-standards §11.7).
- **Deviations:** Glossary *UI scale* approved.
- **Evidence:** rejected: each widget reading `MediaQuery` and dividing by 1080.
