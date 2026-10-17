import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/wall_span.dart';

void main() {
  group('WallSpan', () {
    test('a wall is solid where it stands, mirrored or not', () {
      const wall = WallSpan(left: 0, top: 160, right: 60, bottom: 700);

      final solid = wall.solidFrom(Vec2.zero);
      final mirrored = wall.mirrored(1600);

      expect(solid.left, 0);
      expect(solid.top, 160);
      expect(solid.right, 60);
      expect(solid.bottom, 700);
      expect(mirrored.left, 1540);
      expect(mirrored.right, 1600);
      expect(mirrored.top, 160);
      expect(mirrored.bottom, 700);
    });
  });
}
