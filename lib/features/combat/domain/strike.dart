import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';

/// One attack, as combat resolves it.
final class Strike {
  const Strike({
    required this.attacker,
    required this.side,
    required this.kind,
    required this.element,
    required this.area,
    required this.damage,
    required this.knockback,
    required this.isBlockable,
    required this.isLethal,
  });

  final EntityId attacker;
  final CombatantSide side;
  final AttackKind kind;
  final Element element;
  final WorldBox area;
  final Damage damage;
  final Vec2 knockback;
  final bool isBlockable;
  final bool isLethal;

  @override
  bool operator ==(Object other) =>
      other is Strike &&
      other.attacker == attacker &&
      other.side == side &&
      other.kind == kind &&
      other.element == element &&
      other.area == area &&
      other.damage == damage &&
      other.knockback == knockback &&
      other.isBlockable == isBlockable &&
      other.isLethal == isLethal;

  @override
  int get hashCode => Object.hash(
    attacker,
    side,
    kind,
    element,
    area,
    damage,
    knockback,
    isBlockable,
    isLethal,
  );
}
