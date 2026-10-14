# pause

## What it is

The pause menu and the full inventory; it issues commands and owns no rule of what they do.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `events/pause_opened` | emits | `lib/features/pause/application/pause_menu_flow.dart` |
| `events/pause_closed` | emits | `lib/features/pause/application/pause_menu_flow.dart` |
| `events/quit_to_title_requested` | emits | `lib/features/pause/application/pause_menu_flow.dart` |
| `events/player_command` | emits | `lib/features/pause/application/pause_menu_flow.dart` |
| `state/akeris_state` | consumes | — |
| `state/arsenal_state` | consumes | — |
| `state/satchel_state` | consumes | — |
| `state/ability_set_state` | consumes | — |
| `ports/manual_save` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/pause/`, `test/features/pause/`

## References

- `.factory/project/reference/06-ui/pause-menu/`
- `.factory/project/reference/06-ui/sandbox/sandbox.html`

## Not here

- Upgrades and repairs: `arsenal`.
- Quitting to the title: `home`.
