import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/ui/domain/dashed_outline.dart';

void main() {
  group('DashedOutline', () {
    // 06-ui/sandbox/sandbox.html `hudBox`: setLineDash([7, 6])
    final outlineA = [
      const Vec2(0, 0),
      const Vec2(20, 0),
      const Vec2(20, 10),
      const Vec2(0, 10),
    ];

    test('the first dash starts at the first corner', () {
      final dashed = DashedOutline.along(outlineA, on: 7, off: 6);

      expect(dashed.dashes.first, [const Vec2(0, 0), const Vec2(7, 0)]);
    });

    test('a dash ending on a corner stops there', () {
      final dashed = DashedOutline.along(outlineA, on: 7, off: 6);

      expect(dashed.dashes[1], [const Vec2(13, 0), const Vec2(20, 0)]);
    });

    test('a dash going round a corner keeps the corner', () {
      final dashed = DashedOutline.along(outlineA, on: 7, off: 6);

      expect(dashed.dashes[2], [
        const Vec2(20, 6),
        const Vec2(20, 10),
        const Vec2(17, 10),
      ]);
    });

    test('the dashes walk the whole outline', () {
      final dashed = DashedOutline.along(outlineA, on: 7, off: 6);

      expect(dashed.dashes.length, 5);
      expect(dashed.dashes[3], [const Vec2(11, 10), const Vec2(4, 10)]);
      expect(dashed.dashes[4], [const Vec2(0, 8), const Vec2(0, 1)]);
    });

    test('a dash past the end stops at the first corner', () {
      final outline = [
        const Vec2(0, 0),
        const Vec2(10, 0),
        const Vec2(10, 5),
        const Vec2(0, 5),
      ];

      final dashed = DashedOutline.along(outline, on: 7, off: 6);

      expect(dashed.dashes.length, 3);
      expect(dashed.dashes.last, [const Vec2(0, 4), const Vec2(0, 0)]);
    });

    test('the dashes cannot be changed', () {
      final dashed = DashedOutline.along(outlineA, on: 7, off: 6);

      expect(() => dashed.dashes.add([]), throwsUnsupportedError);
      expect(
        () => dashed.dashes.first.add(const Vec2(0, 0)),
        throwsUnsupportedError,
      );
    });
  });
}
