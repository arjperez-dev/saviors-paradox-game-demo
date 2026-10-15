import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// A pencil polygon: each corner moved by at most [jitter] on each axis
/// (02-art-direction/strokes/strokes.md §1; the sandbox's `poly`).
final class PolygonStroke {
  PolygonStroke._(List<Vec2> points) : points = List.unmodifiable(points);

  factory PolygonStroke.generate(
    List<Vec2> corners, {
    required StrokeRandom random,
    double jitter = defaultJitter,
  }) => PolygonStroke._([
    for (final corner in corners)
      corner + Vec2(random.signed() * jitter, random.signed() * jitter),
  ]);

  /// The sandbox's `poly` default; strokes.md §1 allows 0.3 to 0.7.
  static const double defaultJitter = 0.3;

  final List<Vec2> points;
}
