# loop

## What it is

The game loop and the event queue every feature publishes to. Each frame it reads Flame's `dt` and clamps it; has `core/input` drain the frame's commands into the queue and delivers them, whatever halts the world; steps the world systems in their order unless a world halt or a hitstop holds them; then steps the interface systems in their order, which never halt. It holds the set of `HaltCause`s that `WorldHalted` adds and `WorldResumed` removes; a repeated halt and an unmatched resume change nothing.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/event_sink` | implements | `lib/core/loop/application/event_queue.dart` |
| `ports/event_source` | implements | `lib/core/loop/application/event_queue.dart` |
| `ports/event_subscription` | implements | `lib/core/loop/application/event_queue.dart` |
| `events/hitstop_started` | consumes | — |
| `events/world_halted` | consumes | — |
| `events/world_resumed` | consumes | — |
| `events/halt_cause` | consumes | — |
| `kernel/seconds` | consumes | — |
| `events/game_event` | consumes | — |

## Roots

`lib/core/loop/`, `test/core/loop/`

## Not here

- The order of the systems in each step: the composition root in `lib/core/app/` wires it.
- What a key does: `core/input`.
- Any game rule: each belongs to the feature whose part of the game it is.
