import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';

Defender _aDefender({Guard? guard, Immunities immunities = Immunities.none}) =>
    Defender(
      id: const EntityId(1),
      side: CombatantSide.foe,
      hurtbox: const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
      guard: guard,
      isInvulnerable: false,
      immunities: immunities,
    );

void main() {
  group('Defender', () {
    test('defenders are equal by every field', () {
      final a = _aDefender();
      final b = _aDefender();
      final differentGuard = _aDefender(
        guard: Guard(shield: ShieldId.ice, raisedFor: const Seconds(0.1)),
      );
      final differentImmunities = _aDefender(
        immunities: const Immunities(toFire: true),
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(differentGuard)));
      expect(a, isNot(equals(differentImmunities)));
    });

    test('a defender is immune to nothing unless told', () {
      final defender = _aDefender();

      expect(defender.immunities, equals(Immunities.none));
    });
  });
}
