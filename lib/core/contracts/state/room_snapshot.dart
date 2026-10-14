import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';

final class RoomSnapshot {
  const RoomSnapshot({
    required this.room,
    required this.bounds,
    required this.neighbours,
    required this.isOnMainPath,
    required this.isBossRoom,
  });

  final EntityId room;
  final WorldBox bounds;
  final List<EntityId> neighbours;
  final bool isOnMainPath;
  final bool isBossRoom;
}
