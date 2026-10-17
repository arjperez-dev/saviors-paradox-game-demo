import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';

/// A projectile as it leaves its thrower.
final class Missile {
  const Missile({
    required this.thrower,
    required this.side,
    required this.element,
    required this.position,
    required this.velocity,
    required this.radius,
    required this.damage,
    required this.isReflectable,
  }) : assert(radius > 0, 'a projectile has some size');

  final EntityId thrower;
  final CombatantSide side;
  final Element element;
  final Vec2 position;
  final Vec2 velocity;
  final double radius;
  final Damage damage;
  final bool isReflectable;

  @override
  bool operator ==(Object other) =>
      other is Missile &&
      other.thrower == thrower &&
      other.side == side &&
      other.element == element &&
      other.position == position &&
      other.velocity == velocity &&
      other.radius == radius &&
      other.damage == damage &&
      other.isReflectable == isReflectable;

  @override
  int get hashCode => Object.hash(
    thrower,
    side,
    element,
    position,
    velocity,
    radius,
    damage,
    isReflectable,
  );
}
