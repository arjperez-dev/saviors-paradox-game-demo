import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';

/// What a zone shows of one of its rooms.
final class RoomView {
  RoomView({
    required this.room,
    required this.bounds,
    required List<EntityId> neighbours,
    required this.isOnMainPath,
    required this.isBossRoom,
  }) : neighbours = List.unmodifiable(neighbours);

  final EntityId room;
  final WorldBox bounds;
  final List<EntityId> neighbours;
  final bool isOnMainPath;
  final bool isBossRoom;

  @override
  bool operator ==(Object other) =>
      other is RoomView &&
      other.room == room &&
      other.bounds == bounds &&
      _sameIds(other.neighbours, neighbours) &&
      other.isOnMainPath == isOnMainPath &&
      other.isBossRoom == isBossRoom;

  @override
  int get hashCode => Object.hash(
    room,
    bounds,
    Object.hashAll(neighbours),
    isOnMainPath,
    isBossRoom,
  );
}

bool _sameIds(List<EntityId> a, List<EntityId> b) {
  if (a.length != b.length) {
    return false;
  }
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}
