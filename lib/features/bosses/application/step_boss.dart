// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/state/boss_state.dart';

final class StepBoss {
  BossState get state => const BossState(
    boss: BossId.golem,
    isAwake: false,
    health: 0,
    maxHealth: 0,
    phase: 0,
  );

  void step(Seconds dt) {}
}
