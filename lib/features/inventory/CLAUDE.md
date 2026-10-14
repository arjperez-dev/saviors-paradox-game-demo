# inventory

## What it is

The satchel: potions, scrolls read at once, curses that add up and the rage they grant.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/satchel_state` | owns | `lib/features/inventory/application/step_satchel.dart` |
| `events/scroll_read` | emits | `lib/features/inventory/application/step_satchel.dart` |
| `events/curse_started` | emits | `lib/features/inventory/application/step_satchel.dart` |
| `events/curse_progressed` | emits | `lib/features/inventory/application/step_satchel.dart` |
| `events/curse_fulfilled` | emits | `lib/features/inventory/application/step_satchel.dart` |
| `events/rage_started` | emits | `lib/features/inventory/application/step_satchel.dart` |
| `events/rage_ended` | emits | `lib/features/inventory/application/step_satchel.dart` |
| `events/sound_effect_cued` | emits | `lib/features/inventory/application/step_satchel.dart` |
| `ports/loadout_modifier_source` | implements | `lib/features/inventory/application/satchel_loadout_modifiers.dart` |
| `ports/potion_supply` | implements | `lib/features/inventory/application/satchel_potion_supply.dart` |
| `ports/run_memento_source` | implements | `lib/features/inventory/infrastructure/satchel_memento_source.dart` |
| `events/potion_drunk` | consumes | — |
| `events/item_taken` | consumes | — |
| `events/enemy_defeated` | consumes | — |
| `events/hit_landed` | consumes | — |
| `events/zone_entered` | consumes | — |
| `events/shield_repair_requested` | consumes | — |
| `ports/shield_repairs` | consumes | — |
| `ports/akeris_health` | consumes | — |
| `ports/altars` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/inventory/`, `test/features/inventory/`

## References

- `.factory/project/reference/05-items/items.md`
- `.factory/project/reference/05-items/potion/`
- `.factory/project/reference/05-items/scrolls/`
- `.factory/project/reference/05-items/sandbox/sandbox.html`

## Not here

- Weapons and shields: `arsenal`.
- Drinking as a posture: `akeris`.
