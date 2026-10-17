import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_role.dart';

/// Where a spirit of the zone stands.
final class SpiritPlace {
  const SpiritPlace({
    required this.spirit,
    required this.role,
    required this.room,
    required this.position,
  });

  final EntityId spirit;
  final SpiritRole role;
  final EntityId room;
  final Vec2 position;

  @override
  bool operator ==(Object other) =>
      other is SpiritPlace &&
      other.spirit == spirit &&
      other.role == role &&
      other.room == room &&
      other.position == position;

  @override
  int get hashCode => Object.hash(spirit, role, room, position);
}
