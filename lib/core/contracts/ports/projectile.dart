import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';

final class Projectile {
  const Projectile({
    required this.thrower,
    required this.side,
    required this.element,
    required this.position,
    required this.velocity,
    required this.radius,
    required this.damage,
    required this.isReflectable,
  });

  final EntityId thrower;
  final CombatantSide side;
  final Element element;
  final Vec2 position;
  final Vec2 velocity;
  final double radius;
  final double damage;
  final bool isReflectable;
}
