// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/raised_shield.dart';

final class EnemyCombatant implements Combatant {
  @override
  EntityId get id => const EntityId(0);

  @override
  CombatantSide get side => CombatantSide.neutral;

  @override
  WorldBox get hurtbox =>
      const WorldBox(centre: Vec2.zero, halfWidth: 0, halfHeight: 0);

  @override
  RaisedShield? get raisedShield => null;

  @override
  bool get isInvulnerable => false;

  @override
  bool isImmuneTo(Element element) => false;
}
