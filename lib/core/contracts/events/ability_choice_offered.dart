import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';
import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';

final class AbilityChoiceOffered extends WorldHalted {
  const AbilityChoiceOffered({
    required this.boss,
    required this.first,
    required this.second,
  }) : super(HaltCause.abilityChoice);

  final BossId boss;
  final AbilityId first;
  final AbilityId second;
}
