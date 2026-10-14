# combat

## What it is

Hits, blocks, the perfect block, the counter, reflects, elements, damage, status effects, projectiles and hitstop.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `events/hit_landed` | emits | `lib/features/combat/application/step_engagements.dart` |
| `events/attack_blocked` | emits | `lib/features/combat/application/step_engagements.dart` |
| `events/counter_triggered` | emits | `lib/features/combat/application/step_engagements.dart` |
| `events/projectile_reflected` | emits | `lib/features/combat/application/step_engagements.dart` |
| `events/hitstop_started` | emits | `lib/features/combat/application/step_engagements.dart` |
| `events/sound_effect_cued` | emits | `lib/features/combat/application/step_engagements.dart` |
| `events/status_effect_applied` | emits | `lib/features/combat/application/step_status_effects.dart` |
| `events/status_effect_ended` | emits | `lib/features/combat/application/step_status_effects.dart` |
| `ports/combatant_registry` | implements | `lib/features/combat/application/combatant_roster.dart` |
| `ports/attack_resolver` | implements | `lib/features/combat/application/engagement_queue.dart` |
| `ports/status_effect_control` | implements | `lib/features/combat/application/body_status_effects.dart` |
| `ports/combatant` | consumes | — |
| `ports/collision_world` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/combat/`, `test/features/combat/`

## References

- `.factory/project/reference/02-art-direction/fx/hit-feedback/hit-feedback.md`
- `.factory/project/reference/02-art-direction/fx/hit-feedback/sprites/`
- `.factory/project/reference/02-art-direction/fx/callouts/callouts.md`
- `.factory/project/reference/02-art-direction/fx/callouts/sprites/`
- `.factory/project/reference/02-art-direction/fx/counter/counter.md`
- `.factory/project/reference/02-art-direction/fx/counter/sprites/`
- `.factory/project/reference/02-art-direction/fx/reflect/reflect.md`
- `.factory/project/reference/02-art-direction/fx/reflect/sprites/`
- `.factory/project/reference/02-art-direction/fx/elements/elements.md`
- `.factory/project/reference/02-art-direction/fx/elements/sprites/`
- `.factory/project/reference/02-art-direction/fx/freeze/freeze.md`
- `.factory/project/reference/02-art-direction/fx/freeze/sprites/`
- `.factory/project/reference/02-art-direction/fx/burn/burn.md`
- `.factory/project/reference/02-art-direction/fx/burn/sprites/`
- `.factory/project/reference/00-game/glossary.md`

## Not here

- Health and how a body reacts to a hit: the body's own feature (`akeris`, `enemies`, `bosses`, `hazards`).
- The shield's uses: `arsenal`.
