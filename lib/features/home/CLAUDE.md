# home

## What it is

The title screen, the save slots screen, the loading screen and the flow between screens.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/save_slots` | consumes | — |
| `ports/run_starter` | consumes | — |
| `ports/cinematic_player` | consumes | — |
| `events/quit_to_title_requested` | consumes | — |
| `events/run_ended` | consumes | — |
| `state/settings_state` | consumes | — |
| `events/player_command` | consumes | — |

## Roots

`lib/features/home/`, `test/features/home/`

## References

- `.factory/project/reference/06-ui/title/`
- `.factory/project/reference/06-ui/save-slots/`
- `.factory/project/reference/06-ui/loading/`
- `.factory/project/reference/06-ui/sandbox/sandbox.html`

## Not here

- Storing slots: `save`.
- The settings screen: `settings`.
- The death screen: `run`.
