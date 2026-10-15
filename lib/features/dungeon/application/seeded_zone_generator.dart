// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/ports/zone_generator.dart';
import 'package:saviors_paradox/core/contracts/state/zone_state.dart';

final class SeededZoneGenerator implements ZoneGenerator {
  @override
  ZoneState generate(ZoneNumber zone, Seed seed) => const ZoneState(
    zone: ZoneNumber.first,
    biome: Biome.suspendedSanctuary,
    seed: Seed(0),
    bounds: WorldBox(centre: Vec2.zero, halfWidth: 0, halfHeight: 0),
    rooms: [],
    spawns: [],
    altars: [],
    spirits: [],
    start: Vec2.zero,
    wayDown: Vec2.zero,
    bossRoom: EntityId(0),
    isBossRoomSealed: false,
  );
}
