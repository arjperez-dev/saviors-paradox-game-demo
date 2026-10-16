---
factory_version: 4.3.0
---

# core/ui moves whole to wave 3

- **Date:** 2026-10-15
- **Outcome:** wave 2 carries rendering (T040–T043) and input (T044–T050); core/ui has no task this wave.
- **Decisions:** KeyCapButton hands its key to core/input (TranslateInput.receive, T048) and InkTheme takes the Patrick Hand family from core/rendering (Lettering, T041, bundle proven by T043); neither is on main, rule 31 forbids importing them, and depends_on_task cannot cross features (operator, 2026-10-15).
- **Deviations:** replan-02 left core/ui to wave-02; it is planned in wave 3 against both on main, InkTheme first.
- **Evidence:** rejected: a partial ui now (ScreenUiScale, FocusGroup, HoldRing, PaperSheet, InkFrame) whose InkTheme wave 3 rewrites.
