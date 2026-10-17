import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/status_effect_applied.dart';
import 'package:saviors_paradox/core/contracts/events/status_effect_ended.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/application/body_status_effects.dart';
import 'package:saviors_paradox/features/combat/domain/status_effects.dart';

import '../mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
      const StatusEffectApplied(
        target: EntityId(0),
        effect: StatusEffectKind.frozen,
        duration: Seconds.zero,
      ),
    );
    registerFallbackValue(StatusEffects());
  });

  group('BodyStatusEffects', () {
    late MockStatusEffectsRepository repository;
    late MockEventSink events;
    late StatusEffects effects;
    late BodyStatusEffects body;

    setUp(() {
      repository = MockStatusEffectsRepository();
      events = MockEventSink();
      effects = StatusEffects();
      when(() => repository.load()).thenReturn(effects);
      when(() => repository.save(any())).thenReturn(null);
      body = BodyStatusEffects(repository, events);
    });

    test('publishes the effect applied', () {
      body.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );

      final captured = verify(
        () => events.publish(captureAny()),
      ).captured.single;
      expect(
        captured,
        isA<StatusEffectApplied>()
            .having((e) => e.target, 'target', const EntityId(7))
            .having((e) => e.effect, 'effect', StatusEffectKind.frozen)
            .having((e) => e.duration, 'duration', const Seconds(1.5)),
      );
      verify(() => repository.save(effects)).called(1);
    });

    test('publishes nothing for an effect that is refused', () {
      body.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );
      body.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(0.5),
      );

      verify(() => events.publish(any())).called(1);
    });

    test('publishes the end of a cleared effect', () {
      body.apply(const EntityId(7), StatusEffectKind.stunned, const Seconds(2));
      body.clear(const EntityId(7), StatusEffectKind.stunned);

      final captured = verify(
        () => events.publish(captureAny()),
      ).captured;
      expect(captured, hasLength(2));
      expect(
        captured[1],
        isA<StatusEffectEnded>()
            .having((e) => e.target, 'target', const EntityId(7))
            .having((e) => e.effect, 'effect', StatusEffectKind.stunned),
      );
    });

    test('publishes nothing when clearing an absent effect', () {
      body.clear(const EntityId(9), StatusEffectKind.slowed);

      verifyNever(() => events.publish(any()));
    });

    test('answers whether a body has an effect', () {
      body.apply(
        const EntityId(7),
        StatusEffectKind.poisoned,
        const Seconds(3),
      );

      expect(body.has(const EntityId(7), StatusEffectKind.poisoned), isTrue);
      expect(body.has(const EntityId(7), StatusEffectKind.burning), isFalse);
    });
  });
}
