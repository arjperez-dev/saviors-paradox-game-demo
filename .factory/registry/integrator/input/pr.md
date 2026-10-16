---
factory_version: 4.3.0
---

# PR — input

- **Date:** 2026-10-15
- **Outcome:** `input: Turn the window's raw input into player commands through a stack of contexts`
- **Decisions:** The Scrutinise section names the context-stack release on a halt transition and PlayingContext's shared A/D tracking as the two places most worth a reviewer's own check, since both are behaviour the suite exercises but a reader cannot see from either task alone.
- **Deviations:** none
- **Evidence:**

```text
## Summary

Builds `lib/core/input/` end to end: `InputKey`, `PointerButton` and `RawInput` as the module's own
vocabulary, free of any Flutter type; the `InputContexts` stack holding the menu at the bottom,
playing while a run lasts, and one context per standing halt on top; `MenuContext` and
`PlayingContext` translating each mode's bindings into `PlayerCommand`s; and `TranslateInput`,
draining a frame's raw input through the active context and wired to the window through
`InputListener` in the composition root. It deliberately keeps Akeris's own airborne decision out of
input — S always publishes `Descend` regardless — and adds no halt-specific context beyond the stack
the loop feature already defined.

## Tasks

| id | title | type |
|---|---|---|
| T044 | Name the raw inputs the game reads | feat |
| T045 | Keep the stack of input contexts | feat |
| T046 | Translate the playing bindings into commands | feat |
| T047 | Translate the menu bindings into commands | feat |
| T048 | Drain the frame's raw input into commands | feat |
| T049 | Hand the window's raw input to core/input | feat |
| T050 | Test commands flowing from raw input through the loop | test |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- `flutter test`: All tests passed! (300 tests)
- Manual tests: none

## Scrutinise

- `TranslateInput` releases every held key and button through the outgoing context on each stack
  transition (T048); worth checking that a halt opened and resumed inside the same frame still
  releases cleanly rather than leaving a key held past the context that read it.
- `PlayingContext` tracks whichever of A/D is still held so releasing one hands movement to the
  other instead of stopping it (T046); worth confirming that ordering holds when the window delivers
  both the press and the release inside one drain.
```
