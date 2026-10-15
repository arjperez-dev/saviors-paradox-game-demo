---
factory_version: 4.3.0
---

# Contract kernel/screen_vec2

- **Date:** 2026-10-15
- **Outcome:** `ScreenVec2`, a zero-cost extension type over `Vec2`: a point or displacement in logical pixels, y downward.
- **Decisions:** Three spaces with their own types (VISION §Target platform; ui.md §3; coding-standards §4.4, §11.7); arithmetic delegates to `Vec2`, one home (§4.6); `==` is the representation's.
- **Deviations:** Glossary *screen point* approved.
- **Evidence:** rejected: plain `Vec2` for screen points; a class copying `Vec2`'s arithmetic.
