import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';

void main() {
  group('Guard', () {
    test('a guard is equal by its shield and its time raised', () {
      final a = Guard(shield: ShieldId.ice, raisedFor: const Seconds(0.1));
      final b = Guard(shield: ShieldId.ice, raisedFor: const Seconds(0.1));
      final differentShield = Guard(
        shield: ShieldId.fire,
        raisedFor: const Seconds(0.1),
      );
      final differentTime = Guard(
        shield: ShieldId.ice,
        raisedFor: const Seconds(0.2),
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(differentShield)));
      expect(a, isNot(equals(differentTime)));
    });

    test('a guard is never raised for negative time', () {
      expect(
        () => Guard(shield: ShieldId.sacred, raisedFor: const Seconds(-0.01)),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
