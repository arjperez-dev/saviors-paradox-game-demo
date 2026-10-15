import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

void main() {
  group('Vec2', () {
    test('adds two vectors', () {
      expect(const Vec2(1, 2) + const Vec2(3, 4), const Vec2(4, 6));
    });

    test('subtracts one vector from another', () {
      expect(const Vec2(3, 4) - const Vec2(1, 2), const Vec2(2, 2));
    });

    test('negates a vector', () {
      expect(-const Vec2(1, -2), const Vec2(-1, 2));
    });

    test('scales a vector by a factor', () {
      expect(const Vec2(1, -2).scaled(3), const Vec2(3, -6));
    });

    test('computes the dot product', () {
      expect(const Vec2(1, 2).dot(const Vec2(3, 4)), 11);
    });

    test('measures its length and the distance to another point', () {
      expect(const Vec2(3, 4).length, closeTo(5, 1e-9));
      expect(const Vec2(1, 1).distanceTo(const Vec2(4, 5)), closeTo(5, 1e-9));
    });
  });
}
