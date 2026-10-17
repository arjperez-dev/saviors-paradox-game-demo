import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/contact.dart';
import 'package:saviors_paradox/features/dungeon/domain/sweep.dart';

void main() {
  group('Sweep', () {
    const sweep = Sweep();
    const box = WorldBox(centre: Vec2(100, 0), halfWidth: 10, halfHeight: 20);
    const floor = WorldBox(
      centre: Vec2(100, 60),
      halfWidth: 200,
      halfHeight: 10,
    );

    test('a box falling onto a floor stops on its top', () {
      final contact = sweep.box(box, const Vec2(0, 100), [floor]);

      expect(contact, isNotNull);
      expect(contact!.point.x, closeTo(100, 1e-9));
      expect(contact.point.y, closeTo(30, 1e-9));
      expect(contact.normal, const Vec2(0, -1));
      expect(contact.fraction, closeTo(0.3, 1e-9));
    });

    test("a box moving right meets a wall's left face", () {
      const wall = WorldBox(
        centre: Vec2(150, 0),
        halfWidth: 10,
        halfHeight: 100,
      );

      final contact = sweep.box(box, const Vec2(100, 0), [wall]);

      expect(contact, isNotNull);
      expect(contact!.normal, const Vec2(-1, 0));
      expect(contact.fraction, closeTo(0.3, 1e-9));
      expect(contact.point.x, closeTo(130, 1e-9));
      expect(contact.point.y, closeTo(0, 1e-9));
    });

    test('a box that misses every solid meets nothing', () {
      final contact = sweep.box(box, const Vec2(0, -100), [floor]);

      expect(contact, isNull);
    });

    test('the nearest of two solids is met first', () {
      const lower = WorldBox(
        centre: Vec2(100, 100),
        halfWidth: 200,
        halfHeight: 10,
      );

      final contact = sweep.box(box, const Vec2(0, 200), [lower, floor]);

      expect(contact, isNotNull);
      expect(contact!.fraction, closeTo(0.15, 1e-9));
    });

    test('a solid the box already overlaps is passed through', () {
      const overlapping = WorldBox(
        centre: Vec2(100, 55),
        halfWidth: 10,
        halfHeight: 20,
      );

      final contact = sweep.box(overlapping, const Vec2(0, 100), [floor]);

      expect(contact, isNull);
    });

    test('a box standing still meets nothing', () {
      final contact = sweep.box(box, Vec2.zero, [floor]);

      expect(contact, isNull);
    });

    test('a box resting on a floor slides along it', () {
      const resting = WorldBox(
        centre: Vec2(100, 30),
        halfWidth: 10,
        halfHeight: 20,
      );

      final contact = sweep.box(resting, const Vec2(50, 0), [floor]);

      expect(contact, isNull);
    });

    test('a ray meets the first solid on its way', () {
      final contact = sweep.ray(
        const Vec2(100, 0),
        const Vec2(100, 100),
        [floor],
      );

      expect(
        contact,
        const Contact(
          point: Vec2(100, 50),
          normal: Vec2(0, -1),
          fraction: 0.5,
        ),
      );
    });

    test('a ray that ends short of a solid meets nothing', () {
      final contact = sweep.ray(
        const Vec2(100, 0),
        const Vec2(100, 40),
        [floor],
      );

      expect(contact, isNull);
    });
  });
}
