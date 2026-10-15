import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/hatching.dart';
import 'package:saviors_paradox/core/rendering/domain/quadratic_pass.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';
import 'package:saviors_paradox/core/rendering/presentation/stroke_paths.dart';

List<Vec2> _circlePoints(Vec2 centre, double radius, int count) => [
      for (var i = 0; i < count; i++)
        centre +
            Vec2(
              math.cos(i / count * 2 * math.pi) * radius,
              math.sin(i / count * 2 * math.pi) * radius,
            ),
    ];

void main() {
  group('StrokePaths', () {
    test('traces a line from its start to its end', () {
      final path = Path();
      const pass = QuadraticPass(
        start: Vec2(0, 0),
        control: Vec2(50, 0),
        end: Vec2(100, 0),
        width: 2.9,
        alpha: 1,
      );

      StrokePaths.traceLine(path, pass);

      expect(path.getBounds().width, closeTo(100, 1));
    });

    test('traces a closed curve around its centre', () {
      final path = Path();
      final points = _circlePoints(const Vec2(50, 50), 20, 16);

      StrokePaths.traceClosedCurve(path, points);

      expect(path.contains(const Offset(50, 50)), isTrue);
      expect(path.getBounds().left, inInclusiveRange(25, 33));
    });

    test('traces a closed polygon', () {
      final path = Path();
      const points = [Vec2(0, 0), Vec2(10, 0), Vec2(10, 10)];

      StrokePaths.tracePolygon(path, points);

      expect(path.contains(const Offset(8, 2)), isTrue);
    });

    test('traces every stroke of the hatching', () {
      final path = Path();
      final hatching = Hatching.generate(
        topLeft: const Vec2(0, 0),
        bottomRight: const Vec2(100, 50),
        gap: 5,
        random: StrokeRandom(const Seed(1)),
      );

      StrokePaths.traceHatching(path, hatching);

      final bounds = path.getBounds();
      expect(bounds.top, -2);
      expect(bounds.bottom, 52);
      expect(path.computeMetrics().length, hatching.lines.length);
    });

    test('replaces what the reused path held', () {
      final path = Path();
      const pass = QuadraticPass(
        start: Vec2(0, 0),
        control: Vec2(50, 100),
        end: Vec2(100, 0),
        width: 2.9,
        alpha: 1,
      );
      const points = [Vec2(0, 0), Vec2(10, 0), Vec2(10, 10)];
      StrokePaths.traceLine(path, pass);

      StrokePaths.tracePolygon(path, points);

      expect(
        path.getBounds(),
        const Rect.fromLTRB(0, 0, 10, 10),
      );
    });
  });
}
