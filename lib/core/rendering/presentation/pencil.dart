import 'dart:ui';

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/hatching.dart';
import 'package:saviors_paradox/core/rendering/domain/line_stroke.dart';
import 'package:saviors_paradox/core/rendering/domain/quadratic_pass.dart';
import 'package:saviors_paradox/core/rendering/presentation/stroke_paths.dart';

/// Draws the kit's geometry on a canvas with one [Path] and one [Paint],
/// reused for every stroke: round caps and joins
/// (02-art-direction/strokes/strokes.md §1).
final class Pencil {
  final Path _path = Path();
  final Paint _paint = Paint()
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  /// The colour of a pass: [color] with its alpha times the pass's.
  static Color passColor(Color color, QuadraticPass pass) =>
      color.withValues(alpha: color.a * pass.alpha);

  /// A pencil line and its second pass, widths times [widthScale].
  void line(
    Canvas canvas,
    LineStroke line,
    Color color, {
    double widthScale = 1,
  }) {
    _pass(canvas, line.main, color, widthScale);
    final second = line.second;
    if (second != null) {
      _pass(canvas, second, color, widthScale);
    }
  }

  void fillPolygon(Canvas canvas, List<Vec2> points, Color color) {
    StrokePaths.tracePolygon(_path, points);
    _fill(canvas, color);
  }

  void outlinePolygon(
    Canvas canvas,
    List<Vec2> points,
    double width,
    Color color,
  ) {
    StrokePaths.tracePolygon(_path, points);
    _stroke(canvas, width, color);
  }

  void fillCurve(Canvas canvas, List<Vec2> points, Color color) {
    StrokePaths.traceClosedCurve(_path, points);
    _fill(canvas, color);
  }

  void outlineCurve(
    Canvas canvas,
    List<Vec2> points,
    double width,
    Color color,
  ) {
    StrokePaths.traceClosedCurve(_path, points);
    _stroke(canvas, width, color);
  }

  /// Saves the canvas and clips it to the polygon through [points]; the
  /// caller restores it.
  void clipToPolygon(Canvas canvas, List<Vec2> points) {
    StrokePaths.tracePolygon(_path, points);
    canvas
      ..save()
      ..clipPath(_path);
  }

  /// Saves the canvas and clips it to the closed curve through [points];
  /// the caller restores it.
  void clipToCurve(Canvas canvas, List<Vec2> points) {
    StrokePaths.traceClosedCurve(_path, points);
    canvas
      ..save()
      ..clipPath(_path);
  }

  void hatch(Canvas canvas, Hatching hatching, Color color, double width) {
    StrokePaths.traceHatching(_path, hatching);
    _stroke(canvas, width, color);
  }

  void _pass(Canvas canvas, QuadraticPass pass, Color color, double scale) {
    StrokePaths.traceLine(_path, pass);
    _stroke(canvas, pass.width * scale, passColor(color, pass));
  }

  void _fill(Canvas canvas, Color color) {
    _paint
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawPath(_path, _paint);
  }

  void _stroke(Canvas canvas, double width, Color color) {
    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..color = color;
    canvas.drawPath(_path, _paint);
  }
}
