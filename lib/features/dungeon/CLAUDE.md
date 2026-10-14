# dungeon

## What it is

The zone: generation from the run's seed (`BiomeKit`, `ZoneBuilder`, `ZoneValidator`), rooms, collision geometry, hook points, altars, the boss room's seal and stage, the spirits' places and the camera.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `state/zone_state` | owns | `lib/features/dungeon/application/step_zone.dart` |
| `events/zone_entered` | emits | `lib/features/dungeon/application/step_zone.dart` |
| `events/room_entered` | emits | `lib/features/dungeon/application/step_zone.dart` |
| `events/boss_room_entered` | emits | `lib/features/dungeon/application/step_zone.dart` |
| `events/way_down_reached` | emits | `lib/features/dungeon/application/step_zone.dart` |
| `events/item_taken` | emits | `lib/features/dungeon/application/step_zone.dart` |
| `events/sound_effect_cued` | emits | `lib/features/dungeon/application/step_zone.dart` |
| `ports/collision_world` | implements | `lib/features/dungeon/application/zone_collision_world.dart` |
| `ports/zone_generator` | implements | `lib/features/dungeon/application/seeded_zone_generator.dart` |
| `ports/boss_room_seal` | implements | `lib/features/dungeon/application/boss_room_doors.dart` |
| `ports/boss_room_stage` | implements | `lib/features/dungeon/application/boss_room_stage_elements.dart` |
| `ports/altars` | implements | `lib/features/dungeon/application/zone_altars.dart` |
| `ports/run_memento_source` | implements | `lib/features/dungeon/infrastructure/zone_memento_source.dart` |
| `events/player_command` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/dungeon/`, `test/features/dungeon/`

## References

- `.factory/project/reference/02-art-direction/dungeon/dungeon.md`
- `.factory/project/reference/02-art-direction/dungeon/dungeon.png`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/biome.md`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/layout.md`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/boss-room.md`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/sheet.png`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/rooms.png`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/layout.png`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-1-suspended-sanctuary/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/biome.md`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/layout.md`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/boss-room.md`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/sheet.png`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/rooms.png`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/layout.png`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-2-echo-caverns/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/biome.md`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/layout.md`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/boss-room.md`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/sheet.png`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/rooms.png`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/layout.png`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-3-sunken-graveyard/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/biome.md`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/layout.md`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/boss-room.md`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/sheet.png`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/rooms.png`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/layout.png`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-4-rotting-canopy/sandbox/captures/`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/biome.md`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/layout.md`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/boss-room.md`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/sheet.png`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/rooms.png`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/layout.png`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/sandbox/sandbox.html`
- `.factory/project/reference/04-zones/zone-5-dragon-battlements/sandbox/captures/`
- `.factory/project/reference/05-items/altar/`

## Not here

- Hazards that hurt or break: `hazards`.
- The map screen and the minimap: `map`.
- Enemies standing on the spawn points: `enemies`.
