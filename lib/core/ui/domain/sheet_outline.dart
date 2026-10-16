import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/polygon_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// A paper sheet's pencil border and its faint inner line, in hu from its
/// top-left corner, generated once from its seed: the border from the
/// seed, the inner line from the next one (the 06-ui sandbox's `sheetAt`).
final class SheetOutline {
  SheetOutline._(List<Vec2> border, List<Vec2> inner)
    : border = List.unmodifiable(border),
      inner = List.unmodifiable(inner);

  factory SheetOutline.generate(UiVec2 size, {required Seed seed}) {
    final w = size.x;
    final h = size.y;
    return SheetOutline._(
      PolygonStroke.generate(
        [Vec2.zero, Vec2(w, 2), Vec2(w - 2, h), Vec2(2, h - 1)],
        random: StrokeRandom(seed),
        jitter: borderJitter,
      ).points,
      PolygonStroke.generate(
        [
          const Vec2(12, 12),
          Vec2(w - 12, 13),
          Vec2(w - 13, h - 12),
          Vec2(12, h - 13),
        ],
        random: StrokeRandom(Seed(seed.value + 1)),
        jitter: innerJitter,
      ).points,
    );
  }

  // sheetAt: the border `poly(pts, …, .8)`, the inner line `poly(…, 1)`.
  static const double borderJitter = 0.8;
  static const double innerJitter = 1;

  /// The four corners, clockwise from the top left, slightly out of square.
  final List<Vec2> border;

  /// The four corners of the inner line, 12 in.
  final List<Vec2> inner;

  // architecture.md §4: a value object is equal by value.
  @override
  bool operator ==(Object other) =>
      other is SheetOutline &&
      _sameCorners(border, other.border) &&
      _sameCorners(inner, other.inner);

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(border), Object.hashAll(inner));

  static bool _sameCorners(List<Vec2> a, List<Vec2> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
