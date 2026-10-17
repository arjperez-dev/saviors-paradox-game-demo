import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/status_effect_event.dart';
import 'package:saviors_paradox/features/combat/domain/status_effects.dart';

void main() {
  group('StatusEffects', () {
    late StatusEffects effects;

    setUp(() => effects = StatusEffects());

    test('an applied effect is held for its duration', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );

      expect(effects.has(const EntityId(7), StatusEffectKind.frozen), isTrue);
      expect(
        effects.remaining(const EntityId(7), StatusEffectKind.frozen),
        equals(const Seconds(1.5)),
      );
    });

    test('applying gives what started', () {
      final started = effects.apply(
        const EntityId(7),
        StatusEffectKind.burning,
        const Seconds(1.5),
      );

      expect(
        started,
        equals(
          const StatusStarted(
            target: EntityId(7),
            kind: StatusEffectKind.burning,
            duration: Seconds(1.5),
          ),
        ),
      );
    });

    test('a longer effect extends the one running', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(0.5),
      );

      final started = effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );

      expect(
        started,
        equals(
          const StatusStarted(
            target: EntityId(7),
            kind: StatusEffectKind.frozen,
            duration: Seconds(1.5),
          ),
        ),
      );
      expect(
        effects.remaining(const EntityId(7), StatusEffectKind.frozen),
        equals(const Seconds(1.5)),
      );
    });

    test('a shorter effect leaves the longer one running', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );
      effects.advance(const Seconds(0.5), []);

      final started = effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(0.5),
      );

      expect(started, isNull);
      expect(
        effects.remaining(const EntityId(7), StatusEffectKind.frozen).value,
        closeTo(1.0, 1e-9),
      );
    });

    test('an absent effect has no time remaining', () {
      expect(
        effects.remaining(const EntityId(9), StatusEffectKind.slowed),
        equals(Seconds.zero),
      );
    });

    test('applying the same duration as what is running is refused', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );

      final started = effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );

      expect(started, isNull);
    });

    test('an effect with no time is refused', () {
      final started = effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        Seconds.zero,
      );

      expect(started, isNull);
      expect(
        effects.has(const EntityId(7), StatusEffectKind.frozen),
        isFalse,
      );
    });

    test('each body keeps its own effects', () {
      effects.apply(
        const EntityId(1),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );
      effects.apply(
        const EntityId(2),
        StatusEffectKind.frozen,
        const Seconds(0.5),
      );

      expect(
        effects.remaining(const EntityId(1), StatusEffectKind.frozen),
        equals(const Seconds(1.5)),
      );
      expect(
        effects.remaining(const EntityId(2), StatusEffectKind.frozen),
        equals(const Seconds(0.5)),
      );
      expect(
        effects.has(const EntityId(1), StatusEffectKind.burning),
        isFalse,
      );
    });

    test('clearing ends an effect at once', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.stunned,
        const Seconds(2),
      );

      final cleared = effects.clear(
        const EntityId(7),
        StatusEffectKind.stunned,
      );

      expect(
        cleared,
        equals(
          const StatusCleared(
            target: EntityId(7),
            kind: StatusEffectKind.stunned,
          ),
        ),
      );
      expect(
        effects.has(const EntityId(7), StatusEffectKind.stunned),
        isFalse,
      );
    });

    test('clearing one effect leaves another running', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.stunned,
        const Seconds(2),
      );
      effects.apply(
        const EntityId(7),
        StatusEffectKind.burning,
        const Seconds(3),
      );

      effects.clear(const EntityId(7), StatusEffectKind.stunned);

      expect(
        effects.has(const EntityId(7), StatusEffectKind.stunned),
        isFalse,
      );
      expect(
        effects.remaining(const EntityId(7), StatusEffectKind.burning),
        equals(const Seconds(3)),
      );
    });

    test('clearing an absent effect changes nothing', () {
      final cleared = effects.clear(const EntityId(9), StatusEffectKind.slowed);

      expect(cleared, isNull);
    });

    test('an effect expires when its time runs out', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );
      final expired = <StatusExpired>[];

      effects.advance(const Seconds(1.5), expired);

      expect(
        expired,
        equals([
          const StatusExpired(
            target: EntityId(7),
            kind: StatusEffectKind.frozen,
          ),
        ]),
      );
      expect(
        effects.has(const EntityId(7), StatusEffectKind.frozen),
        isFalse,
      );
    });

    test('effects expire in the order they were applied', () {
      effects.apply(
        const EntityId(2),
        StatusEffectKind.slowed,
        const Seconds(1),
      );
      effects.apply(
        const EntityId(1),
        StatusEffectKind.frozen,
        const Seconds(1),
      );
      final expired = <StatusExpired>[];

      effects.advance(const Seconds(1), expired);

      expect(
        expired,
        equals([
          const StatusExpired(
            target: EntityId(2),
            kind: StatusEffectKind.slowed,
          ),
          const StatusExpired(
            target: EntityId(1),
            kind: StatusEffectKind.frozen,
          ),
        ]),
      );
    });

    test('a survivor between two that expire keeps its place', () {
      effects.apply(
        const EntityId(1),
        StatusEffectKind.slowed,
        const Seconds(1),
      );
      effects.apply(
        const EntityId(2),
        StatusEffectKind.frozen,
        const Seconds(5),
      );
      effects.apply(
        const EntityId(3),
        StatusEffectKind.burning,
        const Seconds(1),
      );
      final expired = <StatusExpired>[];

      effects.advance(const Seconds(1), expired);

      expect(
        expired,
        equals([
          const StatusExpired(
            target: EntityId(1),
            kind: StatusEffectKind.slowed,
          ),
          const StatusExpired(
            target: EntityId(3),
            kind: StatusEffectKind.burning,
          ),
        ]),
      );
      expect(
        effects.remaining(const EntityId(2), StatusEffectKind.frozen).value,
        closeTo(4.0, 1e-9),
      );
    });

    test('an effect with time left stays', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );
      final expired = <StatusExpired>[];

      effects.advance(const Seconds(0.5), expired);

      expect(expired, isEmpty);
      expect(
        effects.remaining(const EntityId(7), StatusEffectKind.frozen).value,
        closeTo(1.0, 1e-9),
      );
    });

    test('an effect lasts the same at any frame rate', () {
      effects.apply(
        const EntityId(7),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );
      for (var i = 0; i < 89; i++) {
        effects.advance(const Seconds(1 / 60), []);
      }
      expect(
        effects.has(const EntityId(7), StatusEffectKind.frozen),
        isTrue,
      );
      effects.advance(const Seconds(1 / 60), []);
      expect(
        effects.has(const EntityId(7), StatusEffectKind.frozen),
        isFalse,
      );

      effects.apply(
        const EntityId(8),
        StatusEffectKind.frozen,
        const Seconds(1.5),
      );
      for (var i = 0; i < 215; i++) {
        effects.advance(const Seconds(1 / 144), []);
      }
      expect(
        effects.has(const EntityId(8), StatusEffectKind.frozen),
        isTrue,
      );
      effects.advance(const Seconds(1 / 144), []);
      expect(
        effects.has(const EntityId(8), StatusEffectKind.frozen),
        isFalse,
      );
    });
  });
}
