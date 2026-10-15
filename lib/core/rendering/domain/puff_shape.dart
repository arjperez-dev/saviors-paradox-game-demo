import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/hatching.dart';
import 'package:saviors_paradox/core/rendering/domain/line_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// What one puff of ink smoke is, generated once from its seed: an irregular
/// blob of 9 points, its hatching toward the upper left, its wisp, and how it
/// moves and lives (02-art-direction/fx/ink-smoke/ink-smoke.md §2). Points
/// are relative to the puff's centre, at its starting radius.
final class PuffShape {
  PuffShape._({
    required this.radius,
    required List<Vec2> outline,
    required this.hatching,
    required this.wisp,
    required this.velocity,
    required this.life,
  }) : outline = List.unmodifiable(outline);

  factory PuffShape.generate(StrokeRandom random) {
    final radius = random.between(7, 14);
    final side = random.chance(0.5) ? 1.0 : -1.0;
    return PuffShape._(
      radius: radius,
      outline: _outline(radius, random),
      hatching: _hatching(radius, random),
      wisp: LineStroke.generate(
        Vec2(side * radius * 0.4, -radius * 0.6),
        Vec2(side * radius * 1.1, -radius * 1.5),
        width: wispWidth,
        random: random,
      ),
      velocity: Vec2(random.signed() * 25, -random.between(55, 125)),
      life: Seconds(random.between(0.9, 1.5)),
    );
  }

  static const int pointCount = 9;
  static const double wispWidth = 1.3;
  static const double hatchGap = 3;

  final double radius;
  final List<Vec2> outline;

  /// Over the blob shifted toward its upper left; clipped to it when drawn.
  final Hatching hatching;
  final LineStroke wisp;
  final Vec2 velocity;
  final Seconds life;

  static List<Vec2> _outline(double radius, StrokeRandom random) => [
    for (var k = 0; k < pointCount; k++)
      _point(k / pointCount * 2 * math.pi, radius * random.between(0.7, 1.15)),
  ];

  /// The blob is 85 % as tall as it is wide.
  static Vec2 _point(double angle, double reach) =>
      Vec2(math.cos(angle) * reach, math.sin(angle) * reach * 0.85);

  static Hatching _hatching(double radius, StrokeRandom random) {
    final shift = Vec2(-radius * 0.15, -radius * 0.2);
    final reach = Vec2(radius * 1.15, radius * 1.15 * 0.85);
    return Hatching.generate(
      topLeft: shift - reach,
      bottomRight: shift + reach,
      gap: hatchGap,
      random: random,
    );
  }
}
