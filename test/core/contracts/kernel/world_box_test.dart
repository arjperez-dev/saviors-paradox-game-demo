import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';

void main() {
  group('WorldBox', () {
    test('places its edges around its centre', () {
      const box = WorldBox(
        centre: Vec2(10, 20),
        halfWidth: 4,
        halfHeight: 6,
      );

      expect(box.left, 6);
      expect(box.right, 14);
      expect(box.top, 14);
      expect(box.bottom, 26);
    });

    test('overlaps a box it shares area with', () {
      const box = WorldBox(centre: Vec2(10, 20), halfWidth: 4, halfHeight: 6);
      const other = WorldBox(
        centre: Vec2(16, 20),
        halfWidth: 4,
        halfHeight: 6,
      );

      expect(box.overlaps(other), isTrue);
    });

    test('does not overlap a box that only touches its edge', () {
      const box = WorldBox(centre: Vec2(10, 20), halfWidth: 4, halfHeight: 6);
      const other = WorldBox(
        centre: Vec2(18, 20),
        halfWidth: 4,
        halfHeight: 6,
      );

      expect(box.overlaps(other), isFalse);
    });

    test('contains a point on its edge', () {
      const box = WorldBox(centre: Vec2(10, 20), halfWidth: 4, halfHeight: 6);

      expect(box.contains(const Vec2(6, 26)), isTrue);
      expect(box.contains(const Vec2(5.9, 20)), isFalse);
    });

    test('moves by an offset without changing its size', () {
      const box = WorldBox(centre: Vec2(10, 20), halfWidth: 4, halfHeight: 6);

      final moved = box.translated(const Vec2(1, -1));

      expect(moved.centre, const Vec2(11, 19));
      expect(moved.halfWidth, 4);
      expect(moved.halfHeight, 6);
    });

    test('rejects a negative half size', () {
      expect(
        () => WorldBox(centre: Vec2.zero, halfWidth: -1, halfHeight: 1),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
