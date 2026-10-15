---
factory_version: 4.3.0
---

# The command drain is a tear-off

- **Date:** 2026-10-15
- **Outcome:** `typedef CommandDrain = void Function(EventSink events, Seconds dt)` in `game_loop.dart`.
- **Decisions:** the shape of the architect's `TranslateInput.drainInto` stub, handed over like `SystemStep`; `loop` imports nothing of `core/input`, which is not built (rule 31). Wave-02's input task wires `drainInto` in `core/app` (operator, 2026-10-15).
- **Deviations:** none
- **Evidence:** rejected: `GameLoop` taking a `TranslateInput`, an edge from loop to input.
