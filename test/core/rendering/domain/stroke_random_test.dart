import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('StrokeRandom', () {
    test('gives the same numbers for the same seed', () {
      final first = StrokeRandom(const Seed(7));
      final second = StrokeRandom(const Seed(7));

      final firstFive = List.generate(5, (_) => first.unit());
      final secondFive = List.generate(5, (_) => second.unit());

      expect(firstFive, secondFive);
    });

    test('gives other numbers for another seed', () {
      final seven = StrokeRandom(const Seed(7));
      final eight = StrokeRandom(const Seed(8));

      final fromSeven = List.generate(5, (_) => seven.unit());
      final fromEight = List.generate(5, (_) => eight.unit());

      expect(fromSeven, isNot(fromEight));
    });

    test('keeps unit numbers between 0 and 1', () {
      final random = StrokeRandom(const Seed(1));

      final values = List.generate(1000, (_) => random.unit());

      expect(values.every((value) => value >= 0 && value < 1), isTrue);
    });

    test('keeps signed numbers between -1 and 1', () {
      final random = StrokeRandom(const Seed(1));

      final values = List.generate(1000, (_) => random.signed());

      expect(values.every((value) => value >= -1 && value < 1), isTrue);
    });

    test('keeps numbers between the bounds asked for', () {
      final random = StrokeRandom(const Seed(1));

      final values = List.generate(1000, (_) => random.between(3, 8));

      expect(values.every((value) => value >= 3 && value < 8), isTrue);
    });

    test('comes true about as often as the chance asked for', () {
      final random = StrokeRandom(const Seed(1));

      final trueCount = List.generate(
        10000,
        (_) => random.chance(0.35),
      ).where((result) => result).length;

      expect(trueCount, inInclusiveRange(3200, 3800));
    });
  });
}
