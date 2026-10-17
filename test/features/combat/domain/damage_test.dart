import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';

void main() {
  group('Damage', () {
    test('damage is equal by its amount', () {
      const a = Damage(12);
      const b = Damage(12);
      const c = Damage(13);

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(c)));
    });

    test('damage is never negative', () {
      expect(() => Damage(-1), throwsA(isA<AssertionError>()));
    });

    test('no damage is none', () {
      expect(Damage.none.isNone, isTrue);
      expect(const Damage(0.5).isNone, isFalse);
    });
  });
}
