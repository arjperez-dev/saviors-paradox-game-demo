import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_hole.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('InkHole', () {
    test('places a hole over a body 200 su tall', () {
      for (var seed = 1; seed <= 50; seed++) {
        final hole = InkHole.generate(StrokeRandom(Seed(seed)));

        expect(hole.centre.x, greaterThanOrEqualTo(-60));
        expect(hole.centre.x, lessThan(60));
        expect(hole.centre.y, greaterThan(-200));
        expect(hole.centre.y, lessThanOrEqualTo(-10));
      }
    });

    test('gives a hole a radius of 20 to 42', () {
      for (var seed = 1; seed <= 50; seed++) {
        final hole = InkHole.generate(StrokeRandom(Seed(seed)));

        expect(hole.radius, greaterThanOrEqualTo(20));
        expect(hole.radius, lessThan(42));
      }
    });

    test('opens a hole between 0.12 and 0.82 s', () {
      for (var seed = 1; seed <= 50; seed++) {
        final hole = InkHole.generate(StrokeRandom(Seed(seed)));

        expect(hole.opensAt.value, greaterThanOrEqualTo(0.12));
        expect(hole.opensAt.value, lessThanOrEqualTo(0.82));
      }
    });

    test('opens the upper holes first', () {
      final random = StrokeRandom(const Seed(7));
      final holes = [for (var i = 0; i < 200; i++) InkHole.generate(random)];
      final upper = holes.where((hole) => hole.centre.y < -105);
      final lower = holes.where((hole) => hole.centre.y >= -105);
      final upperMean =
          upper.map((hole) => hole.opensAt.value).reduce((a, b) => a + b) /
          upper.length;
      final lowerMean =
          lower.map((hole) => hole.opensAt.value).reduce((a, b) => a + b) /
          lower.length;

      expect(upperMean, lessThan(lowerMean));
    });

    test('grows a hole to its radius over 0.45 s', () {
      final hole = InkHole.generate(StrokeRandom(const Seed(3)));

      expect(hole.radiusAt(hole.opensAt), 0);
      expect(
        hole.radiusAt(hole.opensAt + const Seconds(0.45)),
        closeTo(hole.radius, 1e-9),
      );
    });

    test('generates the same hole from the same seed', () {
      final first = InkHole.generate(StrokeRandom(const Seed(10)));
      final second = InkHole.generate(StrokeRandom(const Seed(10)));

      expect(first.centre, second.centre);
      expect(first.radius, second.radius);
      expect(first.opensAt, second.opensAt);
    });

    test('generates a different hole from a different seed', () {
      final first = InkHole.generate(StrokeRandom(const Seed(10)));
      final second = InkHole.generate(StrokeRandom(const Seed(11)));

      expect(first.centre, isNot(second.centre));
    });
  });
}
