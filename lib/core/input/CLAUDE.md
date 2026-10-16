# input

## What it is

Keyboard and mouse turned into `PlayerCommand`s through a stack of `InputContext`s (`.factory/project/reference/08-engineering/design-patterns.md` §5). It declares `InputContext` and its own key and pointer types, and implements the playing context and the generic menu context; a feature with bindings of its own implements its context in its `presentation/`, and `lib/core/app/` registers it. The stack starts at the menu context; `RunStarted` pushes playing, and `RunEnded` or `QuitToTitleRequested` pops it; each `WorldHalted` pushes the context registered for its `HaltCause`, and the `WorldResumed` with that cause pops it. The loop reads it once per frame, before both steps, whatever halts the world; no feature reads it. A click while playing carries its world point, through `WorldCamera`, and `pointerStillFor`, the time since the pointer last moved, counted from the `dt` the loop hands it and infinite before it first moves.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `events/player_command` | emits | `lib/core/input/application/translate_input.dart` |
| `ports/event_sink` | consumes | — |
| `ports/event_source` | consumes | — |
| `ports/world_camera` | consumes | — |
| `events/world_halted` | consumes | — |
| `events/world_resumed` | consumes | — |
| `events/halt_cause` | consumes | — |
| `events/run_started` | consumes | — |
| `events/run_ended` | consumes | — |
| `events/quit_to_title_requested` | consumes | — |
| `kernel/screen_vec2` | consumes | — |
| `kernel/seconds` | consumes | — |

## Roots

`lib/core/input/`, `test/core/input/`

## References

- `.factory/project/reference/00-game/controls.md`
- `.factory/project/reference/06-ui/ui.md`
- `.factory/project/reference/06-ui/pause-menu/pause-menu.md`
- `.factory/project/reference/01-story/cinematics/intro.md`
- `.factory/project/reference/01-story/cinematics/outro.md`

## Not here

- What a command does: each feature's use cases.
- The map's and the dialogue's bindings: the `InputContext`s of `map` and `narrative`.
- Rebinding: a non-goal.
