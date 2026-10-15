import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/rendering/domain/puff_shape.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('PuffShape', () {
    test('outlines a puff with 9 points', () {
      final shape = PuffShape.generate(StrokeRandom(const Seed(1)));

      expect(shape.outline, hasLength(9));
    });

    test('gives a puff a radius of 7 to 14', () {
      for (var seed = 1; seed <= 50; seed++) {
        final shape = PuffShape.generate(StrokeRandom(Seed(seed)));

        expect(shape.radius, greaterThanOrEqualTo(7));
        expect(shape.radius, lessThan(14));
      }
    });

    test('keeps each point between 70 % and 115 % of the radius', () {
      final shape = PuffShape.generate(StrokeRandom(const Seed(1)));

      for (final point in shape.outline) {
        final reach = math.sqrt(
          point.x * point.x + (point.y / 0.85) * (point.y / 0.85),
        );

        expect(reach, greaterThanOrEqualTo(shape.radius * 0.7));
        expect(reach, lessThan(shape.radius * 1.15));
      }
    });

    test('sends a puff up at 55 to 125 su/s with a drift of at most 25', () {
      for (var seed = 1; seed <= 50; seed++) {
        final shape = PuffShape.generate(StrokeRandom(Seed(seed)));

        expect(shape.velocity.y, lessThanOrEqualTo(-55));
        expect(shape.velocity.y, greaterThan(-125));
        expect(shape.velocity.x, greaterThanOrEqualTo(-25));
        expect(shape.velocity.x, lessThanOrEqualTo(25));
      }
    });

    test('lets a puff live 0.9 to 1.5 s', () {
      for (var seed = 1; seed <= 50; seed++) {
        final shape = PuffShape.generate(StrokeRandom(Seed(seed)));

        expect(shape.life.value, greaterThanOrEqualTo(0.9));
        expect(shape.life.value, lessThan(1.5));
      }
    });

    test('draws the wisp 1.3 wide', () {
      final shape = PuffShape.generate(StrokeRandom(const Seed(1)));

      expect(shape.wisp.main.width, 1.3);
    });

    test('shapes the same puff from the same seed', () {
      final first = PuffShape.generate(StrokeRandom(const Seed(10)));
      final second = PuffShape.generate(StrokeRandom(const Seed(10)));

      expect(first.outline, second.outline);
      expect(first.velocity, second.velocity);
      expect(first.life, second.life);
    });

    test('shapes a different puff from a different seed', () {
      final first = PuffShape.generate(StrokeRandom(const Seed(10)));
      final second = PuffShape.generate(StrokeRandom(const Seed(11)));

      expect(first.outline, isNot(second.outline));
    });
  });
}
