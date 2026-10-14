import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';
import 'package:saviors_paradox/core/contracts/state/posture_kind.dart';

final class AkerisState {
  const AkerisState({
    required this.position,
    required this.velocity,
    required this.facing,
    required this.posture,
    required this.health,
    required this.maxHealth,
    required this.isInvulnerable,
    required this.heldWeapon,
  });

  final Vec2 position;
  final Vec2 velocity;
  final Facing facing;
  final PostureKind posture;
  final double health;
  final double maxHealth;
  final bool isInvulnerable;
  final WeaponId heldWeapon;
}
