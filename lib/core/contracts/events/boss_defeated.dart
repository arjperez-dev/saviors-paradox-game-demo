import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class BossDefeated implements GameEvent {
  const BossDefeated({
    required this.boss,
    required this.at,
  });

  final BossId boss;
  final Vec2 at;
}
