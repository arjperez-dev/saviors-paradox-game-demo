# map

## What it is

The zone map revealed as Akeris passes, the map screen and the minimap.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/run_memento_source` | implements | `lib/features/map/infrastructure/map_memento_source.dart` |
| `state/zone_state` | consumes | — |
| `state/akeris_state` | consumes | — |
| `events/room_entered` | consumes | — |
| `events/player_command` | consumes | — |

## Roots

`lib/features/map/`, `test/features/map/`

## References

- `.factory/project/reference/06-ui/map/`
- `.factory/project/reference/06-ui/sandbox/sandbox.html`

## Not here

- The zone itself: `dungeon`.
