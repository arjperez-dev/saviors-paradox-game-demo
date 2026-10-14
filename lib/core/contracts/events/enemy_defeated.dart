import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/enemy_kind_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

final class EnemyDefeated implements GameEvent {
  const EnemyDefeated({
    required this.enemy,
    required this.kind,
    required this.zone,
    required this.at,
    required this.xp,
    required this.coins,
  });

  final EntityId enemy;
  final EnemyKindId kind;
  final ZoneNumber zone;
  final Vec2 at;
  final int xp;
  final int coins;
}
