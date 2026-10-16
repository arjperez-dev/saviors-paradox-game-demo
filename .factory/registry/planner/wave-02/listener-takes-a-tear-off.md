---
factory_version: 4.3.0
---

# InputListener takes a tear-off

- **Date:** 2026-10-15
- **Outcome:** InputListener({required ValueChanged<RawInput> onInput, required Widget child}); core/app passes game.input.receive (T049).
- **Decisions:** TranslateInput is a final class, which mocktail cannot implement outside its library; the tear-off keeps the widget testable and blind to TranslateInput. Mouse buttons are compared on every pointer event, since Flutter reports a second button as a move.
- **Deviations:** none
- **Evidence:** rejected: the widget taking TranslateInput, tested only through real contexts.
