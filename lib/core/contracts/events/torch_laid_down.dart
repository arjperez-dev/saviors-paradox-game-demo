import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class TorchLaidDown implements GameEvent {
  const TorchLaidDown({
    required this.torch,
    required this.at,
  });

  final EntityId torch;
  final Vec2 at;
}
