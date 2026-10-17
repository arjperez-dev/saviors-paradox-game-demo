import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';

void main() {
  group('Immunities', () {
    test('a plain attack is never covered', () {
      const immunities = Immunities(toFire: true, toIce: true);

      expect(immunities.covers(Element.plain), isFalse);
    });

    test('each element is covered by its own immunity', () {
      const toFire = Immunities(toFire: true);
      const toIce = Immunities(toIce: true);

      expect(toFire.covers(Element.fire), isTrue);
      expect(toFire.covers(Element.ice), isFalse);
      expect(toIce.covers(Element.ice), isTrue);
      expect(toIce.covers(Element.fire), isFalse);
    });

    test('immunities are equal by value', () {
      const a = Immunities(toIce: true);
      const b = Immunities(toIce: true);

      expect(a, equals(b));
      expect(Immunities.none, equals(const Immunities()));
      expect(a, isNot(equals(Immunities.none)));
    });
  });
}
