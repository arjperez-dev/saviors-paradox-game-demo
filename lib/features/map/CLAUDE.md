# map

## What it is

The zone map revealed as Akeris passes, the map screen and the minimap. It implements `core/input`'s `InputContext` in `presentation/`: W/A/S/D or the arrows held pan, a drag pans, the wheel and Q/E zoom, Enter centres on Akeris, M or Esc closes (`.factory/project/reference/06-ui/map/map.md` §5; `.factory/project/reference/08-engineering/design-patterns.md` §5).

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/run_memento_source` | implements | `lib/features/map/infrastructure/map_memento_source.dart` |
| `events/map_opened` | emits | `lib/features/map/application/map_screen_flow.dart` |
| `events/map_closed` | emits | `lib/features/map/application/map_screen_flow.dart` |
| `state/zone_state` | consumes | — |
| `state/akeris_state` | consumes | — |
| `events/room_entered` | consumes | — |
| `events/player_command` | consumes | — |
| `ports/ui_scale` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/map/`, `test/features/map/`

## References

- `.factory/project/reference/06-ui/map/`
- `.factory/project/reference/06-ui/sandbox/sandbox.html`

## Not here

- The zone itself: `dungeon`.
