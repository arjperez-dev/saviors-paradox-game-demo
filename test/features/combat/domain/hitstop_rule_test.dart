import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/hitstop_rule.dart';

void main() {
  group('HitstopRule', () {
    const rule = HitstopRule();

    test('a hit on Akeris holds 0.06 s', () {
      for (final kind in AttackKind.values) {
        final hold = rule.onHit(target: CombatantSide.akeris, kind: kind);

        expect(hold, const Seconds(0.06)); // hit-feedback.md §2: Akeris is hit
      }
    });

    test('a melee hit on a foe holds 0.06 s', () {
      final hold = rule.onHit(
        target: CombatantSide.foe,
        kind: AttackKind.melee,
      );

      expect(
        hold,
        const Seconds(0.06),
      ); // hit-feedback.md §2: Akeris's melee hit lands
    });

    test('a chain hit on a foe holds 0.05 s', () {
      final hold = rule.onHit(
        target: CombatantSide.foe,
        kind: AttackKind.chain,
      );

      expect(
        hold,
        const Seconds(0.05),
      ); // hit-feedback.md §2: Akeris's chain strike lands
    });

    test('an unlisted hit holds 0.05 s', () {
      for (final kind in [
        AttackKind.projectile,
        AttackKind.ability,
        AttackKind.hazard,
        AttackKind.grab,
      ]) {
        final hold = rule.onHit(target: CombatantSide.foe, kind: kind);

        // operator, 2026-10-16: a hit hit-feedback.md §2 does not list.
        expect(hold, const Seconds(0.05));
      }

      final onNeutral = rule.onHit(
        target: CombatantSide.neutral,
        kind: AttackKind.projectile,
      );

      // operator, 2026-10-16: a hit hit-feedback.md §2 does not list.
      expect(onNeutral, const Seconds(0.05));
    });

    test('blocks, reflects and counters hold their own times', () {
      expect(
        HitstopRule.onBlock,
        const Seconds(0.05),
      ); // hit-feedback.md §2: blocked
      expect(
        HitstopRule.onReflect,
        const Seconds(0.07),
      ); // hit-feedback.md §2: perfect block, projectile
      expect(
        HitstopRule.onCounter,
        const Seconds(0.09),
      ); // hit-feedback.md §2; counter.md §1
      expect(
        HitstopRule.onReflectedHit,
        const Seconds(0.05),
      ); // hit-feedback.md §2: a reflected projectile hits its thrower
    });
  });
}
