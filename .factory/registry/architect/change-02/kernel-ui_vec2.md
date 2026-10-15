---
factory_version: 4.3.0
---

# Contract kernel/ui_vec2

- **Date:** 2026-10-15
- **Outcome:** `UiVec2`, a zero-cost extension type over `Vec2` in hu; the only home of `referenceWidth` 1920 and `referenceHeight` 1080.
- **Decisions:** The UI frame is 1920×1080 scaled by screen height ÷ 1080; on wider screens only the background grows (06-ui/ui.md §3).
- **Deviations:** Glossary *UI point*, *hu* approved.
- **Evidence:** rejected: the reference frame as constants in core/ui.
