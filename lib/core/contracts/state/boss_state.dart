import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';

final class BossState {
  const BossState({
    required this.boss,
    required this.isAwake,
    required this.health,
    required this.maxHealth,
    required this.phase,
  });

  final BossId boss;
  final bool isAwake;
  final double health;
  final double maxHealth;
  final int phase;
}
