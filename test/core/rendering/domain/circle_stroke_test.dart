import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/circle_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('CircleStroke', () {
    test('places 16 points around the centre', () {
      final random = StrokeRandom(const Seed(1));

      final circle = CircleStroke.generate(
        const Vec2(10, 10),
        20,
        random: random,
      );

      expect(circle.points, hasLength(16));
    });

    test("keeps each radius within 0.8 of the circle's", () {
      final random = StrokeRandom(const Seed(1));
      const centre = Vec2(10, 10);

      final circle = CircleStroke.generate(centre, 20, random: random);

      for (final point in circle.points) {
        expect(point.distanceTo(centre), inInclusiveRange(19.2, 20.8));
      }
    });

    test('keeps each radius within 6 % on a small circle', () {
      final random = StrokeRandom(const Seed(1));

      final circle = CircleStroke.generate(Vec2.zero, 5, random: random);

      for (final point in circle.points) {
        expect(point.distanceTo(Vec2.zero), inInclusiveRange(4.7, 5.3));
      }
    });

    test('stretches the circle by the factors given', () {
      final random = StrokeRandom(const Seed(1));

      final circle = CircleStroke.generate(
        Vec2.zero,
        10,
        random: random,
        stretch: const Vec2(1, 0.5),
      );

      for (final point in circle.points) {
        expect(point.y, inInclusiveRange(-5.4, 5.4));
      }
    });

    test('generates the same circle from the same seed', () {
      final first = CircleStroke.generate(
        Vec2.zero,
        10,
        random: StrokeRandom(const Seed(4)),
      );
      final second = CircleStroke.generate(
        Vec2.zero,
        10,
        random: StrokeRandom(const Seed(4)),
      );

      expect(first.points, second.points);
    });

    test('generates a different circle from another seed', () {
      final first = CircleStroke.generate(
        Vec2.zero,
        10,
        random: StrokeRandom(const Seed(4)),
      );
      final second = CircleStroke.generate(
        Vec2.zero,
        10,
        random: StrokeRandom(const Seed(5)),
      );

      expect(first.points, isNot(second.points));
    });
  });
}
