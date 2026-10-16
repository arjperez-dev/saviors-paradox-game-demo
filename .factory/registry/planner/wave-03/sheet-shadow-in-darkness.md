---
factory_version: 4.3.0
---

# The sheet's shadow is darkness

- **Date:** 2026-10-16
- **Outcome:** InkThemeData.sheetShadowColour is rgba(14,11,9,.55), blur sigma 17 (T052, T057).
- **Decisions:** the 06-ui sandbox's sheetAt shadows in rgba(0,0,0,.55); pure black is not in palette.md, which allows no colour outside it. Reference defect for the operator (operator chose darkness, 2026-10-16).
- **Deviations:** none
- **Evidence:** rejected: the sandbox's black, which needs palette.md changed first.
