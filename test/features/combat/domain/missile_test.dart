import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/flight_id.dart';
import 'package:saviors_paradox/features/combat/domain/missile.dart';

void main() {
  group('Missile', () {
    test('missiles are equal by every field', () {
      final a = Missile(
        thrower: const EntityId(1),
        side: CombatantSide.akeris,
        element: Element.fire,
        position: Vec2(1, 2),
        velocity: Vec2(3, 4),
        radius: 5,
        damage: const Damage(10),
        isReflectable: true,
      );
      final b = Missile(
        thrower: const EntityId(1),
        side: CombatantSide.akeris,
        element: Element.fire,
        position: Vec2(1, 2),
        velocity: Vec2(3, 4),
        radius: 5,
        damage: const Damage(10),
        isReflectable: true,
      );
      final c = Missile(
        thrower: EntityId(1),
        side: CombatantSide.akeris,
        element: Element.fire,
        position: Vec2(1, 2),
        velocity: Vec2(9, 9),
        radius: 5,
        damage: Damage(10),
        isReflectable: true,
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(c)));
    });

    test('a missile always has some size', () {
      expect(
        () => Missile(
          thrower: const EntityId(1),
          side: CombatantSide.akeris,
          element: Element.fire,
          position: Vec2.zero,
          velocity: Vec2.zero,
          radius: 0,
          damage: const Damage(10),
          isReflectable: true,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('FlightId', () {
    test('flight ids are equal by number', () {
      expect(const FlightId(3), equals(const FlightId(3)));
      expect(const FlightId(3), isNot(equals(const FlightId(4))));
    });
  });
}
