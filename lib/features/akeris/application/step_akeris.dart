// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';
import 'package:saviors_paradox/core/contracts/state/akeris_state.dart';
import 'package:saviors_paradox/core/contracts/state/posture_kind.dart';

final class StepAkeris {
  AkerisState get state => const AkerisState(
    position: Vec2.zero,
    velocity: Vec2.zero,
    facing: Facing.right,
    posture: PostureKind.standing,
    health: 0,
    maxHealth: 0,
    isInvulnerable: false,
    heldWeapon: WeaponId.sacredSword,
  );

  void step(Seconds dt) {}
}
