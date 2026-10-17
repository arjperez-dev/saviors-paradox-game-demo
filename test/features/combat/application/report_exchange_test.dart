import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/attack_blocked.dart';
import 'package:saviors_paradox/core/contracts/events/counter_triggered.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/hit_landed.dart';
import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/projectile_reflected.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_cued.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/application/report_exchange.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/engagement_event.dart';
import 'package:saviors_paradox/features/combat/domain/flight_event.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

import '../mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const HitstopStarted(duration: Seconds.zero));
  });

  group('ReportExchange', () {
    const at = Vec2(15, 0);
    final strike = Strike(
      attacker: const EntityId(1),
      side: CombatantSide.foe,
      kind: AttackKind.melee,
      element: Element.plain,
      area: const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
      damage: const Damage(10),
      knockback: const Vec2(5, 0),
      isBlockable: true,
      isLethal: false,
    );

    late MockEventSink events;
    late MockStatusEffectControl statuses;
    late List<GameEvent> published;
    late ReportExchange report;

    setUp(() {
      events = MockEventSink();
      statuses = MockStatusEffectControl();
      published = [];
      when(() => events.publish(any())).thenAnswer(
        (invocation) =>
            published.add(invocation.positionalArguments.first as GameEvent),
      );
      report = ReportExchange(events, statuses);
    });

    test('a landed strike publishes the hit then its hitstop', () {
      report.engagement(
        StrikeLanded(
          strike: strike,
          target: const EntityId(2),
          at: at,
          hitstop: const Seconds(0.06), // hit-feedback.md §2: melee hit lands
        ),
      );

      expect(published, hasLength(2));
      final hit = published[0] as HitLanded;
      expect(hit.attacker, const EntityId(1));
      expect(hit.target, const EntityId(2));
      expect(hit.kind, AttackKind.melee);
      expect(hit.element, Element.plain);
      expect(hit.damage, 10);
      expect(hit.knockback, const Vec2(5, 0));
      expect(hit.at, at);
      expect(hit.isLethal, isFalse);
      expect((published[1] as HitstopStarted).duration, const Seconds(0.06));
    });

    test(
      "a blocked strike publishes the block, its hitstop and the shield's sound",
      () {
        report.engagement(
          StrikeBlocked(
            strike: strike,
            defender: const EntityId(2),
            shield: ShieldId.sacred,
            isPerfect: false,
            opensCounter: false,
            affliction: null,
            at: at,
            hitstop: const Seconds(0.05), // hit-feedback.md §2: sacred shield
          ),
        );

        expect(published, hasLength(3));
        final blocked = published[0] as AttackBlocked;
        expect(blocked.attacker, const EntityId(1));
        expect(blocked.defender, const EntityId(2));
        expect(blocked.kind, AttackKind.melee);
        expect(blocked.element, Element.plain);
        expect(blocked.shield, ShieldId.sacred);
        expect(blocked.isPerfect, isFalse);
        expect(blocked.at, at);
        expect(
          (published[1] as HitstopStarted).duration,
          const Seconds(0.05),
        );
        final sound = published[2] as SoundEffectCued;
        expect(sound.sound, const SoundEffectId('sfx.shield.sacred'));
        expect(sound.at, at);
      },
    );

    test('a sacred perfect block publishes the counter last', () {
      report.engagement(
        StrikeBlocked(
          strike: strike,
          defender: const EntityId(2),
          shield: ShieldId.sacred,
          isPerfect: true,
          opensCounter: true,
          affliction: null,
          at: at,
          hitstop: const Seconds(0.09), // hit-feedback.md §2: perfect block
        ),
      );

      expect(published, hasLength(5));
      expect((published[0] as AttackBlocked).isPerfect, isTrue);
      expect((published[1] as HitstopStarted).duration, const Seconds(0.09));
      expect(
        (published[2] as SoundEffectCued).sound,
        const SoundEffectId('sfx.shield.sacred'),
      );
      expect(
        (published[3] as SoundEffectCued).sound,
        const SoundEffectId('sfx.shield.just'),
      );
      final counter = published[4] as CounterTriggered;
      expect(counter.defender, const EntityId(2));
      expect(counter.attacker, const EntityId(1));
    });

    test(
      'an affliction is applied through the control port with its sound',
      () {
        final affliction = Affliction(
          target: const EntityId(1),
          kind: StatusEffectKind.frozen,
          duration: const Seconds(1.5),
        );

        report.engagement(
          StrikeBlocked(
            strike: strike,
            defender: const EntityId(2),
            shield: ShieldId.ice,
            isPerfect: true,
            opensCounter: false,
            affliction: affliction,
            at: at,
            // hit-feedback.md §2: ice shield (a perfect block with it draws
            // as its plain block)
            hitstop: const Seconds(0.05),
          ),
        );

        verify(
          () => statuses.apply(
            const EntityId(1),
            StatusEffectKind.frozen,
            const Seconds(1.5),
          ),
        ).called(1);
        expect(published, hasLength(5));
        expect(
          (published[2] as SoundEffectCued).sound,
          const SoundEffectId('sfx.shield.ice'),
        );
        expect(
          (published[3] as SoundEffectCued).sound,
          const SoundEffectId('sfx.shield.just'),
        );
        expect(
          (published[4] as SoundEffectCued).sound,
          const SoundEffectId('sfx.fx.freeze'),
        );
      },
    );

    test('a slow is applied without a sound', () {
      final affliction = Affliction(
        target: const EntityId(1),
        kind: StatusEffectKind.slowed,
        duration: const Seconds(1.5),
      );

      report.engagement(
        StrikeBlocked(
          strike: strike,
          defender: const EntityId(2),
          shield: ShieldId.ice,
          isPerfect: false,
          opensCounter: false,
          affliction: affliction,
          at: at,
          hitstop: const Seconds(0.05), // hit-feedback.md §2: ice shield
        ),
      );

      verify(
        () => statuses.apply(
          const EntityId(1),
          StatusEffectKind.slowed,
          const Seconds(1.5),
        ),
      ).called(1);
      final sounds = published.whereType<SoundEffectCued>().map(
        (cued) => cued.sound.value,
      );
      expect(sounds.any((id) => id.startsWith('sfx.fx.')), isFalse);
    });

    test('a struck flight publishes the hit, its hitstop and its impact', () {
      report.flight(
        FlightStruck(
          striker: const EntityId(1),
          target: const EntityId(2),
          element: Element.fire,
          damage: const Damage(8),
          at: at,
          hitstop: const Seconds(0.06), // hit-feedback.md §2: Akeris is hit
          affliction: null,
        ),
      );

      expect(published, hasLength(3));
      final hit = published[0] as HitLanded;
      expect(hit.attacker, const EntityId(1));
      expect(hit.target, const EntityId(2));
      expect(hit.kind, AttackKind.projectile);
      expect(hit.element, Element.fire);
      expect(hit.damage, 8);
      expect(hit.knockback, Vec2.zero);
      expect(hit.at, at);
      expect(hit.isLethal, isFalse);
      expect((published[1] as HitstopStarted).duration, const Seconds(0.06));
      final sound = published[2] as SoundEffectCued;
      expect(sound.sound, const SoundEffectId('sfx.fire.impact'));
      expect(sound.at, at);
    });

    test('a plain flight lands with no impact sound', () {
      report.flight(
        FlightStruck(
          striker: const EntityId(1),
          target: const EntityId(2),
          element: Element.plain,
          damage: const Damage(8),
          at: at,
          hitstop: const Seconds(0.06), // hit-feedback.md §2: Akeris is hit
          affliction: null,
        ),
      );

      expect(published, hasLength(2));
      expect(published[0], isA<HitLanded>());
      expect(published[1], isA<HitstopStarted>());
    });

    test('a blocked flight publishes the block of a projectile', () {
      report.flight(
        FlightBlocked(
          thrower: const EntityId(1),
          defender: const EntityId(2),
          element: Element.plain,
          shield: ShieldId.sacred,
          isPerfect: false,
          at: at,
          hitstop: const Seconds(0.05), // hit-feedback.md §2: sacred shield
        ),
      );

      expect(published, hasLength(3));
      final blocked = published[0] as AttackBlocked;
      expect(blocked.kind, AttackKind.projectile);
      expect(blocked.isPerfect, isFalse);
      expect(blocked.attacker, const EntityId(1));
      expect(blocked.defender, const EntityId(2));
      expect((published[1] as HitstopStarted).duration, const Seconds(0.05));
      expect(
        (published[2] as SoundEffectCued).sound,
        const SoundEffectId('sfx.shield.sacred'),
      );
    });

    test(
      'a turned flight publishes the reflect, its hitstop and two sounds',
      () {
        report.flight(
          FlightTurned(
            reflector: const EntityId(2),
            thrower: const EntityId(1),
            shield: ShieldId.ice,
            at: at,
            hitstop: const Seconds(0.07), // hit-feedback.md §2: perfect, proj.
          ),
        );

        expect(published, hasLength(4));
        final reflected = published[0] as ProjectileReflected;
        expect(reflected.reflector, const EntityId(2));
        expect(reflected.thrower, const EntityId(1));
        expect(reflected.shield, ShieldId.ice);
        expect(reflected.at, at);
        expect(
          (published[1] as HitstopStarted).duration,
          const Seconds(0.07),
        );
        expect(
          (published[2] as SoundEffectCued).sound,
          const SoundEffectId('sfx.fx.reflect'),
        );
        expect(
          (published[3] as SoundEffectCued).sound,
          const SoundEffectId('sfx.shield.just'),
        );
      },
    );

    test('a crashed flight sounds only its element', () {
      report.flight(const FlightCrashed(element: Element.ice, at: at));

      expect(published, hasLength(1));
      final sound = published[0] as SoundEffectCued;
      expect(sound.sound, const SoundEffectId('sfx.ice.impact'));
      expect(sound.at, at);

      published.clear();
      report.flight(const FlightCrashed(element: Element.plain, at: at));

      expect(published, isEmpty);
    });
  });
}
