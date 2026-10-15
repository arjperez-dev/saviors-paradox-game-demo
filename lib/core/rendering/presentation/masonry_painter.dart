import 'dart:ui';

import 'package:saviors_paradox/core/rendering/domain/masonry_stone.dart';
import 'package:saviors_paradox/core/rendering/domain/masonry_wall.dart';
import 'package:saviors_paradox/core/rendering/domain/stone_pit.dart';
import 'package:saviors_paradox/core/rendering/presentation/palette.dart';
import 'package:saviors_paradox/core/rendering/presentation/pencil.dart';

/// Paints a [MasonryWall] once, into a picture the zone draws every frame
/// (02-art-direction/dungeon/dungeon.md §1, §3; the sandbox's `masonry`).
final class MasonryPainter {
  MasonryPainter(this._pencil);

  final Pencil _pencil;
  final Paint _paint = Paint();

  /// A stone's outline: `ink` at 0.85 (the sandbox's `stone`).
  static const Color stoneOutline = Color.fromRGBO(26, 23, 21, 0.85);

  /// A crack: `ink` at 0.7; a pit: `ink` at 0.35 (the sandbox's `stone`).
  static const Color crackColor = Color.fromRGBO(26, 23, 21, 0.7);
  static const Color pitColor = Color.fromRGBO(26, 23, 21, 0.35);

  /// The `depth` gradient reaches this alpha (palette.md §2).
  static const double deepestDark = 0.78;

  /// `stone`: the shade, its green 8 less and its blue 21 less
  /// (palette.md §2).
  static Color stoneFill(double shade) {
    final red = shade.floor();
    return Color.fromRGBO(red, red - 8, red - 21, 1);
  }

  /// The stone's hatching: `ink` at [alpha].
  static Color stoneHatch(double alpha) => Palette.ink.withValues(alpha: alpha);

  Picture record(MasonryWall wall) {
    final recorder = PictureRecorder();
    paint(Canvas(recorder), wall);
    return recorder.endRecording();
  }

  void paint(Canvas canvas, MasonryWall wall) {
    final bounds = Rect.fromLTRB(
      wall.topLeft.x,
      wall.topLeft.y,
      wall.bottomRight.x,
      wall.bottomRight.y,
    );
    canvas
      ..save()
      ..clipRect(bounds)
      ..drawRect(bounds, _paint..color = Palette.mortar);
    for (final stone in wall.stones) {
      _stone(canvas, stone);
    }
    canvas
      ..drawRect(bounds, _paint..shader = _depth(wall))
      ..restore();
    _paint.shader = null;
    for (final edge in wall.edges) {
      _pencil.line(canvas, edge, Palette.ink);
    }
  }

  void _stone(Canvas canvas, MasonryStone stone) {
    final outline = stone.outline.points;
    _pencil
      ..fillPolygon(canvas, outline, stoneFill(stone.shade))
      ..outlinePolygon(
        canvas,
        outline,
        MasonryStone.outlineWidth,
        stoneOutline,
      )
      ..line(canvas, stone.topLight, Palette.stoneEdge)
      ..clipToPolygon(canvas, outline)
      ..hatch(
        canvas,
        stone.hatching,
        stoneHatch(stone.hatchAlpha),
        MasonryStone.hatchWidth,
      );
    canvas.restore();
    _crack(canvas, stone);
    for (final pit in stone.pits) {
      _pit(canvas, pit);
    }
  }

  void _crack(Canvas canvas, MasonryStone stone) {
    if (stone.crack.isEmpty) {
      return;
    }
    final path = Path()..moveTo(stone.crack.first.x, stone.crack.first.y);
    for (final point in stone.crack.skip(1)) {
      path.lineTo(point.x, point.y);
    }
    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = MasonryStone.crackWidth
      ..color = crackColor;
    canvas.drawPath(path, _paint);
    _paint.style = PaintingStyle.fill;
  }

  void _pit(Canvas canvas, StonePit pit) {
    canvas
      ..save()
      ..translate(pit.centre.x, pit.centre.y)
      ..rotate(pit.rotation)
      ..drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: pit.radii.x * 2,
          height: pit.radii.y * 2,
        ),
        _paint..color = pitColor,
      )
      ..restore();
  }

  static Shader _depth(MasonryWall wall) => Gradient.linear(
    Offset(0, wall.darkFrom),
    Offset(0, wall.darkTo),
    [
      Palette.darkness.withValues(alpha: 0),
      Palette.darkness.withValues(alpha: deepestDark),
    ],
  );
}
