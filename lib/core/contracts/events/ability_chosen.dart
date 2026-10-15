import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_resumed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';

final class AbilityChosen extends WorldResumed {
  const AbilityChosen({
    required this.ability,
    required this.slotIndex,
  }) : super(HaltCause.abilityChoice);

  final AbilityId ability;
  final int slotIndex;
}
