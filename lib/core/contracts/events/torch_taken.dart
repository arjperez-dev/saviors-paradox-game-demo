import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class TorchTaken implements GameEvent {
  const TorchTaken({
    required this.torch,
  });

  final EntityId torch;
}
