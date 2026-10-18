# akeris

## What it is

Akeris: movement, postures, health and the loadout his items decorate.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/akeris_state` | owns | `lib/features/akeris/application/step_akeris.dart` |
| `events/akeris_landed` | emits | `lib/features/akeris/application/step_akeris.dart` |
| `events/fast_descent_landed` | emits | `lib/features/akeris/application/step_akeris.dart` |
| `events/noise_made` | emits | `lib/features/akeris/application/step_akeris.dart` |
| `events/potion_drunk` | emits | `lib/features/akeris/application/step_akeris.dart` |
| `events/akeris_died` | emits | `lib/features/akeris/application/step_akeris.dart` |
| `events/sound_effect_cued` | emits | `lib/features/akeris/application/step_akeris.dart` |
| `ports/combatant` | implements | `lib/features/akeris/application/akeris_body_combatant.dart` |
| `ports/akeris_health` | implements | `lib/features/akeris/application/akeris_body_health.dart` |
| `ports/akeris_stagger` | implements | `lib/features/akeris/application/akeris_body_stagger.dart` |
| `ports/run_memento_source` | implements | `lib/features/akeris/infrastructure/akeris_memento_source.dart` |
| `events/player_command` | consumes | — |
| `ports/chain_blades` | consumes | — |
| `ports/loadout_modifier_source` | consumes | — |
| `ports/potion_supply` | consumes | — |
| `ports/revival_source` | consumes | — |
| `events/hit_landed` | consumes | — |
| `events/attack_blocked` | consumes | — |
| `events/counter_triggered` | consumes | — |
| `events/status_effect_applied` | consumes | — |
| `events/status_effect_ended` | consumes | — |
| `ports/status_effect_control` | consumes | — |
| `ports/combatant_registry` | consumes | — |
| `ports/attack_resolver` | consumes | — |
| `ports/collision_world` | consumes | — |
| `ports/zone_presence` | consumes | — |
| `ports/altars` | consumes | — |
| `events/zone_entered` | consumes | — |
| `state/zone_state` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/akeris/`, `test/features/akeris/`

## References

- `.factory/project/reference/03-characters/akeris/contract.md`
- `.factory/project/reference/03-characters/akeris/animations.md`
- `.factory/project/reference/03-characters/akeris/mechanics.md`
- `.factory/project/reference/03-characters/akeris/weapons/fire-shield.md`
- `.factory/project/reference/03-characters/akeris/weapons/flail.md`
- `.factory/project/reference/03-characters/akeris/weapons/hammer.md`
- `.factory/project/reference/03-characters/akeris/weapons/hook-blades-balance.md`
- `.factory/project/reference/03-characters/akeris/weapons/hook-blades.md`
- `.factory/project/reference/03-characters/akeris/weapons/ice-shield.md`
- `.factory/project/reference/03-characters/akeris/weapons/sacred-shield.md`
- `.factory/project/reference/03-characters/akeris/weapons/sacred-sword.md`
- `.factory/project/reference/03-characters/akeris/weapons/spear.md`
- `.factory/project/reference/03-characters/akeris/weapons/fire-shield-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/fire-shield.png`
- `.factory/project/reference/03-characters/akeris/weapons/flail-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/flail.png`
- `.factory/project/reference/03-characters/akeris/weapons/hammer-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/hammer.png`
- `.factory/project/reference/03-characters/akeris/weapons/hook-blade.png`
- `.factory/project/reference/03-characters/akeris/weapons/hook-blades-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/ice-shield-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/ice-shield.png`
- `.factory/project/reference/03-characters/akeris/weapons/sacred-shield-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/sacred-shield.png`
- `.factory/project/reference/03-characters/akeris/weapons/sacred-sword-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/sacred-sword.png`
- `.factory/project/reference/03-characters/akeris/weapons/spear-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/spear.png`
- `.factory/project/reference/03-characters/akeris/sprites/`
- `.factory/project/reference/03-characters/akeris/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/akeris/sandbox/anclar.png`
- `.factory/project/reference/03-characters/akeris/sandbox/arco.png`
- `.factory/project/reference/03-characters/akeris/sandbox/atraer.png`
- `.factory/project/reference/03-characters/akeris/sandbox/beber.png`
- `.factory/project/reference/03-characters/akeris/sandbox/cambio.png`
- `.factory/project/reference/03-characters/akeris/sandbox/colgadoContra.png`
- `.factory/project/reference/03-characters/akeris/sandbox/colgadoEscudo.png`
- `.factory/project/reference/03-characters/akeris/sandbox/colgadoHoja.png`
- `.factory/project/reference/03-characters/akeris/sandbox/colgadoLanzar.png`
- `.factory/project/reference/03-characters/akeris/sandbox/encima.png`
- `.factory/project/reference/03-characters/akeris/sandbox/giro.png`
- `.factory/project/reference/03-characters/akeris/sandbox/lanza.png`
- `.factory/project/reference/03-characters/akeris/sandbox/levitar.png`
- `.factory/project/reference/03-characters/akeris/sandbox/martillo.png`
- `.factory/project/reference/03-characters/akeris/sandbox/martilloEncima.png`
- `.factory/project/reference/03-characters/akeris/sandbox/mayal.png`
- `.factory/project/reference/03-characters/akeris/sandbox/morir.png`
- `.factory/project/reference/03-characters/akeris/sandbox/paredes.png`
- `.factory/project/reference/03-characters/akeris/sandbox/pirueta.png`
- `.factory/project/reference/03-characters/akeris/sandbox/rodarSalto.png`
- `.factory/project/reference/03-characters/akeris/sandbox/saltoAlto.png`
- `.factory/project/reference/03-characters/akeris/sandbox/saltoArgolla.png`

## Not here

- Weapons, shields and their levels: `arsenal`.
- Potions and scrolls: `inventory`.
- The chain's actions: `chain`.
