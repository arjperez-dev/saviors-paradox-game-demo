import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';

final class AbilitySlotSnapshot {
  const AbilitySlotSnapshot({
    required this.slotIndex,
    required this.ability,
    required this.cooldownLeft,
  });

  final int slotIndex;
  final AbilityId? ability;
  final Seconds cooldownLeft;
}
