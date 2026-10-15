import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_dissolve.dart';
import 'package:saviors_paradox/core/rendering/domain/ink_puff.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_wall.dart';
import 'package:saviors_paradox/core/rendering/domain/paper_overlay.dart';
import 'package:saviors_paradox/core/rendering/domain/pool.dart';
import 'package:saviors_paradox/core/rendering/presentation/ink_dissolve_painter.dart';
import 'package:saviors_paradox/core/rendering/presentation/masonry_painter.dart';
import 'package:saviors_paradox/core/rendering/presentation/paper_overlay_painter.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';

void main() {
  group('the pencil kit, from seed to picture', () {
    test('the same seed lays and paints the same wall', () {
      final first = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(960, 400),
        seed: const Seed(1),
      );
      final second = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(960, 400),
        seed: const Seed(1),
      );

      expect(second.stones, hasLength(first.stones.length));
      for (var i = 0; i < first.stones.length; i++) {
        expect(
          second.stones[i].outline.points,
          first.stones[i].outline.points,
        );
      }

      final painter = MasonryPainter(Pencil());
      final firstPicture = painter.record(first);
      final secondPicture = painter.record(second);

      expect(
        secondPicture.approximateBytesUsed,
        firstPicture.approximateBytesUsed,
      );
    });

    test('nothing trembles from one frame to the next', () {
      final wall = MasonryWall.lay(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(960, 400),
        seed: const Seed(1),
      );
      final before = [
        for (final stone in wall.stones) stone.outline.points,
      ];
      final painter = MasonryPainter(Pencil());

      for (var frame = 0; frame < 60; frame++) {
        painter.record(wall);
      }

      for (var i = 0; i < wall.stones.length; i++) {
        expect(wall.stones[i].outline.points, before[i]);
      }
    });

    test('two bodies dissolve from one pool and leave nothing behind', () {
      final pool = Pool<InkPuff>(size: 60, create: InkPuff.new);
      final first = InkDissolve.prepare(seed: const Seed(1), puffs: pool);
      final second = InkDissolve.prepare(seed: const Seed(2), puffs: pool);
      first.start(const Vec2(100, 500));
      second.start(const Vec2(400, 500));
      final painter = InkDissolvePainter(Pencil());
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);

      const dt = Seconds(1 / 60);
      for (var frame = 0; frame < 198; frame++) {
        first.step(dt);
        second.step(dt);
        painter.paintBody(canvas, first, (canvas) {});
        painter.paintPuffs(canvas, first);
        painter.paintBody(canvas, second, (canvas) {});
        painter.paintPuffs(canvas, second);
      }
      recorder.endRecording();

      expect(first.isFinished, isTrue);
      expect(second.isFinished, isTrue);
      expect(pool.activeCount, 0);
    });

    test('the paper is painted once for the screen it covers', () {
      final overlay = PaperOverlay.scatter(
        size: const Vec2(1066.6667, 600),
        seed: const Seed(99),
      );

      final picture = PaperOverlayPainter().record(overlay);

      expect(picture.approximateBytesUsed, greaterThan(0));
    });
  });
}
