import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/island_span.dart';

void main() {
  group('IslandSpan', () {
    test('a mirrored island stands as far from the other edge', () {
      const island = IslandSpan(
        left: 0,
        right: 520,
        top: 700,
        thickness: 80,
        underside: 260,
      );

      final mirrored = island.mirrored(1600);

      expect(mirrored.left, 1080);
      expect(mirrored.right, 1600);
      expect(mirrored.top, 700);
      expect(mirrored.thickness, 80);
      expect(mirrored.underside, 260);
      expect(mirrored.isHanging, false);
    });

    test('an island is solid from its top for its thickness', () {
      const island = IslandSpan(
        left: 0,
        right: 1600,
        top: 700,
        thickness: 80,
        underside: 320,
      );

      final box = island.solidFrom(const Vec2(1600, 2048));

      expect(box.left, 1600);
      expect(box.top, 2748);
      expect(box.right, 3200);
      expect(box.bottom, 2828);
    });
  });
}
