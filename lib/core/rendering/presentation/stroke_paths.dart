import 'dart:ui';

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/rendering/domain/hatching.dart';
import 'package:saviors_paradox/core/rendering/domain/quadratic_pass.dart';

/// Traces the kit's geometry into a [Path] the caller owns and reuses, so
/// that drawing a stroke every frame allocates nothing.
abstract final class StrokePaths {
  /// One pass of a pencil line.
  static void traceLine(Path path, QuadraticPass pass) {
    path
      ..reset()
      ..moveTo(pass.start.x, pass.start.y)
      ..quadraticBezierTo(
        pass.control.x,
        pass.control.y,
        pass.end.x,
        pass.end.y,
      );
  }

  /// A closed curve through the midpoints of [points], each point its
  /// control (the sandbox's `closedCurve`): circles and puffs.
  static void traceClosedCurve(Path path, List<Vec2> points) {
    final last = points.last;
    path
      ..reset()
      ..moveTo((last.x + points.first.x) / 2, (last.y + points.first.y) / 2);
    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      final next = points[(i + 1) % points.length];
      path.quadraticBezierTo(
        point.x,
        point.y,
        (point.x + next.x) / 2,
        (point.y + next.y) / 2,
      );
    }
    path.close();
  }

  /// A closed polygon through [points].
  static void tracePolygon(Path path, List<Vec2> points) {
    path
      ..reset()
      ..moveTo(points.first.x, points.first.y);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].x, points[i].y);
    }
    path.close();
  }

  /// Every stroke of [hatching], as separate segments.
  static void traceHatching(Path path, Hatching hatching) {
    path.reset();
    final lines = hatching.lines;
    for (var i = 0; i < lines.length; i++) {
      path
        ..moveTo(lines[i].from.x, lines[i].from.y)
        ..lineTo(lines[i].to.x, lines[i].to.y);
    }
  }
}
