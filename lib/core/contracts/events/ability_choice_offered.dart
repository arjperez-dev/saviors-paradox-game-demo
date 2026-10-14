import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/ability_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';

final class AbilityChoiceOffered implements GameEvent {
  const AbilityChoiceOffered({
    required this.boss,
    required this.first,
    required this.second,
  });

  final BossId boss;
  final AbilityId first;
  final AbilityId second;
}
