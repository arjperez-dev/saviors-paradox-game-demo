# run

## What it is

The incursion as a process manager: zones in order, the boss room opened, the next zone or victory, death, coins, and the XP and coin drops.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/run_state` | owns | `lib/features/run/application/step_run.dart` |
| `events/run_started` | emits | `lib/features/run/application/step_run.dart` |
| `events/run_ended` | emits | `lib/features/run/application/step_run.dart` |
| `events/sound_effect_cued` | emits | `lib/features/run/application/step_run.dart` |
| `ports/run_starter` | implements | `lib/features/run/application/start_run.dart` |
| `ports/run_memento_source` | implements | `lib/features/run/infrastructure/run_progress_memento_source.dart` |
| `ports/zone_generator` | consumes | — |
| `ports/boss_room_seal` | consumes | — |
| `events/boss_defeated` | consumes | — |
| `events/ability_chosen` | consumes | — |
| `events/enemy_defeated` | consumes | — |
| `events/akeris_died` | consumes | — |
| `events/way_down_reached` | consumes | — |
| `state/arsenal_state` | consumes | — |
| `state/akeris_state` | consumes | — |
| `ports/xp_account` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/run/`, `test/features/run/`

## References

- `.factory/project/reference/05-items/drops/`
- `.factory/project/reference/06-ui/death/`

## Not here

- Saving the run: `save`.
- The outro: `cinematics`, started by `home`.
