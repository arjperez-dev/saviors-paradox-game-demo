import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

void main() {
  group('ZoneNumber', () {
    test('the first zone is zone 1', () {
      expect(ZoneNumber.first.value, 1);
    });

    test('the next zone is one deeper', () {
      expect(const ZoneNumber(4).next, const ZoneNumber(5));
    });

    test('orders zones by number', () {
      expect(const ZoneNumber(2).compareTo(const ZoneNumber(5)), lessThan(0));
    });

    test('rejects a zone outside 1 to 20', () {
      expect(() => ZoneNumber(0), throwsA(isA<AssertionError>()));
      expect(() => ZoneNumber(21), throwsA(isA<AssertionError>()));
    });
  });
}
