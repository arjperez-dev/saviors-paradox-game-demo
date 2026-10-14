import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class TorchDropped implements GameEvent {
  const TorchDropped({
    required this.torch,
    required this.at,
  });

  final EntityId torch;
  final Vec2 at;
}
