// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/state/satchel_state.dart';

final class StepSatchel {
  SatchelState get state => const SatchelState(
    potions: 0,
    maxPotions: 0,
    curseKills: 0,
    curseTotal: 0,
    rageLeft: Seconds.zero,
  );

  void step(Seconds dt) {}
}
