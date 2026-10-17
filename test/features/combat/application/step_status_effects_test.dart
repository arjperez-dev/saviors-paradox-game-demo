import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/status_effect_ended.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/application/step_status_effects.dart';
import 'package:saviors_paradox/features/combat/domain/status_effects.dart';

import '../mocks.dart';

class _FakeGameEvent extends Fake implements GameEvent {}

void main() {
  setUpAll(() => registerFallbackValue(_FakeGameEvent()));

  group('StepStatusEffects', () {
    late MockStatusEffectsRepository effects;
    late MockEventSink events;
    late StatusEffects statusEffects;
    late StepStatusEffects system;

    setUp(() {
      effects = MockStatusEffectsRepository();
      events = MockEventSink();
      statusEffects = StatusEffects();
      when(() => effects.load()).thenReturn(statusEffects);
      system = StepStatusEffects(effects, events);
    });

    test('publishes the end of an effect when its time runs out', () {
      statusEffects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );

      system.step(const Seconds(1.5));

      final captured = verify(() => events.publish(captureAny())).captured;
      expect(captured, [
        isA<StatusEffectEnded>()
            .having((e) => e.target, 'target', const EntityId(7))
            .having((e) => e.effect, 'effect', StatusEffectKind.frozen),
      ]);
    });

    test('publishes nothing while time is left', () {
      statusEffects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );

      system.step(const Seconds(1));

      verifyNever(() => events.publish(any()));
      expect(
        statusEffects.has(const EntityId(7), StatusEffectKind.frozen),
        isTrue,
      );
    });

    test('publishes the ends in the order the effects were applied', () {
      statusEffects.apply(
        const EntityId(2),
        StatusEffectKind.slowed,
        const Seconds(1),
      );
      statusEffects.apply(
        const EntityId(1),
        StatusEffectKind.stunned,
        const Seconds(1),
      );

      system.step(const Seconds(1));

      final captured = verify(() => events.publish(captureAny())).captured;
      expect(captured, [
        isA<StatusEffectEnded>()
            .having((e) => e.target, 'target', const EntityId(2))
            .having((e) => e.effect, 'effect', StatusEffectKind.slowed),
        isA<StatusEffectEnded>()
            .having((e) => e.target, 'target', const EntityId(1))
            .having((e) => e.effect, 'effect', StatusEffectKind.stunned),
      ]);
    });

    test('publishes each end once', () {
      statusEffects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1),
      );

      system.step(const Seconds(1));
      clearInteractions(events);
      system.step(const Seconds(1));

      verifyNever(() => events.publish(any()));
    });
  });
}
