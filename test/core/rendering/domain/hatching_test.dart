import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/hatching.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('Hatching', () {
    test('spans the box widened by its slope', () {
      final hatching = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(1)),
      );

      expect(hatching.lines, hasLength(32));
    });

    test('rises 0.6 across for every unit up', () {
      final hatching = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(1)),
      );

      for (final line in hatching.lines) {
        expect(
          line.to.x - line.from.x,
          inInclusiveRange(30 - 1.6, 30 + 1.6),
        );
      }
    });

    test('overshoots the box by 2 above and below', () {
      final hatching = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(1)),
      );

      for (final line in hatching.lines) {
        expect(line.from.y, 52);
        expect(line.to.y, -2);
      }
    });

    test('generates the same hatching from the same seed', () {
      final first = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(7)),
      );
      final second = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(7)),
      );

      expect(first.lines, second.lines);
    });

    test('generates a different hatching from a different seed', () {
      final one = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(7)),
      );
      final two = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(8)),
      );

      expect(one.lines, isNot(two.lines));
    });
  });
}
