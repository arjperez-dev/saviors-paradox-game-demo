// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/run_state.dart';

final class StepRun {
  RunState get state => const RunState(
    seed: Seed(0),
    slot: 0,
    zone: ZoneNumber.first,
    coins: 0,
    enemiesDefeated: 0,
    timePlayed: Seconds.zero,
  );

  void step(Seconds dt) {}
}
