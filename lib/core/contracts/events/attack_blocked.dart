import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';

final class AttackBlocked implements GameEvent {
  const AttackBlocked({
    required this.attacker,
    required this.defender,
    required this.kind,
    required this.element,
    required this.shield,
    required this.isPerfect,
    required this.at,
  });

  final EntityId attacker;
  final EntityId defender;
  final AttackKind kind;
  final Element element;
  final ShieldId shield;
  final bool isPerfect;
  final Vec2 at;
}
