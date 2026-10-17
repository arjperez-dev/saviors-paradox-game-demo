import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';

/// A body as an exchange meets it.
final class Defender {
  const Defender({
    required this.id,
    required this.side,
    required this.hurtbox,
    required this.guard,
    required this.isInvulnerable,
    this.immunities = Immunities.none,
  });

  final EntityId id;
  final CombatantSide side;
  final WorldBox hurtbox;
  final Guard? guard;
  final bool isInvulnerable;
  final Immunities immunities;

  @override
  bool operator ==(Object other) =>
      other is Defender &&
      other.id == id &&
      other.side == side &&
      other.hurtbox == hurtbox &&
      other.guard == guard &&
      other.isInvulnerable == isInvulnerable &&
      other.immunities == immunities;

  @override
  int get hashCode =>
      Object.hash(id, side, hurtbox, guard, isInvulnerable, immunities);
}
