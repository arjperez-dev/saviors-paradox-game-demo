import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/projectile.dart';
import 'package:saviors_paradox/core/contracts/ports/raised_shield.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/application/combatant_roster.dart';
import 'package:saviors_paradox/features/combat/application/engagement_queue.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/engagement.dart';
import 'package:saviors_paradox/features/combat/domain/engagement_event.dart';
import 'package:saviors_paradox/features/combat/domain/flights.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

import '../mocks.dart';

const _attack = Attack(
  attacker: EntityId(1),
  side: CombatantSide.foe,
  kind: AttackKind.melee,
  element: Element.plain,
  area: WorldBox(centre: Vec2(0, 0), halfWidth: 20, halfHeight: 20),
  damage: 10,
  knockback: Vec2.zero,
  isBlockable: true,
  isLethal: false,
);

MockCombatant _bodyAt(
  EntityId id, {
  required WorldBox hurtbox,
  CombatantSide side = CombatantSide.foe,
  RaisedShield? raisedShield,
  bool isImmuneToFire = false,
  bool isImmuneToIce = false,
}) {
  final combatant = MockCombatant();
  when(() => combatant.id).thenReturn(id);
  when(() => combatant.hurtbox).thenReturn(hurtbox);
  when(() => combatant.side).thenReturn(side);
  when(() => combatant.raisedShield).thenReturn(raisedShield);
  when(() => combatant.isInvulnerable).thenReturn(false);
  when(() => combatant.isImmuneTo(Element.fire)).thenReturn(isImmuneToFire);
  when(() => combatant.isImmuneTo(Element.ice)).thenReturn(isImmuneToIce);
  return combatant;
}

void main() {
  setUpAll(() {
    registerFallbackValue(
      Engagement(
        strike: const Strike(
          attacker: EntityId(0),
          side: CombatantSide.foe,
          kind: AttackKind.melee,
          element: Element.plain,
          area: WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
          damage: Damage.none,
          knockback: Vec2.zero,
          isBlockable: false,
          isLethal: false,
        ),
        defender: const Defender(
          id: EntityId(0),
          side: CombatantSide.akeris,
          hurtbox: WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
          guard: null,
          isInvulnerable: false,
        ),
      ),
    );
    registerFallbackValue(Flights());
  });

  group('EngagementQueue', () {
    late CombatantRoster roster;
    late MockEngagementRepository engagements;
    late MockFlightsRepository flights;
    late EngagementQueue queue;

    setUp(() {
      roster = CombatantRoster();
      engagements = MockEngagementRepository();
      flights = MockFlightsRepository();
      when(() => engagements.add(any())).thenReturn(null);
      queue = EngagementQueue(
        roster: roster,
        engagements: engagements,
        flights: flights,
      );
    });

    test('a strike queues one engagement per body in reach', () {
      roster
        ..register(
          _bodyAt(
            const EntityId(2),
            hurtbox: const WorldBox(
              centre: Vec2(30, 0),
              halfWidth: 10,
              halfHeight: 10,
            ),
          ),
        )
        ..register(
          _bodyAt(
            const EntityId(3),
            hurtbox: const WorldBox(
              centre: Vec2(-30, 0),
              halfWidth: 10,
              halfHeight: 10,
            ),
          ),
        )
        ..register(
          _bodyAt(
            const EntityId(4),
            hurtbox: const WorldBox(
              centre: Vec2(500, 0),
              halfWidth: 10,
              halfHeight: 10,
            ),
          ),
        );

      queue.strike(_attack);

      verify(() => engagements.add(any())).called(2);
    });

    test('a queued engagement resolves against the body struck', () {
      roster.register(
        _bodyAt(
          const EntityId(2),
          side: CombatantSide.akeris,
          hurtbox: const WorldBox(
            centre: Vec2(25, 0),
            halfWidth: 10,
            halfHeight: 10,
          ),
        ),
      );

      queue.strike(_attack);

      final captured =
          verify(() => engagements.add(captureAny())).captured.single
              as Engagement;
      expect(
        captured.resolve(),
        isA<StrikeLanded>().having(
          (e) => e.target,
          'target',
          const EntityId(2),
        ),
      );
    });

    test("a strike reads the attacker's immunities", () {
      roster
        ..register(
          _bodyAt(
            const EntityId(1),
            hurtbox: const WorldBox(
              centre: Vec2(1000, 0),
              halfWidth: 1,
              halfHeight: 1,
            ),
            isImmuneToIce: true,
          ),
        )
        ..register(
          _bodyAt(
            const EntityId(2),
            side: CombatantSide.akeris,
            hurtbox: const WorldBox(
              centre: Vec2(25, 0),
              halfWidth: 10,
              halfHeight: 10,
            ),
            raisedShield: const RaisedShield(
              shield: ShieldId.ice,
              raisedFor: Seconds(0.1),
            ),
          ),
        );

      queue.strike(_attack);

      final captured =
          verify(() => engagements.add(captureAny())).captured.single
              as Engagement;
      expect(
        captured.resolve(),
        isA<StrikeBlocked>().having(
          (e) => e.affliction?.kind,
          'affliction kind',
          StatusEffectKind.slowed,
        ),
      );
    });

    test('a strike reaching nobody queues nothing', () {
      queue.strike(_attack);

      verifyNever(() => engagements.add(any()));
    });

    test('a launch puts the projectile in the air', () {
      final loaded = Flights();
      when(() => flights.load()).thenReturn(loaded);
      when(() => flights.save(any())).thenReturn(null);
      const projectile = Projectile(
        thrower: EntityId(1),
        side: CombatantSide.foe,
        element: Element.plain,
        position: Vec2.zero,
        velocity: Vec2(100, 0),
        radius: 5,
        damage: 10,
        isReflectable: true,
      );

      queue.launch(projectile);

      expect(loaded.flyingCount, 1);
      verify(() => flights.save(loaded)).called(1);
    });
  });
}
