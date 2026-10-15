# hud

## What it is

What is on screen while playing: portrait and health bar, XP and coins, the quick inventory, ability slots and the boss bar.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/akeris_state` | consumes | — |
| `state/arsenal_state` | consumes | — |
| `state/satchel_state` | consumes | — |
| `state/ability_set_state` | consumes | — |
| `state/boss_state` | consumes | — |
| `state/run_state` | consumes | — |
| `events/dialogue_opened` | consumes | — |
| `events/dialogue_closed` | consumes | — |
| `events/pause_opened` | consumes | — |
| `events/pause_closed` | consumes | — |
| `events/map_opened` | consumes | — |
| `events/map_closed` | consumes | — |
| `events/cinematic_started` | consumes | — |
| `events/cinematic_ended` | consumes | — |
| `ports/world_camera` | consumes | — |
| `ports/ui_scale` | consumes | — |

## Roots

`lib/features/hud/`, `test/features/hud/`

## References

- `.factory/project/reference/06-ui/hud/`
- `.factory/project/reference/06-ui/sandbox/sandbox.html`

## Not here

- The minimap: `map`.
- The pause menu: `pause`.
