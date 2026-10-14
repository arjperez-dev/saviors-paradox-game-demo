import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';

final class BossPhaseChanged implements GameEvent {
  const BossPhaseChanged({
    required this.boss,
    required this.phase,
  });

  final BossId boss;
  final int phase;
}
