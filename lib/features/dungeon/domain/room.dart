part of 'zone.dart';

/// One room of a zone: an entity of [Zone], reached only through it.
final class Room {
  Room._({
    required EntityId id,
    required WorldBox bounds,
    required List<EntityId> neighbours,
    required bool isOnMainPath,
    required bool isBossRoom,
  }) : _id = id,
       _view = RoomView(
         room: id,
         bounds: bounds,
         neighbours: neighbours,
         isOnMainPath: isOnMainPath,
         isBossRoom: isBossRoom,
       );

  final EntityId _id;
  final RoomView _view;

  @override
  bool operator ==(Object other) => other is Room && other._id == _id;

  @override
  int get hashCode => _id.hashCode;
}
