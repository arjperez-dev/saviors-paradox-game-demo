import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_role.dart';

final class SpiritSnapshot {
  const SpiritSnapshot({
    required this.spirit,
    required this.role,
    required this.room,
    required this.position,
  });

  final EntityId spirit;
  final SpiritRole role;
  final EntityId room;
  final Vec2 position;
}
