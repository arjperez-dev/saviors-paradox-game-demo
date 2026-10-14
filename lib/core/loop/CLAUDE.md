# loop

## What it is

The game loop: reads Flame's `dt`, clamps it and steps the systems in their order; the event queue every feature publishes to.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/event_sink` | implements | `lib/core/loop/application/event_queue.dart` |
| `ports/event_source` | implements | `lib/core/loop/application/event_queue.dart` |
| `events/hitstop_started` | consumes | — |
| `events/pause_opened` | consumes | — |
| `events/pause_closed` | consumes | — |
| `events/game_event` | consumes | — |

## Roots

`lib/core/loop/`, `test/core/loop/`

## Not here

- The order of the systems: the composition root in `lib/core/app/` wires it.
- Any game rule: each belongs to the feature whose part of the game it is.
