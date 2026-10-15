import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_wall.dart';
import 'package:saviors_paradox/core/rendering/presentation/masonry_painter.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';

void main() {
  group('MasonryPainter', () {
    test('fills a stone with the stone colour of its shade', () {
      expect(
        MasonryPainter.stoneFill(200),
        // 02-art-direction/palette/palette.md §2: stone rgb(200,192,179)
        const Color.fromRGBO(200, 192, 179, 1),
      );
      expect(
        MasonryPainter.stoneFill(171.6),
        const Color.fromRGBO(171, 163, 150, 1),
      );
    });

    test('hatches a stone in ink at its alpha', () {
      final colour = MasonryPainter.stoneHatch(0.3);

      // 02-art-direction/palette/palette.md §1: ink #1a1715
      const ink = Color.fromRGBO(26, 23, 21, 1);
      expect(colour.r, ink.r);
      expect(colour.g, ink.g);
      expect(colour.b, ink.b);
      expect(colour.a, closeTo(0.3, 1e-3));
    });

    test('records a wall into a picture', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(480, 300),
        seed: const Seed(1),
      );

      final picture = MasonryPainter(Pencil()).record(wall);

      expect(picture.approximateBytesUsed, greaterThan(0));
    });
  });
}
