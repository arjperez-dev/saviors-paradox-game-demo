import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/combat/domain/reach.dart';

void main() {
  group('Reach', () {
    const reach = Reach();
    const box = WorldBox(centre: Vec2(0, 0), halfWidth: 10, halfHeight: 20);

    test('a point inside the box reaches it at no radius', () {
      expect(reach.reaches(box, const Vec2(5, -15), 0), isTrue);
    });

    test('a point beside the box reaches it only within the radius', () {
      const point = Vec2(20, 0);

      expect(reach.reaches(box, point, 10), isTrue);
      expect(reach.reaches(box, point, 9.99), isFalse);
    });

    test('a point off a corner is measured to the corner', () {
      const point = Vec2(13, 24);

      expect(reach.reaches(box, point, 5), isTrue);
      expect(reach.reaches(box, point, 4.99), isFalse);
    });
  });
}
