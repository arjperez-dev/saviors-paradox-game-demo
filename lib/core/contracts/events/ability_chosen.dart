import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';

final class AbilityChosen implements GameEvent {
  const AbilityChosen({
    required this.ability,
    required this.slotIndex,
  });

  final AbilityId ability;
  final int slotIndex;
}
