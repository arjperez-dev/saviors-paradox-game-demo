import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/polygon_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';
import 'package:saviors_paradox/core/ui/domain/sheet_outline.dart';

void main() {
  group('SheetOutline', () {
    const size = UiVec2(Vec2(1680, 960));

    test('the same seed gives the same sheet', () {
      final first = SheetOutline.generate(size, seed: const Seed(30000));
      final second = SheetOutline.generate(size, seed: const Seed(30000));

      expect(first.border, second.border);
      expect(first.inner, second.inner);
    });

    test('different seeds give different sheets', () {
      final one = SheetOutline.generate(size, seed: const Seed(1));
      final two = SheetOutline.generate(size, seed: const Seed(2));

      expect(one.border, isNot(two.border));
    });

    test('sheets with equal corners are equal by value', () {
      // architecture.md §4: a value object is equal by value.
      final one = SheetOutline.generate(size, seed: const Seed(30000));
      final two = SheetOutline.generate(size, seed: const Seed(30000));
      final other = SheetOutline.generate(size, seed: const Seed(1));

      expect(one, equals(two));
      expect(one.hashCode, two.hashCode);
      expect(one, isNot(equals(other)));
    });

    test('the border is slightly out of square', () {
      // 06-ui/sandbox/sandbox.html `sheetAt`: poly(pts, …, .8).
      const corners = [
        Vec2(0, 0),
        Vec2(1680, 2),
        Vec2(1678, 960),
        Vec2(2, 959),
      ];
      for (var seed = 1; seed <= 50; seed++) {
        final sheet = SheetOutline.generate(size, seed: Seed(seed));

        expect(sheet.border, hasLength(4));
        for (var i = 0; i < corners.length; i++) {
          expect(
            sheet.border[i].x,
            inInclusiveRange(corners[i].x - 0.8, corners[i].x + 0.8),
          );
          expect(
            sheet.border[i].y,
            inInclusiveRange(corners[i].y - 0.8, corners[i].y + 0.8),
          );
        }
      }
    });

    test('the inner line sits 12 in', () {
      // 06-ui/sandbox/sandbox.html `sheetAt`; 06-ui/pause-menu/pause-menu.md
      // §3: inset 12, poly(…, 1).
      const corners = [
        Vec2(12, 12),
        Vec2(1668, 13),
        Vec2(1667, 948),
        Vec2(12, 947),
      ];
      for (var seed = 1; seed <= 50; seed++) {
        final sheet = SheetOutline.generate(size, seed: Seed(seed));

        expect(sheet.inner, hasLength(4));
        for (var i = 0; i < corners.length; i++) {
          expect(
            sheet.inner[i].x,
            inInclusiveRange(corners[i].x - 1, corners[i].x + 1),
          );
          expect(
            sheet.inner[i].y,
            inInclusiveRange(corners[i].y - 1, corners[i].y + 1),
          );
        }
      }
    });

    test('the inner line comes from the next seed', () {
      final sheet = SheetOutline.generate(size, seed: const Seed(30000));
      // 06-ui/sandbox/sandbox.html `sheetAt`: seed(id + 1) before the inner
      // line's poly.
      final expected = PolygonStroke.generate(
        const [
          Vec2(12, 12),
          Vec2(1668, 13),
          Vec2(1667, 948),
          Vec2(12, 947),
        ],
        random: StrokeRandom(const Seed(30001)),
        jitter: 1,
      );

      expect(sheet.inner, expected.points);
    });

    test('the corners cannot be changed', () {
      final sheet = SheetOutline.generate(size, seed: const Seed(30000));

      expect(() => sheet.border.add(Vec2.zero), throwsUnsupportedError);
      expect(() => sheet.inner.add(Vec2.zero), throwsUnsupportedError);
    });
  });
}
