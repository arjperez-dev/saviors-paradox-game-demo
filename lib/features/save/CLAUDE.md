# save

## What it is

The three save slots: the caretaker of the run's memento, autosave and manual save.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `ports/save_slots` | implements | `lib/features/save/infrastructure/json_save_slots.dart` |
| `ports/manual_save` | implements | `lib/features/save/application/save_run.dart` |
| `ports/run_memento_source` | consumes | — |
| `state/run_state` | consumes | — |
| `state/arsenal_state` | consumes | — |
| `events/run_ended` | consumes | — |
| `events/boss_room_entered` | consumes | — |
| `events/quit_to_title_requested` | consumes | — |

## Roots

`lib/features/save/`, `test/features/save/`

## References

- `.factory/project/reference/06-ui/save-slots/save-slots.md`

## Not here

- What a memento holds: each feature's `infrastructure/`.
- The slots screen: `home`.
