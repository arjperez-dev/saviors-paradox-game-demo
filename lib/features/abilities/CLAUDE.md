# abilities

## What it is

The ten abilities as strategies, the three equipped slots and the choice after each boss.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/ability_set_state` | owns | `lib/features/abilities/application/step_ability_set.dart` |
| `events/ability_triggered` | emits | `lib/features/abilities/application/step_ability_set.dart` |
| `events/ability_choice_offered` | emits | `lib/features/abilities/application/step_ability_set.dart` |
| `events/ability_chosen` | emits | `lib/features/abilities/application/step_ability_set.dart` |
| `events/sound_effect_cued` | emits | `lib/features/abilities/application/step_ability_set.dart` |
| `ports/loadout_modifier_source` | implements | `lib/features/abilities/application/ability_loadout_modifiers.dart` |
| `ports/revival_source` | implements | `lib/features/abilities/application/reassemble_revival.dart` |
| `ports/combatant` | implements | `lib/features/abilities/application/summon_combatant.dart` |
| `ports/run_memento_source` | implements | `lib/features/abilities/infrastructure/ability_set_memento_source.dart` |
| `events/player_command` | consumes | — |
| `events/boss_defeated` | consumes | — |
| `state/akeris_state` | consumes | — |
| `events/fast_descent_landed` | consumes | — |
| `ports/attack_resolver` | consumes | — |
| `ports/status_effect_control` | consumes | — |
| `ports/combatant_registry` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/abilities/`, `test/features/abilities/`

## References

- `.factory/project/reference/03-characters/bosses/golem/contract.md`
- `.factory/project/reference/03-characters/bosses/golem/captures/`
- `.factory/project/reference/03-characters/bosses/golem/sprites/abilities.png`
- `.factory/project/reference/03-characters/bosses/giant-bat/contract.md`
- `.factory/project/reference/03-characters/bosses/giant-bat/captures/`
- `.factory/project/reference/03-characters/bosses/giant-bat/sprites/abilities.png`
- `.factory/project/reference/03-characters/bosses/skeleton/contract.md`
- `.factory/project/reference/03-characters/bosses/skeleton/captures/`
- `.factory/project/reference/03-characters/bosses/giant-spider/contract.md`
- `.factory/project/reference/03-characters/bosses/giant-spider/captures/`
- `.factory/project/reference/03-characters/bosses/giant-spider/sprites/abilities.png`
- `.factory/project/reference/03-characters/bosses/dragon/contract.md`
- `.factory/project/reference/03-characters/bosses/dragon/captures/`
- `.factory/project/reference/03-characters/bosses/dragon/sprites/abilities.png`

## Not here

- The bosses that drop them: `bosses`.
- Their slots on screen: `hud`.
