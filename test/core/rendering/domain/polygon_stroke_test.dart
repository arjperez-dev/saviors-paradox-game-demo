import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/polygon_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('PolygonStroke', () {
    test('keeps one point per corner', () {
      final stroke = PolygonStroke.generate(
        const [Vec2(0, 0), Vec2(10, 0), Vec2(10, 10)],
        random: StrokeRandom(const Seed(1)),
      );

      expect(stroke.points, hasLength(3));
    });

    test('moves each corner by at most 0.3 by default', () {
      const corners = [Vec2(0, 0), Vec2(10, 0), Vec2(10, 10)];
      for (var seed = 1; seed <= 50; seed++) {
        final stroke = PolygonStroke.generate(
          corners,
          random: StrokeRandom(Seed(seed)),
        );

        for (var i = 0; i < corners.length; i++) {
          expect(
            stroke.points[i].x,
            inInclusiveRange(corners[i].x - 0.3, corners[i].x + 0.3),
          );
          expect(
            stroke.points[i].y,
            inInclusiveRange(corners[i].y - 0.3, corners[i].y + 0.3),
          );
        }
      }
    });

    test('moves each corner by at most the jitter given', () {
      const corners = [Vec2(0, 0), Vec2(10, 0), Vec2(10, 10)];
      for (var seed = 1; seed <= 50; seed++) {
        final stroke = PolygonStroke.generate(
          corners,
          random: StrokeRandom(Seed(seed)),
          jitter: 0.7,
        );

        for (var i = 0; i < corners.length; i++) {
          expect(
            stroke.points[i].x,
            inInclusiveRange(corners[i].x - 0.7, corners[i].x + 0.7),
          );
          expect(
            stroke.points[i].y,
            inInclusiveRange(corners[i].y - 0.7, corners[i].y + 0.7),
          );
        }
      }
    });

    test('generates the same polygon from the same seed', () {
      const corners = [Vec2(0, 0), Vec2(10, 0), Vec2(10, 10)];
      final first = PolygonStroke.generate(
        corners,
        random: StrokeRandom(const Seed(6)),
      );
      final second = PolygonStroke.generate(
        corners,
        random: StrokeRandom(const Seed(6)),
      );

      expect(first.points, second.points);
    });

    test('generates a different polygon from a different seed', () {
      const corners = [Vec2(0, 0), Vec2(10, 0), Vec2(10, 10)];
      final one = PolygonStroke.generate(
        corners,
        random: StrokeRandom(const Seed(1)),
      );
      final two = PolygonStroke.generate(
        corners,
        random: StrokeRandom(const Seed(2)),
      );

      expect(one.points, isNot(two.points));
    });
  });
}
