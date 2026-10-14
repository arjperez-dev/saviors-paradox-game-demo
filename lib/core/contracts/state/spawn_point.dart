import 'package:saviors_paradox/core/contracts/kernel/enemy_kind_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class SpawnPoint {
  const SpawnPoint({
    required this.room,
    required this.position,
    required this.kind,
  });

  final EntityId room;
  final Vec2 position;
  final EnemyKindId kind;
}
