import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';
import 'package:saviors_paradox/features/combat/application/combatant_roster.dart';

import '../mocks.dart';

MockCombatant _bodyAt(EntityId id, WorldBox hurtbox) {
  final combatant = MockCombatant();
  when(() => combatant.id).thenReturn(id);
  when(() => combatant.hurtbox).thenReturn(hurtbox);
  return combatant;
}

void main() {
  group('CombatantRoster', () {
    test('finds a registered body near a point', () {
      final roster = CombatantRoster();
      final body = _bodyAt(
        const EntityId(1),
        const WorldBox(centre: Vec2(30, 0), halfWidth: 10, halfHeight: 10),
      );
      roster.register(body);

      expect(roster.near(const Vec2(0, 0), 20), contains(body));
    });

    test('leaves out a body out of reach', () {
      final roster = CombatantRoster();
      final body = _bodyAt(
        const EntityId(1),
        const WorldBox(centre: Vec2(30, 0), halfWidth: 10, halfHeight: 10),
      );
      roster.register(body);

      expect(roster.near(const Vec2(0, 0), 19.9), isNot(contains(body)));
    });

    test('refills the same view on every call', () {
      final roster = CombatantRoster();
      final body = _bodyAt(
        const EntityId(1),
        const WorldBox(centre: Vec2(0, 0), halfWidth: 1, halfHeight: 1),
      );
      roster.register(body);

      final first = roster.near(const Vec2(0, 0), 10);
      final second = roster.near(const Vec2(1000, 1000), 10);

      expect(identical(first, second), isTrue);
      expect(second, isEmpty);
    });

    test('gives a view the caller cannot mutate', () {
      final roster = CombatantRoster();

      final view = roster.near(const Vec2(0, 0), 10) as List<Combatant>;

      final extra = _bodyAt(
        const EntityId(1),
        const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
      );

      expect(() => view.add(extra), throwsUnsupportedError);
    });

    group('with bodies 3 and 1 registered', () {
      late CombatantRoster roster;
      late MockCombatant bodyThree;
      late MockCombatant bodyOne;
      const hurtboxThree = WorldBox(
        centre: Vec2(0, 0),
        halfWidth: 1,
        halfHeight: 1,
      );
      const hurtboxOne = WorldBox(
        centre: Vec2(5, 0),
        halfWidth: 1,
        halfHeight: 1,
      );

      setUp(() {
        roster = CombatantRoster();
        bodyThree = _bodyAt(const EntityId(3), hurtboxThree);
        bodyOne = _bodyAt(const EntityId(1), hurtboxOne);
        roster.register(bodyThree);
        roster.register(bodyOne);
      });

      test('lists the bodies in the order they registered', () {
        final bodyTwo = _bodyAt(
          const EntityId(2),
          const WorldBox(centre: Vec2(-5, 0), halfWidth: 1, halfHeight: 1),
        );
        roster.register(bodyTwo);

        final ids = roster
            .near(const Vec2(0, 0), 10)
            .map((combatant) => combatant.id)
            .toList();

        expect(ids, [const EntityId(3), const EntityId(1), const EntityId(2)]);
      });

      test('forgets an unregistered body', () {
        roster.unregister(const EntityId(3));

        expect(
          roster.near(const Vec2(0, 0), 10),
          isNot(contains(bodyThree)),
        );
        expect(roster.byId(const EntityId(3)), isNull);
      });

      test('unregistering an unknown body changes nothing', () {
        roster.unregister(const EntityId(99));

        expect(
          roster.near(const Vec2(0, 0), 10),
          containsAll([bodyThree, bodyOne]),
        );
      });

      test('refuses a body registered twice', () {
        final duplicate = _bodyAt(const EntityId(3), hurtboxThree);

        expect(() => roster.register(duplicate), throwsStateError);
      });

      test("gives a body's position as its hurtbox centre", () {
        expect(roster.positionOf(const EntityId(3)), hurtboxThree.centre);
        expect(roster.positionOf(const EntityId(99)), isNull);
      });

      test('finds a body by its id', () {
        expect(roster.byId(const EntityId(1)), same(bodyOne));
      });
    });
  });
}
