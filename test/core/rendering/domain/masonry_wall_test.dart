import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_style.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_wall.dart';

void main() {
  group('MasonryWall', () {
    test('lays the same wall from the same seed', () {
      final first = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(9),
      );
      final second = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(9),
      );

      expect(second.stones, hasLength(first.stones.length));
      for (var i = 0; i < first.stones.length; i++) {
        expect(second.stones[i].outline.points, first.stones[i].outline.points);
      }
    });

    test('lays a different wall from a different seed', () {
      final one = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(9),
      );
      final two = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(10),
      );

      final onePoints = one.stones
          .map((stone) => stone.outline.points)
          .toList();
      final twoPoints = two.stones
          .map((stone) => stone.outline.points)
          .toList();

      expect(onePoints, isNot(twoPoints));
    });

    test('lays a top row 30 high above rows 34 to 44 high', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 400),
        seed: const Seed(9),
      );

      final values =
          wall.stones.map((stone) => stone.topLight.main.start.y - 2.5).toList()
            ..sort();
      final tops = <double>[];
      double? previous;
      for (final value in values) {
        if (previous == null || value - previous > 0.4) {
          tops.add(value);
        }
        previous = value;
      }

      expect(tops[0], closeTo(1.8, 0.4));
      expect(tops[1], closeTo(31.8, 0.4));
      for (var i = 2; i < tops.length; i++) {
        final gap = tops[i] - tops[i - 1];
        expect(gap, greaterThanOrEqualTo(34 - 0.6));
        expect(gap, lessThanOrEqualTo(44 + 0.6));
      }
    });

    test('outlines the top edge 3 wide in one line per 160 su', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(9),
      );

      final topEdges = wall.edges.where((edge) => edge.main.width == 3);

      expect(topEdges, hasLength(3));
    });

    test('outlines the sides 2.4 wide down to 360 su at most', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 800),
        seed: const Seed(9),
      );

      final sideEdges = wall.edges
          .where((edge) => edge.main.width == 2.4)
          .toList();
      final lowestY = sideEdges
          .map((edge) => edge.main.end.y)
          .reduce((a, b) => a > b ? a : b);

      expect(sideEdges, isNotEmpty);
      expect(lowestY, closeTo(360, 0.3));
    });

    test('darkens from 24 to 300 su below the top', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(9),
      );

      expect(wall.darkFrom, 24);
      expect(wall.darkTo, 300);
    });

    test('darkens a hanging block toward its top', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(9),
        style: const MasonryStyle(hangs: true),
      );

      expect(wall.darkFrom, 190);
      expect(wall.darkTo, -220);
    });

    test('lays a one-row block as a single row of its full height', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(300, 20),
        seed: const Seed(9),
        style: const MasonryStyle(isOneRow: true),
      );

      for (final stone in wall.stones) {
        for (final point in stone.outline.points) {
          expect(point.y, greaterThanOrEqualTo(-1));
          expect(point.y, lessThanOrEqualTo(21));
        }
      }
    });

    test('leaves out the edges its style turns off', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 200),
        seed: const Seed(9),
        style: const MasonryStyle(hasSideEdges: false),
      );

      expect(wall.edges, hasLength(3));
      expect(wall.edges.every((edge) => edge.main.width == 3), isTrue);
    });
  });
}
