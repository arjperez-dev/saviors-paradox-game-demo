import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';

final class HitLanded implements GameEvent {
  const HitLanded({
    required this.attacker,
    required this.target,
    required this.kind,
    required this.element,
    required this.damage,
    required this.knockback,
    required this.at,
    required this.isLethal,
  });

  final EntityId attacker;
  final EntityId target;
  final AttackKind kind;
  final Element element;
  final double damage;
  final Vec2 knockback;
  final Vec2 at;
  final bool isLethal;
}
