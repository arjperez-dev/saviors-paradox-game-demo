# enemies

## What it is

The twenty normal enemies: kinds as flyweights, one brain strategy per kind, the `EnemyFactory` and the zone-scaled, elite and fire-infused decorators.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `events/enemy_defeated` | emits | `lib/features/enemies/application/step_enemy_brains.dart` |
| `events/sound_effect_cued` | emits | `lib/features/enemies/application/step_enemy_brains.dart` |
| `ports/combatant` | implements | `lib/features/enemies/application/enemy_combatant.dart` |
| `ports/run_memento_source` | implements | `lib/features/enemies/infrastructure/enemies_memento_source.dart` |
| `state/akeris_state` | consumes | — |
| `state/zone_state` | consumes | — |
| `events/noise_made` | consumes | — |
| `events/hit_landed` | consumes | — |
| `events/attack_blocked` | consumes | — |
| `events/counter_triggered` | consumes | — |
| `events/status_effect_applied` | consumes | — |
| `ports/attack_resolver` | consumes | — |
| `ports/combatant_registry` | consumes | — |
| `ports/collision_world` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/enemies/`, `test/features/enemies/`

## References

- `.factory/project/reference/03-characters/enemies/zone-1/shield-knight/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-1/shield-knight/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-1/shield-knight/captures/`
- `.factory/project/reference/03-characters/enemies/zone-1/shield-knight/weapons/`
- `.factory/project/reference/03-characters/enemies/zone-1/rune-sentinel/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-1/rune-sentinel/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-1/rune-sentinel/captures/`
- `.factory/project/reference/03-characters/enemies/zone-1/wandering-eye/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-1/wandering-eye/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-1/wandering-eye/captures/`
- `.factory/project/reference/03-characters/enemies/zone-1/mace-brute/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-1/mace-brute/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-1/mace-brute/captures/`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/enemies/zone-2/small-bats/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-2/small-bats/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-2/small-bats/captures/`
- `.factory/project/reference/03-characters/enemies/zone-2/blind-ghoul/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-2/blind-ghoul/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-2/blind-ghoul/captures/`
- `.factory/project/reference/03-characters/enemies/zone-2/ceiling-crawler/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-2/ceiling-crawler/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-2/ceiling-crawler/captures/`
- `.factory/project/reference/03-characters/enemies/zone-2/many-armed/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-2/many-armed/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-2/many-armed/captures/`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/enemies/zone-3/skeleton-archer/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-3/skeleton-archer/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-3/skeleton-archer/captures/`
- `.factory/project/reference/03-characters/enemies/zone-3/skeleton-archer/weapons/`
- `.factory/project/reference/03-characters/enemies/zone-3/gravedigger/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-3/gravedigger/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-3/gravedigger/captures/`
- `.factory/project/reference/03-characters/enemies/zone-3/gravedigger/weapons/`
- `.factory/project/reference/03-characters/enemies/zone-3/wraith/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-3/wraith/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-3/wraith/captures/`
- `.factory/project/reference/03-characters/enemies/zone-3/ossuary-many-armed/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-3/ossuary-many-armed/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-3/ossuary-many-armed/captures/`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/enemies/zone-4/spiderlings/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-4/spiderlings/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-4/spiderlings/captures/`
- `.factory/project/reference/03-characters/enemies/zone-4/spore-pod/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-4/spore-pod/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-4/spore-pod/captures/`
- `.factory/project/reference/03-characters/enemies/zone-4/strangler-vine/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-4/strangler-vine/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-4/strangler-vine/captures/`
- `.factory/project/reference/03-characters/enemies/zone-4/mantis/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-4/mantis/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-4/mantis/captures/`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/enemies/zone-5/drakeling/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-5/drakeling/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-5/drakeling/captures/`
- `.factory/project/reference/03-characters/enemies/zone-5/gargoyle/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-5/gargoyle/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-5/gargoyle/captures/`
- `.factory/project/reference/03-characters/enemies/zone-5/elite-shield-knight/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-5/elite-shield-knight/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-5/elite-shield-knight/captures/`
- `.factory/project/reference/03-characters/enemies/zone-5/fire-mace-brute/contract.md`
- `.factory/project/reference/03-characters/enemies/zone-5/fire-mace-brute/sprites/`
- `.factory/project/reference/03-characters/enemies/zone-5/fire-mace-brute/captures/`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`

## Not here

- The bosses: `bosses`.
- XP and coin drops on the floor: `run`.
