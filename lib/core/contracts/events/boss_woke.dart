import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';

final class BossWoke implements GameEvent {
  const BossWoke({
    required this.boss,
  });

  final BossId boss;
}
