# bosses

## What it is

The five bosses: bodies as a composite of parts, phases as state objects, and the stage changes of their rooms.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/boss_state` | owns | `lib/features/bosses/application/step_boss.dart` |
| `events/boss_woke` | emits | `lib/features/bosses/application/step_boss.dart` |
| `events/boss_phase_changed` | emits | `lib/features/bosses/application/step_boss.dart` |
| `events/boss_defeated` | emits | `lib/features/bosses/application/step_boss.dart` |
| `events/sound_effect_cued` | emits | `lib/features/bosses/application/step_boss.dart` |
| `ports/combatant` | implements | `lib/features/bosses/application/boss_part_combatant.dart` |
| `state/akeris_state` | consumes | — |
| `events/boss_room_entered` | consumes | — |
| `events/hit_landed` | consumes | — |
| `events/attack_blocked` | consumes | — |
| `ports/attack_resolver` | consumes | — |
| `ports/combatant_registry` | consumes | — |
| `ports/status_effect_control` | consumes | — |
| `ports/boss_room_stage` | consumes | — |
| `ports/collision_world` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/bosses/`, `test/features/bosses/`

## References

- `.factory/project/reference/03-characters/bosses/golem/contract.md`
- `.factory/project/reference/03-characters/bosses/golem/sprites/`
- `.factory/project/reference/03-characters/bosses/golem/captures/`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/bosses/giant-bat/contract.md`
- `.factory/project/reference/03-characters/bosses/giant-bat/sprites/`
- `.factory/project/reference/03-characters/bosses/giant-bat/captures/`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/bosses/skeleton/contract.md`
- `.factory/project/reference/03-characters/bosses/skeleton/sprites/`
- `.factory/project/reference/03-characters/bosses/skeleton/captures/`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/bosses/giant-spider/contract.md`
- `.factory/project/reference/03-characters/bosses/giant-spider/sprites/`
- `.factory/project/reference/03-characters/bosses/giant-spider/captures/`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`
- `.factory/project/reference/03-characters/bosses/dragon/contract.md`
- `.factory/project/reference/03-characters/bosses/dragon/sprites/`
- `.factory/project/reference/03-characters/bosses/dragon/captures/`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`

## Not here

- The boss bar: `hud`.
- The ability choice: `abilities`.
- Opening the room: `run`.
