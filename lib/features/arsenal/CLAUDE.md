# arsenal

## What it is

Weapons and shields: the five slots, levels, uses, breaking and repairing, and the XP that pays for them.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/arsenal_state` | owns | `lib/features/arsenal/application/handle_arsenal_commands.dart` |
| `events/weapon_upgraded` | emits | `lib/features/arsenal/application/handle_arsenal_commands.dart` |
| `events/shield_broken` | emits | `lib/features/arsenal/application/handle_arsenal_commands.dart` |
| `events/shield_repair_requested` | emits | `lib/features/arsenal/application/handle_arsenal_commands.dart` |
| `events/shield_repaired` | emits | `lib/features/arsenal/application/handle_arsenal_commands.dart` |
| `ports/loadout_modifier_source` | implements | `lib/features/arsenal/application/arsenal_loadout_modifiers.dart` |
| `ports/xp_account` | implements | `lib/features/arsenal/application/arsenal_xp_account.dart` |
| `ports/shield_repairs` | implements | `lib/features/arsenal/application/arsenal_shield_repairs.dart` |
| `ports/run_memento_source` | implements | `lib/features/arsenal/infrastructure/arsenal_memento_source.dart` |
| `events/player_command` | consumes | — |
| `events/item_taken` | consumes | — |
| `events/attack_blocked` | consumes | — |
| `ports/akeris_stagger` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/arsenal/`, `test/features/arsenal/`

## References

- `.factory/project/reference/05-items/items.md`
- `.factory/project/reference/05-items/weapons/sacred-sword/`
- `.factory/project/reference/05-items/weapons/chain-blades/`
- `.factory/project/reference/05-items/weapons/spear/`
- `.factory/project/reference/05-items/weapons/flail/`
- `.factory/project/reference/05-items/weapons/hammer/`
- `.factory/project/reference/05-items/shields/sacred-shield/`
- `.factory/project/reference/05-items/shields/ice-shield/`
- `.factory/project/reference/05-items/shields/fire-shield/`
- `.factory/project/reference/05-items/sandbox/sandbox.html`
- `.factory/project/reference/05-items/sandbox/botin.png`
- `.factory/project/reference/05-items/sandbox/hud.png`
- `.factory/project/reference/05-items/sandbox/icons.png`
- `.factory/project/reference/05-items/sandbox/leer.png`
- `.factory/project/reference/05-items/sandbox/maldito.png`
- `.factory/project/reference/05-items/sandbox/recoger.png`
- `.factory/project/reference/05-items/sandbox/reparar.png`
- `.factory/project/reference/05-items/sandbox/roto.png`
- `.factory/project/reference/05-items/sandbox/sala.png`
- `.factory/project/reference/05-items/sandbox/sumar.png`
- `.factory/project/reference/05-items/sandbox/zona.png`
- `.factory/project/reference/03-characters/akeris/weapons/`

## Not here

- How Akeris swings a weapon: `akeris`.
- The curse a repair needs: `inventory`.
- The full inventory screen: `pause`.
