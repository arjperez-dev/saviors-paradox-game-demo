import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/polygon_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// A box's pencil outline and the inner line its focus draws, in hu from
/// its top-left corner, generated once from its seed: the outline from the
/// seed, the inner line from the next one (the 06-ui sandbox's `hudBox`).
final class PencilBox {
  PencilBox._(List<Vec2> outline, List<Vec2> inner)
    : outline = List.unmodifiable(outline),
      inner = List.unmodifiable(inner);

  factory PencilBox.generate(UiVec2 size, {required Seed seed}) {
    final w = size.x;
    final h = size.y;
    return PencilBox._(
      PolygonStroke.generate(
        [Vec2.zero, Vec2(w, 0), Vec2(w, h), Vec2(0, h)],
        random: StrokeRandom(seed),
        jitter: outlineJitter,
      ).points,
      PolygonStroke.generate(
        [
          const Vec2(innerInset, innerInset),
          Vec2(w - innerInset, innerInset),
          Vec2(w - innerInset, h - innerInset),
          Vec2(innerInset, h - innerInset),
        ],
        random: StrokeRandom(Seed(seed.value + 1)),
        jitter: innerJitter,
      ).points,
    );
  }

  // hudBox: `poly(pts, …, .6)`; the focus's inner line `poly(…, 1, .8)`, 4 in.
  static const double outlineJitter = 0.6;
  static const double innerJitter = 0.8;
  static const double innerInset = 4;

  /// The four corners, clockwise from the top left.
  final List<Vec2> outline;

  /// The four corners of the inner line, clockwise from the top left.
  final List<Vec2> inner;
}
