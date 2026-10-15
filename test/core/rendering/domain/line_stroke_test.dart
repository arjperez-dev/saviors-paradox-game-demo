import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/line_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('LineStroke', () {
    test('generates the same line from the same seed', () {
      final first = LineStroke.generate(
        const Vec2(0, 0),
        const Vec2(100, 0),
        width: 2.9,
        random: StrokeRandom(const Seed(1)),
      );
      final second = LineStroke.generate(
        const Vec2(0, 0),
        const Vec2(100, 0),
        width: 2.9,
        random: StrokeRandom(const Seed(1)),
      );

      expect(first, second);
    });

    test('generates a different line from a different seed', () {
      final one = LineStroke.generate(
        const Vec2(0, 0),
        const Vec2(100, 0),
        width: 2.9,
        random: StrokeRandom(const Seed(1)),
      );
      final two = LineStroke.generate(
        const Vec2(0, 0),
        const Vec2(100, 0),
        width: 2.9,
        random: StrokeRandom(const Seed(2)),
      );

      expect(one, isNot(two));
    });

    test('bows the control point by at most 1.3 sideways', () {
      for (var seed = 1; seed <= 50; seed++) {
        final stroke = LineStroke.generate(
          const Vec2(0, 0),
          const Vec2(100, 0),
          width: 2.9,
          random: StrokeRandom(Seed(seed)),
        );

        expect(stroke.main.control.y, inInclusiveRange(-1.3, 1.3));
      }
    });

    test('bows a short line by at most 2.5 % of its length', () {
      for (var seed = 1; seed <= 50; seed++) {
        final stroke = LineStroke.generate(
          const Vec2(0, 0),
          const Vec2(10, 0),
          width: 2.9,
          random: StrokeRandom(Seed(seed)),
        );

        expect(stroke.main.control.y, inInclusiveRange(-0.25, 0.25));
      }
    });

    test('slides the midpoint by at most 6 % along the line', () {
      for (var seed = 1; seed <= 50; seed++) {
        final stroke = LineStroke.generate(
          const Vec2(0, 0),
          const Vec2(100, 0),
          width: 2.9,
          random: StrokeRandom(Seed(seed)),
        );

        expect(stroke.main.control.x, inInclusiveRange(44, 56));
      }
    });

    test('moves each end by at most 0.3 on each axis', () {
      for (var seed = 1; seed <= 50; seed++) {
        final stroke = LineStroke.generate(
          const Vec2(0, 0),
          const Vec2(100, 0),
          width: 2.9,
          random: StrokeRandom(Seed(seed)),
        );

        expect(stroke.main.start.x, inInclusiveRange(-0.3, 0.3));
        expect(stroke.main.start.y, inInclusiveRange(-0.3, 0.3));
        expect(stroke.main.end.x, inInclusiveRange(99.7, 100.3));
        expect(stroke.main.end.y, inInclusiveRange(-0.3, 0.3));
      }
    });

    test('adds a second pass at 30 % alpha and 40 % width', () {
      final stroke = LineStroke.generate(
        const Vec2(0, 0),
        const Vec2(100, 0),
        width: 2.9,
        random: StrokeRandom(const Seed(1)),
      );

      expect(stroke.second!.alpha, 0.3);
      expect(stroke.second!.width, closeTo(1.16, 1e-9));
    });

    test('overshoots the start by 1.5 to 4 on the second pass', () {
      for (var seed = 1; seed <= 50; seed++) {
        final stroke = LineStroke.generate(
          const Vec2(0, 0),
          const Vec2(100, 0),
          width: 2.9,
          random: StrokeRandom(Seed(seed)),
        );

        expect(stroke.second!.start.x, inInclusiveRange(-4, -1.5));
      }
    });

    test('gives no second pass to a line narrower than 2', () {
      final stroke = LineStroke.generate(
        const Vec2(0, 0),
        const Vec2(100, 0),
        width: 1.9,
        random: StrokeRandom(const Seed(1)),
      );

      expect(stroke.second, isNull);
    });

    test('generates a line of no length without failing', () {
      final stroke = LineStroke.generate(
        const Vec2(5, 5),
        const Vec2(5, 5),
        width: 2.9,
        random: StrokeRandom(const Seed(1)),
      );

      expect(stroke.main.start.x, inInclusiveRange(4.7, 5.3));
      expect(stroke.main.start.y, inInclusiveRange(4.7, 5.3));
    });
  });
}
