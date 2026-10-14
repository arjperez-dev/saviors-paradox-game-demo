import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class CounterTriggered implements GameEvent {
  const CounterTriggered({
    required this.defender,
    required this.attacker,
  });

  final EntityId defender;
  final EntityId attacker;
}
