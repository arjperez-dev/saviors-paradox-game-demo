import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/status_effect_event.dart';

void main() {
  group('StatusStarted', () {
    test('is equal by its target, kind and duration', () {
      const a = StatusStarted(
        target: EntityId(1),
        kind: StatusEffectKind.frozen,
        duration: Seconds(1.5),
      );
      const b = StatusStarted(
        target: EntityId(1),
        kind: StatusEffectKind.frozen,
        duration: Seconds(1.5),
      );
      const differentDuration = StatusStarted(
        target: EntityId(1),
        kind: StatusEffectKind.frozen,
        duration: Seconds(0.5),
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(differentDuration)));
    });
  });

  group('StatusCleared', () {
    test('is equal by its target and kind', () {
      const a = StatusCleared(
        target: EntityId(1),
        kind: StatusEffectKind.stunned,
      );
      const b = StatusCleared(
        target: EntityId(1),
        kind: StatusEffectKind.stunned,
      );
      const differentKind = StatusCleared(
        target: EntityId(1),
        kind: StatusEffectKind.slowed,
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(differentKind)));
    });
  });

  group('StatusExpired', () {
    test('is equal by its target and kind', () {
      const a = StatusExpired(
        target: EntityId(1),
        kind: StatusEffectKind.burning,
      );
      const b = StatusExpired(
        target: EntityId(1),
        kind: StatusEffectKind.burning,
      );
      const differentTarget = StatusExpired(
        target: EntityId(2),
        kind: StatusEffectKind.burning,
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(differentTarget)));
    });
  });
}
