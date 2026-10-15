import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_stone.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

void main() {
  group('MasonryStone', () {
    test('fills a stone at the top of its wall with a shade of 180 to 200', () {
      final stone = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 0,
        random: StrokeRandom(const Seed(1)),
      );

      expect(stone.shade, greaterThan(180));
      expect(stone.shade, lessThanOrEqualTo(200));
    });

    test('darkens a deep stone by at most 40 more', () {
      final stone = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 1000,
        random: StrokeRandom(const Seed(1)),
      );

      expect(stone.shade, greaterThan(140));
      expect(stone.shade, lessThanOrEqualTo(160));
    });

    test('hatches deeper stones more darkly up to 0.34', () {
      final shallow = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 0,
        random: StrokeRandom(const Seed(1)),
      );
      final deep = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 1000,
        random: StrokeRandom(const Seed(1)),
      );

      expect(shallow.hatchAlpha, closeTo(0.14, 1e-9));
      expect(deep.hatchAlpha, closeTo(0.34, 1e-9));
    });

    test('chips about 35 % of the corners', () {
      var extraPoints = 0;
      var corners = 0;
      for (var seed = 100; seed < 500; seed++) {
        final stone = MasonryStone.cut(
          topLeft: const Vec2(0, 0),
          bottomRight: const Vec2(100, 40),
          depth: 0,
          random: StrokeRandom(Seed(seed)),
        );
        extraPoints += stone.outline.points.length - 4;
        corners += 4;
      }

      expect(extraPoints, greaterThanOrEqualTo((corners * 0.28).ceil()));
      expect(extraPoints, lessThanOrEqualTo((corners * 0.42).floor()));
    });

    test('cracks about 30 % of the stones', () {
      var cracked = 0;
      for (var seed = 100; seed < 500; seed++) {
        final stone = MasonryStone.cut(
          topLeft: const Vec2(0, 0),
          bottomRight: const Vec2(100, 40),
          depth: 0,
          random: StrokeRandom(Seed(seed)),
        );
        if (stone.crack.isNotEmpty) {
          cracked++;
          expect(stone.crack, hasLength(4));
        }
      }

      expect(cracked, greaterThanOrEqualTo(80));
      expect(cracked, lessThanOrEqualTo(160));
    });

    test('pits a stone at most three times', () {
      for (var seed = 100; seed < 500; seed++) {
        final stone = MasonryStone.cut(
          topLeft: const Vec2(0, 0),
          bottomRight: const Vec2(100, 40),
          depth: 0,
          random: StrokeRandom(Seed(seed)),
        );

        expect(stone.pits.length, greaterThanOrEqualTo(0));
        expect(stone.pits.length, lessThanOrEqualTo(3));
      }
    });

    test('cuts the same stone from the same seed', () {
      final first = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 0,
        random: StrokeRandom(const Seed(8)),
      );
      final second = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 0,
        random: StrokeRandom(const Seed(8)),
      );

      expect(first.outline.points, second.outline.points);
      expect(first.shade, second.shade);
      expect(first.pits.length, second.pits.length);
      for (var i = 0; i < first.pits.length; i++) {
        expect(first.pits[i].centre, second.pits[i].centre);
        expect(first.pits[i].radii, second.pits[i].radii);
        expect(first.pits[i].rotation, second.pits[i].rotation);
      }
    });

    test('cuts a different stone from a different seed', () {
      final one = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 0,
        random: StrokeRandom(const Seed(8)),
      );
      final two = MasonryStone.cut(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 40),
        depth: 0,
        random: StrokeRandom(const Seed(9)),
      );

      expect(one.outline.points, isNot(two.outline.points));
    });
  });
}
