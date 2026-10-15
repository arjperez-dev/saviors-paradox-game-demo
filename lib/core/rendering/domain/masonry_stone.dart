import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/hatching.dart';
import 'package:saviors_paradox/core/rendering/domain/line_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/polygon_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/stone_pit.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// One stone of masonry: chipped corners, a fill that darkens with depth, a
/// light line along its top, hatching over its lower part, maybe a crack and
/// a few pits (02-art-direction/dungeon/dungeon.md §3; the sandbox's `stone`).
final class MasonryStone {
  MasonryStone._({
    required this.outline,
    required this.shade,
    required this.topLight,
    required this.hatching,
    required this.hatchAlpha,
    required List<Vec2> crack,
    required List<StonePit> pits,
  }) : crack = List.unmodifiable(crack),
       pits = List.unmodifiable(pits);

  /// Cuts the stone filling [topLeft]–[bottomRight], [depth] su below the
  /// top of its wall.
  factory MasonryStone.cut({
    required Vec2 topLeft,
    required Vec2 bottomRight,
    required double depth,
    required StrokeRandom random,
  }) {
    final box = _StoneBox(topLeft, bottomRight);
    return MasonryStone._(
      outline: PolygonStroke.generate(
        _chippedCorners(box, random),
        random: random,
        jitter: 0.7,
      ),
      shade: 200 - random.unit() * 20 - math.min(40, depth * 0.12),
      topLight: LineStroke.generate(
        Vec2(box.left + 3, box.top + 2.5),
        Vec2(box.right - 4, box.top + 2.5),
        width: topLightWidth,
        random: random,
      ),
      hatching: _hatching(box, random),
      hatchAlpha: 0.14 + math.min(0.2, depth * 0.001),
      crack: random.chance(0.3) ? _crack(box, random) : const [],
      pits: _pits(box, random),
    );
  }

  static const double outlineWidth = 1.25;
  static const double topLightWidth = 1.2;
  static const double hatchWidth = 0.9;
  static const double crackWidth = 1;

  final PolygonStroke outline;

  /// The red channel of the fill; green is 8 less and blue 21 less
  /// (`stone` in 02-art-direction/palette/palette.md §2).
  final double shade;
  final LineStroke topLight;
  final Hatching hatching;
  final double hatchAlpha;

  /// The crack's polyline from the top edge down; empty when uncracked.
  final List<Vec2> crack;
  final List<StonePit> pits;

  static List<Vec2> _chippedCorners(_StoneBox box, StrokeRandom random) => [
    ..._corner(box.topLeft, const Vec2(0, 1), const Vec2(1, 0), random),
    ..._corner(box.topRight, const Vec2(-1, 0), const Vec2(0, 1), random),
    ..._corner(box.bottomRight, const Vec2(0, -1), const Vec2(-1, 0), random),
    ..._corner(box.bottomLeft, const Vec2(1, 0), const Vec2(0, -1), random),
  ];

  /// A corner, or with probability 0.35 the two ends of a chip 3–8 across.
  static List<Vec2> _corner(
    Vec2 corner,
    Vec2 first,
    Vec2 second,
    StrokeRandom random,
  ) {
    if (!random.chance(0.35)) {
      return [corner];
    }
    final chip = random.between(3, 8);
    return [corner + first.scaled(chip), corner + second.scaled(chip)];
  }

  static Hatching _hatching(_StoneBox box, StrokeRandom random) =>
      Hatching.generate(
        topLeft: Vec2(
          box.left,
          box.top + box.height * random.between(0.35, 0.55),
        ),
        bottomRight: box.bottomRight,
        gap: random.between(4.5, 7.5),
        random: random,
      );

  static List<Vec2> _crack(_StoneBox box, StrokeRandom random) {
    var point = Vec2(box.left + box.width * random.between(0.2, 0.8), box.top);
    final crack = [point];
    for (var k = 0; k < 3; k++) {
      point = point + Vec2(random.signed() * 9, box.height / 3.2);
      crack.add(point);
    }
    return crack;
  }

  static List<StonePit> _pits(_StoneBox box, StrokeRandom random) => [
    for (var k = 0, n = (random.unit() * 4).floor(); k < n; k++)
      StonePit(
        centre: Vec2(
          box.left + 5 + random.unit() * (box.width - 10),
          box.top + 5 + random.unit() * (box.height - 10),
        ),
        radii: Vec2(random.between(1, 2.4), random.between(0.8, 1.8)),
        rotation: random.unit() * 3,
      ),
  ];
}

final class _StoneBox {
  const _StoneBox(this.topLeft, this.bottomRight);

  final Vec2 topLeft;
  final Vec2 bottomRight;

  double get left => topLeft.x;
  double get top => topLeft.y;
  double get right => bottomRight.x;
  double get width => bottomRight.x - topLeft.x;
  double get height => bottomRight.y - topLeft.y;
  Vec2 get topRight => Vec2(right, top);
  Vec2 get bottomLeft => Vec2(left, bottomRight.y);
}
