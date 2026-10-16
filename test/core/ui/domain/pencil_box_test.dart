import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/polygon_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';
import 'package:saviors_paradox/core/ui/domain/pencil_box.dart';

void main() {
  group('PencilBox', () {
    const size = UiVec2(Vec2(120, 56));

    test('the same seed gives the same box', () {
      final first = PencilBox.generate(size, seed: const Seed(7));
      final second = PencilBox.generate(size, seed: const Seed(7));

      expect(first.outline, second.outline);
      expect(first.inner, second.inner);
    });

    test('different seeds give different boxes', () {
      final one = PencilBox.generate(size, seed: const Seed(1));
      final two = PencilBox.generate(size, seed: const Seed(2));

      expect(one.outline, isNot(two.outline));
    });

    test('each corner moves at most 0.6', () {
      // 06-ui/sandbox/sandbox.html `hudBox`: `poly(pts, …, .6)`.
      const corners = [Vec2(0, 0), Vec2(120, 0), Vec2(120, 56), Vec2(0, 56)];
      for (var seed = 1; seed <= 50; seed++) {
        final box = PencilBox.generate(size, seed: Seed(seed));

        expect(box.outline, hasLength(4));
        for (var i = 0; i < corners.length; i++) {
          expect(
            box.outline[i].x,
            inInclusiveRange(corners[i].x - 0.6, corners[i].x + 0.6),
          );
          expect(
            box.outline[i].y,
            inInclusiveRange(corners[i].y - 0.6, corners[i].y + 0.6),
          );
        }
      }
    });

    test('the inner line sits 4 in and moves at most 0.8', () {
      // 06-ui/sandbox/sandbox.html `hudBox`: inset 4, `poly(…, 1, .8)`.
      const corners = [
        Vec2(4, 4),
        Vec2(116, 4),
        Vec2(116, 52),
        Vec2(4, 52),
      ];
      for (var seed = 1; seed <= 50; seed++) {
        final box = PencilBox.generate(size, seed: Seed(seed));

        expect(box.inner, hasLength(4));
        for (var i = 0; i < corners.length; i++) {
          expect(
            box.inner[i].x,
            inInclusiveRange(corners[i].x - 0.8, corners[i].x + 0.8),
          );
          expect(
            box.inner[i].y,
            inInclusiveRange(corners[i].y - 0.8, corners[i].y + 0.8),
          );
        }
      }
    });

    test('the inner line comes from the next seed', () {
      final box = PencilBox.generate(size, seed: const Seed(7));
      // 06-ui/sandbox/sandbox.html `hudBox`: `seed(id + 1)` before the inner
      // line's `poly`.
      final expected = PolygonStroke.generate(
        const [Vec2(4, 4), Vec2(116, 4), Vec2(116, 52), Vec2(4, 52)],
        random: StrokeRandom(const Seed(8)),
        jitter: 0.8,
      );

      expect(box.inner, expected.points);
    });

    test('the corners cannot be changed', () {
      final box = PencilBox.generate(size, seed: const Seed(7));

      expect(() => box.outline.add(Vec2.zero), throwsUnsupportedError);
      expect(() => box.inner.add(Vec2.zero), throwsUnsupportedError);
    });
  });
}
