---
factory_version: 4.3.0
---

# Modules

- **Date:** 2026-10-15
- **Outcome:** A fifth shared module, `ui` (`lib/core/ui/`, `test/core/ui/`): the interface kit; core/rendering implements `WorldCamera`.
- **Decisions:** Ten widgets: PaperSheet, InkFrame, KeyCap, KeyCapButton, HoldRing, MenuButton, FocusGroup, ConfirmQuestion, HintFooter, InkTheme (06-ui/ui.md §3; coding-standards §4.6, §11). `InputContext` is shared code in core/input; map and narrative implement theirs in `presentation/` (design-patterns §5); hud and audio consume the halt events their references need.
- **Deviations:** architecture §1, §2.2 revised for core/ui and design-patterns §5, §14 and checklist P8 for input contexts (operator, 1ea26e8). Glossary terms approved; ConfirmQuestion keeps *dialogue* the spirits' word. The font stays in core/rendering's `assets/fonts/`.
- **Evidence:** rejected: `InputContext` as a port with key types in `kernel/`; core/input holding every context's bindings.
