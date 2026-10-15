import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/hatch_line.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// Parallel strokes over a box, rising to the right at [slope], [gap] apart,
/// each end moved by at most 0.8; whoever draws them clips them to the shape
/// (02-art-direction/strokes/strokes.md §1; the sandbox's `hatchRect`).
final class Hatching {
  Hatching._(List<HatchLine> lines) : lines = List.unmodifiable(lines);

  factory Hatching.generate({
    required Vec2 topLeft,
    required Vec2 bottomRight,
    required double gap,
    required StrokeRandom random,
  }) {
    final height = bottomRight.y - topLeft.y;
    final rise = height * slope;
    return Hatching._([
      for (var x = topLeft.x - rise; x < bottomRight.x + rise; x += gap)
        HatchLine(
          Vec2(x + random.signed() * 0.8, bottomRight.y + 2),
          Vec2(x + rise + random.signed() * 0.8, topLeft.y - 2),
        ),
    ]);
  }

  static const double slope = 0.6;

  final List<HatchLine> lines;
}
