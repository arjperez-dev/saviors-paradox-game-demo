import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';

final class Attack {
  const Attack({
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
  final double damage;
  final Vec2 knockback;
  final bool isBlockable;
  final bool isLethal;
}
