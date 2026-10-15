import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// A pencil circle: 16 points around the centre, each radius moved by at
/// most min(0.8, 6 %), closed through quadratic midpoints when traced
/// (02-art-direction/strokes/strokes.md §1; the sandbox's `scircle`).
final class CircleStroke {
  CircleStroke._(List<Vec2> points) : points = List.unmodifiable(points);

  factory CircleStroke.generate(
    Vec2 centre,
    double radius, {
    required StrokeRandom random,
    Vec2 stretch = const Vec2(1, 1),
  }) {
    final turn = random.unit() * 2 * math.pi;
    final wobble = math.min(0.8, radius * 0.06);
    return CircleStroke._([
      for (var k = 0; k < pointCount; k++)
        _point(
          centre,
          turn + k / pointCount * 2 * math.pi,
          radius + random.signed() * wobble,
          stretch,
        ),
    ]);
  }

  static const int pointCount = 16;

  final List<Vec2> points;

  static Vec2 _point(Vec2 centre, double angle, double radius, Vec2 stretch) =>
      centre +
      Vec2(
        math.cos(angle) * radius * stretch.x,
        math.sin(angle) * radius * stretch.y,
      );
}
