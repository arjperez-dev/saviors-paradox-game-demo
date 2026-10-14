# hazards

## What it is

What hurts, hinders or breaks in a zone: black water, open graves, poison pools, webs, rotten roots, cracked stalactites, tombstones, merlons and torches.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `events/hazard_broken` | emits | `lib/features/hazards/application/step_hazards.dart` |
| `events/torch_taken` | emits | `lib/features/hazards/application/step_hazards.dart` |
| `events/torch_laid_down` | emits | `lib/features/hazards/application/step_hazards.dart` |
| `events/torch_dropped` | emits | `lib/features/hazards/application/step_hazards.dart` |
| `events/sound_effect_cued` | emits | `lib/features/hazards/application/step_hazards.dart` |
| `ports/combatant` | implements | `lib/features/hazards/application/hazard_combatants.dart` |
| `ports/loadout_modifier_source` | implements | `lib/features/hazards/application/torch_in_hand.dart` |
| `ports/run_memento_source` | implements | `lib/features/hazards/infrastructure/hazards_memento_source.dart` |
| `state/akeris_state` | consumes | — |
| `state/zone_state` | consumes | — |
| `events/player_command` | consumes | — |
| `events/hit_landed` | consumes | — |
| `events/noise_made` | consumes | — |
| `ports/attack_resolver` | consumes | — |
| `ports/status_effect_control` | consumes | — |
| `ports/combatant_registry` | consumes | — |
| `ports/collision_world` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/hazards/`, `test/features/hazards/`

## References

- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/hazards.md`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/hazards.md`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/hazards.md`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/hazards.md`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/hazards.md`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/sandbox/captures/`

## Not here

- The abyss and chasm falls, which are geometry: `dungeon` answers `isAbyssAt`, `akeris` reacts.
- Vines and rings: hook points of `dungeon`.
