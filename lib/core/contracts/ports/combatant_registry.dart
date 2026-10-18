import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';

abstract interface class CombatantRegistry {
  void register(Combatant combatant);

  void unregister(EntityId combatant);

  Iterable<Combatant> near(Vec2 point, double radius);

  Vec2? positionOf(EntityId combatant);

  Combatant? byId(EntityId combatant);
}
