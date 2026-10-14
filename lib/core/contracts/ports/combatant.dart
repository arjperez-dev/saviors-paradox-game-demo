import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/raised_shield.dart';

abstract interface class Combatant {
  EntityId get id;

  CombatantSide get side;

  WorldBox get hurtbox;

  RaisedShield? get raisedShield;

  bool get isInvulnerable;

  bool isImmuneTo(Element element);
}
