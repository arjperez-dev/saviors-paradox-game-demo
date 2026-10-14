import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';

final class SatchelState {
  const SatchelState({
    required this.potions,
    required this.maxPotions,
    required this.curseKills,
    required this.curseTotal,
    required this.rageLeft,
  });

  final int potions;
  final int maxPotions;
  final int curseKills;
  final int curseTotal;
  final Seconds rageLeft;
}
