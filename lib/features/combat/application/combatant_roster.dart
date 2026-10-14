// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_registry.dart';

final class CombatantRoster implements CombatantRegistry {
  @override
  void register(Combatant combatant) {}

  @override
  void unregister(EntityId combatant) {}

  @override
  Iterable<Combatant> near(Vec2 point, double radius) => const [];

  @override
  Vec2? positionOf(EntityId combatant) => null;
}
