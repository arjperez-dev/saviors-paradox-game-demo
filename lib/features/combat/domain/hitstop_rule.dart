import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';

/// How long the world holds still for each exchange (hit-feedback.md §2).
final class HitstopRule {
  const HitstopRule();

  // hit-feedback.md §2: blocked.
  static const Seconds onBlock = Seconds(0.05);

  // hit-feedback.md §2: perfect block, melee, sacred shield; counter.md §1.
  static const Seconds onCounter = Seconds(0.09);

  // hit-feedback.md §2: perfect block, projectile.
  static const Seconds onReflect = Seconds(0.07);

  // hit-feedback.md §2: a reflected projectile hits its thrower.
  static const Seconds onReflectedHit = Seconds(0.05);

  // hit-feedback.md §2: Akeris is hit.
  static const Seconds _onAkeris = Seconds(0.06);

  // hit-feedback.md §2: Akeris's melee hit lands.
  static const Seconds _onMelee = Seconds(0.06);

  // hit-feedback.md §2: Akeris's chain strike lands.
  static const Seconds _onChain = Seconds(0.05);

  // A hit hit-feedback.md §2 does not list: operator, 2026-10-16.
  static const Seconds _onOther = Seconds(0.05);

  /// The hold for a hit of [kind] landing on a body of [target]'s side.
  Seconds onHit({required CombatantSide target, required AttackKind kind}) {
    if (target == CombatantSide.akeris) {
      return _onAkeris;
    }
    return switch (kind) {
      AttackKind.melee => _onMelee,
      AttackKind.chain => _onChain,
      AttackKind.projectile ||
      AttackKind.ability ||
      AttackKind.hazard ||
      AttackKind.grab => _onOther,
    };
  }
}
