import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/hit_landed.dart';
import 'package:saviors_paradox/core/contracts/events/projectile_reflected.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_hit.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/raised_shield.dart';
import 'package:saviors_paradox/features/combat/application/combatant_roster.dart';
import 'package:saviors_paradox/features/combat/application/report_exchange.dart';
import 'package:saviors_paradox/features/combat/application/step_flights.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/flights.dart';
import 'package:saviors_paradox/features/combat/domain/missile.dart';

import '../mocks.dart';

class _FakeGameEvent extends Fake implements GameEvent {}

final _missile = Missile(
  thrower: const EntityId(1),
  side: CombatantSide.foe,
  element: Element.plain,
  position: Vec2.zero,
  velocity: const Vec2(600, 0),
  radius: 10,
  damage: const Damage(8),
  isReflectable: true,
);

MockCombatant _bodyAt(
  EntityId id,
  CombatantSide side,
  WorldBox hurtbox, {
  RaisedShield? shield,
}) {
  final combatant = MockCombatant();
  when(() => combatant.id).thenReturn(id);
  when(() => combatant.side).thenReturn(side);
  when(() => combatant.hurtbox).thenReturn(hurtbox);
  when(() => combatant.raisedShield).thenReturn(shield);
  when(() => combatant.isInvulnerable).thenReturn(false);
  when(() => combatant.isImmuneTo(any())).thenReturn(false);
  return combatant;
}

void main() {
  setUpAll(() {
    registerFallbackValue(Vec2.zero);
    registerFallbackValue(_FakeGameEvent());
    registerFallbackValue(Element.plain);
  });

  group('StepFlights', () {
    late Flights flights;
    late CombatantRoster roster;
    late MockCollisionWorld world;
    late MockEventSink events;
    late List<GameEvent> published;
    late StepFlights system;

    setUp(() {
      flights = Flights();
      roster = CombatantRoster();
      world = MockCollisionWorld();
      when(() => world.cast(any(), any())).thenReturn(null);
      events = MockEventSink();
      published = [];
      when(() => events.publish(any())).thenAnswer(
        (invocation) =>
            published.add(invocation.positionalArguments.first as GameEvent),
      );
      final report = ReportExchange(events, MockStatusEffectControl());
      final mockFlights = MockFlightsRepository();
      when(() => mockFlights.load()).thenReturn(flights);
      system = StepFlights(
        flights: mockFlights,
        roster: roster,
        world: world,
        report: report,
      );
    });

    test('a flight that meets the world crashes', () {
      when(() => world.cast(any(), any())).thenReturn(
        const CollisionHit(
          point: Vec2(60, 0),
          normal: Vec2(0, -1),
          fraction: 1,
        ),
      );
      flights.launch(_missile);

      system.step(const Seconds(0.1));

      expect(flights.flyingCount, 0);
      expect(published.whereType<HitLanded>(), isEmpty);
    });

    test('a flight reaches the body in its way', () {
      roster.register(
        _bodyAt(
          const EntityId(2),
          CombatantSide.akeris,
          const WorldBox(centre: Vec2(60, 0), halfWidth: 20, halfHeight: 40),
        ),
      );
      flights.launch(_missile);

      system.step(const Seconds(0.1));

      final hit = published.whereType<HitLanded>().single;
      expect(hit.target, const EntityId(2));
      expect(hit.kind, AttackKind.projectile);
      expect(hit.damage, 8);
    });

    test('a flight offers each body in roster order until one answers', () {
      roster.register(
        _bodyAt(
          const EntityId(5),
          CombatantSide.foe,
          const WorldBox(centre: Vec2(60, 0), halfWidth: 20, halfHeight: 40),
        ),
      );
      roster.register(
        _bodyAt(
          const EntityId(2),
          CombatantSide.akeris,
          const WorldBox(centre: Vec2(60, 0), halfWidth: 20, halfHeight: 40),
        ),
      );
      flights.launch(_missile);

      system.step(const Seconds(0.1));

      final hit = published.whereType<HitLanded>().single;
      expect(hit.target, const EntityId(2));
    });

    test('a flight in empty air flies on', () {
      final id = flights.launch(_missile);

      system.step(const Seconds(0.1));

      expect(published, isEmpty);
      expect(flights.flyingCount, 1);
      expect(flights.trackOf(id).to, const Vec2(60, 0));
    });

    test('a perfect block sends a flight back toward its thrower', () {
      roster.register(
        _bodyAt(
          const EntityId(1),
          CombatantSide.foe,
          const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
        ),
      );
      roster.register(
        _bodyAt(
          const EntityId(2),
          CombatantSide.akeris,
          const WorldBox(centre: Vec2(60, 0), halfWidth: 20, halfHeight: 40),
          shield: const RaisedShield(
            shield: ShieldId.sacred,
            raisedFor: Seconds(0.1),
          ),
        ),
      );
      final id = flights.launch(_missile);

      system.step(const Seconds(0.1));

      expect(published.whereType<ProjectileReflected>(), hasLength(1));

      system.step(const Seconds(0.01));

      final track = flights.trackOf(id);
      expect(track.from, const Vec2(60, 0));
      expect(track.to, const Vec2(50.4, 0));
    });

    test('a flight ends after four seconds in the air', () {
      flights.launch(_missile);

      for (var i = 0; i < 4; i++) {
        system.step(const Seconds(1));
      }

      expect(flights.flyingCount, 0);
    });
  });
}
