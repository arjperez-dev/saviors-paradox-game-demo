import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/altar_snapshot.dart';
import 'package:saviors_paradox/core/contracts/state/room_snapshot.dart';
import 'package:saviors_paradox/core/contracts/state/spawn_point.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_snapshot.dart';

final class ZoneState {
  const ZoneState({
    required this.zone,
    required this.biome,
    required this.seed,
    required this.rooms,
    required this.spawns,
    required this.altars,
    required this.spirits,
    required this.start,
    required this.wayDown,
    required this.bossRoom,
    required this.isBossRoomSealed,
  });

  final ZoneNumber zone;
  final Biome biome;
  final Seed seed;
  final List<RoomSnapshot> rooms;
  final List<SpawnPoint> spawns;
  final List<AltarSnapshot> altars;
  final List<SpiritSnapshot> spirits;
  final Vec2 start;
  final Vec2 wayDown;
  final EntityId bossRoom;
  final bool isBossRoomSealed;
}
