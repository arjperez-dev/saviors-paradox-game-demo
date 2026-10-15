import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/line_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_stone.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_style.dart';
import 'package:saviors_paradox/core/rendering/domain/stroke_random.dart';

/// A rectangle of masonry, generated once from its seed: rows of stones over
/// mortar, a darkness gradient, and ink edges — the top one, which is stood
/// on, the thickest (02-art-direction/dungeon/dungeon.md §3; the sandbox's
/// `masonry`).
final class MasonryWall {
  MasonryWall._({
    required this.topLeft,
    required this.bottomRight,
    required List<MasonryStone> stones,
    required List<LineStroke> edges,
    required this.darkFrom,
    required this.darkTo,
  }) : stones = List.unmodifiable(stones),
       edges = List.unmodifiable(edges);

  factory MasonryWall.lay({
    required Vec2 topLeft,
    required Vec2 bottomRight,
    required Seed seed,
    MasonryStyle style = const MasonryStyle(),
  }) {
    final random = StrokeRandom(seed);
    final stones = _stones(topLeft, bottomRight, style, random);
    final hangs = style.hangs;
    return MasonryWall._(
      topLeft: topLeft,
      bottomRight: bottomRight,
      stones: stones,
      edges: _edges(topLeft, bottomRight, style, random),
      darkFrom: hangs ? bottomRight.y - 10 : topLeft.y + 24,
      darkTo: hangs ? bottomRight.y - 420 : topLeft.y + 300,
    );
  }

  static const double topRowHeight = 30;
  static const double mortarGap = 1.8;
  static const double topEdgeWidth = 3;
  static const double bottomEdgeWidth = 2.6;
  static const double sideEdgeWidth = 2.4;

  /// An edge is drawn as one line per 160 su of its length.
  static const double edgeSegment = 160;

  /// The side edges reach at most this far down from the top.
  static const double sideEdgeReach = 360;

  final Vec2 topLeft;
  final Vec2 bottomRight;
  final List<MasonryStone> stones;
  final List<LineStroke> edges;

  /// The y where the `depth` gradient is clear (palette.md §2).
  final double darkFrom;

  /// The y where the `depth` gradient reaches 0.78.
  final double darkTo;

  static List<MasonryStone> _stones(
    Vec2 topLeft,
    Vec2 bottomRight,
    MasonryStyle style,
    StrokeRandom random,
  ) {
    final stones = <MasonryStone>[];
    var y = topLeft.y;
    for (var row = 0; y < bottomRight.y; row++) {
      final course = _Row(
        left: topLeft.x,
        right: bottomRight.x,
        top: y,
        height: _rowHeight(row, topLeft, bottomRight, style, random),
        depth: y - topLeft.y,
      );
      _layRow(stones, course, random);
      y += course.height;
    }
    return stones;
  }

  static double _rowHeight(
    int row,
    Vec2 topLeft,
    Vec2 bottomRight,
    MasonryStyle style,
    StrokeRandom random,
  ) {
    if (row > 0) {
      return random.between(34, 44);
    }
    return style.isOneRow ? bottomRight.y - topLeft.y : topRowHeight;
  }

  static void _layRow(
    List<MasonryStone> stones,
    _Row row,
    StrokeRandom random,
  ) {
    var x = row.left - random.unit() * 60;
    while (x < row.right) {
      final width = random.between(58, 130);
      stones.add(
        MasonryStone.cut(
          topLeft: Vec2(x + mortarGap, row.top + mortarGap),
          bottomRight: Vec2(x + width - mortarGap, row.bottom - mortarGap),
          depth: row.depth,
          random: random,
        ),
      );
      x += width;
    }
  }

  static List<LineStroke> _edges(
    Vec2 topLeft,
    Vec2 bottomRight,
    MasonryStyle style,
    StrokeRandom random,
  ) {
    final sideBottom = math.min(bottomRight.y, topLeft.y + sideEdgeReach);
    final topRight = Vec2(bottomRight.x, topLeft.y);
    final bottomLeft = Vec2(topLeft.x, bottomRight.y);
    return [
      if (style.hasTopEdge) ..._edge(topLeft, topRight, topEdgeWidth, random),
      if (style.hasBottomEdge)
        ..._edge(bottomLeft, bottomRight, bottomEdgeWidth, random),
      if (style.hasSideEdges) ...[
        ..._edge(topLeft, Vec2(topLeft.x, sideBottom), sideEdgeWidth, random),
        ..._edge(topRight, Vec2(topRight.x, sideBottom), sideEdgeWidth, random),
      ],
    ];
  }

  static List<LineStroke> _edge(
    Vec2 from,
    Vec2 to,
    double width,
    StrokeRandom random,
  ) {
    final pieces = math.max(1, (from.distanceTo(to) / edgeSegment).round());
    final step = (to - from).scaled(1 / pieces);
    return [
      for (var i = 0; i < pieces; i++)
        LineStroke.generate(
          from + step.scaled(i.toDouble()),
          from + step.scaled(i + 1.0),
          width: width,
          random: random,
        ),
    ];
  }
}

final class _Row {
  const _Row({
    required this.left,
    required this.right,
    required this.top,
    required this.height,
    required this.depth,
  });

  final double left;
  final double right;
  final double top;
  final double height;

  /// How far below the top of the wall the row starts.
  final double depth;

  double get bottom => top + height;
}
