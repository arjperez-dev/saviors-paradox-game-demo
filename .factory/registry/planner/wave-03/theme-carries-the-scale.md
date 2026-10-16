---
factory_version: 4.3.0
---

# The ink theme carries the UI scale

- **Date:** 2026-10-16
- **Outcome:** InkTheme reads the screen height once (LayoutBuilder) and gives InkThemeData: the scale typed as the UiScale port, pixels(hu), lettering, colours and widths (T052).
- **Decisions:** ScreenUiScale stays the immutable implementation of UiScale (T051); hud and map call the port. The state caches the data per height, so a frame without a resize allocates nothing; updateShouldNotify compares the scale (operator, 2026-10-16).
- **Deviations:** none
- **Evidence:** rejected: a mutable ScreenUiScale with resize(), injected into every widget by core/app.
