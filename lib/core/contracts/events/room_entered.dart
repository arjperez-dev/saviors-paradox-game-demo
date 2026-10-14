import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class RoomEntered implements GameEvent {
  const RoomEntered({
    required this.room,
  });

  final EntityId room;
}
