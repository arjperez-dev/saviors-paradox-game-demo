import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/drift_path.dart';

void main() {
  group('DriftPath', () {
    test(
      "a platform rests at the start of its path at its phase's start",
      () {
        final path = DriftPath(
          left: 640,
          top: 700,
          width: 320,
          travel: const Vec2(0, 150),
          period: const Seconds(4.2),
        );

        final box = path.boxAt(
          origin: Vec2.zero,
          phase: 0,
          time: Seconds.zero,
        );

        // 04-zones/zone-1-suspended-sanctuary/hazards.md; the sandbox's
        // `zDriftPos`, 44 thick
        expect(box.left, 640);
        expect(box.top, 700);
        expect(box.right, 960);
        expect(box.bottom, 744);
      },
    );

    test('a platform reaches the end of its path at half its period', () {
      final path = DriftPath(
        left: 640,
        top: 700,
        width: 320,
        travel: const Vec2(0, 150),
        period: const Seconds(4.2),
      );

      final box = path.boxAt(
        origin: Vec2.zero,
        phase: 0,
        time: const Seconds(2.1),
      );

      // hazards.md: eased out and back
      expect(box.top, closeTo(850, 1e-9));
    });

    test('a platform starts its path at its phase', () {
      final path = DriftPath(
        left: 640,
        top: 700,
        width: 320,
        travel: const Vec2(0, 150),
        period: const Seconds(4.2),
      );

      final box = path.boxAt(
        origin: Vec2.zero,
        phase: 0.37,
        time: Seconds.zero,
      );

      final expectedTop = 700 + 150 * (1 - math.cos(2 * math.pi * 0.37)) / 2;
      expect(box.top, closeTo(expectedTop, 1e-9));
    });

    test('a mirrored path drifts the other way', () {
      final path = DriftPath(
        left: 1000,
        top: 700,
        width: 240,
        travel: const Vec2(480, 0),
        period: const Seconds(5.2),
      );

      final mirrored = path.mirrored(3200);

      expect(mirrored.left, 1960);
      expect(mirrored.travel, const Vec2(-480, 0));
    });
  });
}
