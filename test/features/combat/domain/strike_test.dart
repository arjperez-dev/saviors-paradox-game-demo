import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

Strike _aStrike({Damage damage = const Damage(5), bool isBlockable = true}) =>
    Strike(
      attacker: const EntityId(1),
      side: CombatantSide.akeris,
      kind: AttackKind.melee,
      element: Element.plain,
      area: const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
      damage: damage,
      knockback: const Vec2(1, 0),
      isBlockable: isBlockable,
      isLethal: false,
    );

void main() {
  group('Strike', () {
    test('strikes are equal by every field', () {
      final a = _aStrike();
      final b = _aStrike();
      final differentDamage = _aStrike(damage: const Damage(1));
      final differentBlockable = _aStrike(isBlockable: false);

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(differentDamage)));
      expect(a, isNot(equals(differentBlockable)));
    });
  });
}
