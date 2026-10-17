import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/features/combat/domain/shield_stops.dart';

void main() {
  group('ShieldStops', () {
    test('any shield stops a plain attack', () {
      const stops = ShieldStops(Element.plain);

      expect(stops.isSatisfiedBy(ShieldId.sacred), isTrue);
      expect(stops.isSatisfiedBy(ShieldId.ice), isTrue);
      expect(stops.isSatisfiedBy(ShieldId.fire), isTrue);
    });

    test('only the fire shield stops fire', () {
      const stops = ShieldStops(Element.fire);

      expect(stops.isSatisfiedBy(ShieldId.fire), isTrue);
      expect(stops.isSatisfiedBy(ShieldId.sacred), isFalse);
      expect(stops.isSatisfiedBy(ShieldId.ice), isFalse);
    });

    test('only the ice shield stops ice', () {
      const stops = ShieldStops(Element.ice);

      expect(stops.isSatisfiedBy(ShieldId.ice), isTrue);
      expect(stops.isSatisfiedBy(ShieldId.sacred), isFalse);
      expect(stops.isSatisfiedBy(ShieldId.fire), isFalse);
    });
  });
}
