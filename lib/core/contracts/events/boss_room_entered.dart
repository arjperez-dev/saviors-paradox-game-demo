import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';

final class BossRoomEntered implements GameEvent {
  const BossRoomEntered({
    required this.boss,
  });

  final BossId boss;
}
