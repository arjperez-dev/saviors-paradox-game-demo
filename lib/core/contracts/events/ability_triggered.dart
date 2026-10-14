import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class AbilityTriggered implements GameEvent {
  const AbilityTriggered({
    required this.ability,
    required this.at,
  });

  final AbilityId ability;
  final Vec2 at;
}
