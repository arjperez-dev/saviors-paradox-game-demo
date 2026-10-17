import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/attack_blocked.dart';
import 'package:saviors_paradox/core/contracts/events/counter_triggered.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/hit_landed.dart';
import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/projectile_reflected.dart';
import 'package:saviors_paradox/core/contracts/events/status_effect_applied.dart';
import 'package:saviors_paradox/core/contracts/events/status_effect_ended.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_world.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/projectile.dart';
import 'package:saviors_paradox/core/contracts/ports/raised_shield.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/features/combat/application/body_status_effects.dart';
import 'package:saviors_paradox/features/combat/application/combatant_roster.dart';
import 'package:saviors_paradox/features/combat/application/engagement_queue.dart';
import 'package:saviors_paradox/features/combat/application/report_exchange.dart';
import 'package:saviors_paradox/features/combat/application/step_engagements.dart';
import 'package:saviors_paradox/features/combat/application/step_flights.dart';
import 'package:saviors_paradox/features/combat/application/step_status_effects.dart';
import 'package:saviors_paradox/features/combat/infrastructure/in_memory_engagement_repository.dart';
import 'package:saviors_paradox/features/combat/infrastructure/in_memory_flights_repository.dart';
import 'package:saviors_paradox/features/combat/infrastructure/in_memory_status_effects_repository.dart';

// The bodies and the world belong to other features, so they are the edges
// of the machine here, mocked as in test/integration/ui_kit_test.dart.
class MockCombatant extends Mock implements Combatant {}

class MockCollisionWorld extends Mock implements CollisionWorld {}

const _oneFrame = Seconds(1 / 60);

const _foeMeleeStrike = Attack(
  attacker: EntityId(1),
  side: CombatantSide.foe,
  kind: AttackKind.melee,
  element: Element.plain,
  area: WorldBox(centre: Vec2(30, 0), halfWidth: 20, halfHeight: 20),
  damage: 12,
  knockback: Vec2.zero,
  isBlockable: true,
  isLethal: false,
);

MockCombatant _mockCombatant(
  EntityId id,
  CombatantSide side,
  WorldBox hurtbox,
) {
  final combatant = MockCombatant();
  when(() => combatant.id).thenReturn(id);
  when(() => combatant.side).thenReturn(side);
  when(() => combatant.hurtbox).thenReturn(hurtbox);
  when(() => combatant.raisedShield).thenReturn(null);
  when(() => combatant.isInvulnerable).thenReturn(false);
  when(() => combatant.isImmuneTo(any())).thenReturn(false);
  return combatant;
}

// Wires the real engagements, flights and status effects collaborators
// (T082, T083, T085, T086, T087) over [_queue], so the test builds nothing
// a production composition root would not.
final class _CombatHarness {
  _CombatHarness(this._roster, this._world, this._queue);

  final CombatantRoster _roster;
  final MockCollisionWorld _world;
  final EventQueue _queue;
  final _engagements = InMemoryEngagementRepository();
  final _flights = InMemoryFlightsRepository();
  final _statusEffects = InMemoryStatusEffectsRepository();

  late final _report = ReportExchange(
    _queue,
    BodyStatusEffects(_statusEffects, _queue),
  );

  late final attacks = EngagementQueue(
    roster: _roster,
    engagements: _engagements,
    flights: _flights,
  );

  late final loop = GameLoop(
    queue: _queue,
    clock: StepClock(),
    systems: [
      StepEngagements(_engagements, _report).step,
      StepFlights(
        flights: _flights,
        roster: _roster,
        world: _world,
        report: _report,
      ).step,
      StepStatusEffects(_statusEffects, _queue).step,
    ],
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(Vec2.zero);
    registerFallbackValue(Element.plain);
  });

  group('combat strikes, blocks and reflects through the loop', () {
    late EventQueue queue;
    late List<GameEvent> published;
    late MockCombatant foe;
    late MockCombatant akeris;
    late MockCollisionWorld world;
    late EngagementQueue attacks;
    late GameLoop loop;

    setUp(() {
      queue = EventQueue();
      published = [];
      queue.subscribe<GameEvent>(published.add);

      foe = _mockCombatant(
        const EntityId(1),
        CombatantSide.foe,
        const WorldBox(centre: Vec2(0, 0), halfWidth: 20, halfHeight: 40),
      );
      akeris = _mockCombatant(
        const EntityId(2),
        CombatantSide.akeris,
        const WorldBox(centre: Vec2(40, 0), halfWidth: 20, halfHeight: 96),
      );
      final roster = CombatantRoster()
        ..register(foe)
        ..register(akeris);

      world = MockCollisionWorld();
      when(() => world.cast(any(), any())).thenReturn(null);

      final combat = _CombatHarness(roster, world, queue);
      attacks = combat.attacks;
      loop = combat.loop;
    });

    test('a melee strike lands on an unguarded body through the loop', () {
      attacks.strike(_foeMeleeStrike);

      loop.advance(_oneFrame);

      expect(published, hasLength(2));
      expect(
        published[0],
        isA<HitLanded>()
            .having((e) => e.attacker, 'attacker', const EntityId(1))
            .having((e) => e.target, 'target', const EntityId(2))
            .having((e) => e.damage, 'damage', 12),
      );
      expect(
        published[1],
        isA<HitstopStarted>().having(
          (e) => e.duration,
          'duration',
          const Seconds(0.06),
        ),
      );
    });

    test('a sacred perfect block opens the counter through the loop', () {
      when(() => akeris.raisedShield).thenReturn(
        const RaisedShield(shield: ShieldId.sacred, raisedFor: Seconds(0.1)),
      );

      attacks.strike(_foeMeleeStrike);
      loop.advance(_oneFrame);

      final blockedIndex = published.indexWhere((e) => e is AttackBlocked);
      expect(blockedIndex, greaterThanOrEqualTo(0));
      expect((published[blockedIndex] as AttackBlocked).isPerfect, isTrue);

      final counterIndex = published.indexWhere(
        (e) => e is CounterTriggered,
      );
      expect(counterIndex, greaterThan(blockedIndex));
      expect(
        published[counterIndex],
        isA<CounterTriggered>()
            .having((e) => e.defender, 'defender', const EntityId(2))
            .having((e) => e.attacker, 'attacker', const EntityId(1)),
      );
    });

    test(
      'an ice perfect block freezes the attacker until its time runs out',
      () {
        when(() => akeris.raisedShield).thenReturn(
          const RaisedShield(shield: ShieldId.ice, raisedFor: Seconds(0.1)),
        );

        attacks.strike(_foeMeleeStrike);
        loop.advance(_oneFrame);

        expect(
          published,
          contains(
            isA<StatusEffectApplied>()
                .having((e) => e.target, 'target', const EntityId(1))
                .having((e) => e.effect, 'effect', StatusEffectKind.frozen)
                // controls.md G16: a perfect block freezes for 1.5 s.
                .having((e) => e.duration, 'duration', const Seconds(1.5)),
          ),
        );

        bool isFreezeEnded(GameEvent event) =>
            event is StatusEffectEnded &&
            event.target == const EntityId(1) &&
            event.effect == StatusEffectKind.frozen;

        var ends = 0;
        for (var frame = 1; frame <= 100; frame++) {
          published.clear();
          loop.advance(_oneFrame);
          ends += published.where(isFreezeEnded).length;
          if (frame == 90) {
            expect(ends, 0);
          }
        }

        expect(ends, 1);
      },
    );

    test('a reflected projectile hits its thrower through the loop', () {
      when(() => akeris.hurtbox).thenReturn(
        const WorldBox(centre: Vec2(300, 0), halfWidth: 20, halfHeight: 96),
      );
      when(() => akeris.raisedShield).thenReturn(
        const RaisedShield(shield: ShieldId.sacred, raisedFor: Seconds(0.1)),
      );

      attacks.launch(
        const Projectile(
          thrower: EntityId(1),
          side: CombatantSide.foe,
          element: Element.plain,
          position: Vec2(0, 0),
          velocity: Vec2(600, 0),
          radius: 10,
          damage: 8,
          isReflectable: true,
        ),
      );

      for (var frame = 0; frame < 120; frame++) {
        loop.advance(_oneFrame);
      }

      final reflectedIndex = published.indexWhere(
        (e) =>
            e is ProjectileReflected &&
            e.reflector == const EntityId(2) &&
            e.thrower == const EntityId(1),
      );
      expect(reflectedIndex, greaterThanOrEqualTo(0));

      final hitIndex = published.indexWhere(
        (e) =>
            e is HitLanded &&
            e.attacker == const EntityId(2) &&
            e.target == const EntityId(1) &&
            e.kind == AttackKind.projectile,
      );
      expect(hitIndex, greaterThan(reflectedIndex));
    });
  });
}
