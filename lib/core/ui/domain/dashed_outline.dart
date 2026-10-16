import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// A closed outline drawn dashed: dashes [on] long with [off] gaps, from
/// the first corner round the outline, a dash going on round a corner
/// (the 06-ui sandbox's `hudBox` with `setLineDash([7, 6])`).
final class DashedOutline {
  DashedOutline._(List<List<Vec2>> dashes) : dashes = List.unmodifiable(dashes);

  factory DashedOutline.along(
    List<Vec2> outline, {
    required double on,
    required double off,
  }) {
    final perimeter = _Perimeter(outline);
    return DashedOutline._([
      for (var start = 0.0; start < perimeter.length; start += on + off)
        perimeter.between(start, math.min(start + on, perimeter.length)),
    ]);
  }

  /// Each dash, as the points of an open line.
  final List<List<Vec2>> dashes;
}

/// The outline as a closed walk: each corner at its distance from the first.
final class _Perimeter {
  _Perimeter(List<Vec2> outline)
    : _points = List.unmodifiable([...outline, outline.first]),
      _distances = List.unmodifiable(_walk([...outline, outline.first]));

  final List<Vec2> _points;
  final List<double> _distances;

  double get length => _distances.last;

  /// The points of the outline from [start] to [end], corners included.
  List<Vec2> between(double start, double end) => List.unmodifiable([
    _at(start),
    for (var i = 0; i < _points.length; i++)
      if (_distances[i] > start && _distances[i] < end) _points[i],
    _at(end),
  ]);

  Vec2 _at(double distance) {
    var i = 0;
    while (i < _distances.length - 2 && _distances[i + 1] < distance) {
      i++;
    }
    final edge = _distances[i + 1] - _distances[i];
    final t = edge == 0 ? 0.0 : (distance - _distances[i]) / edge;
    return _points[i] + (_points[i + 1] - _points[i]).scaled(t);
  }

  static List<double> _walk(List<Vec2> points) {
    final distances = [0.0];
    for (var i = 1; i < points.length; i++) {
      distances.add(distances.last + points[i - 1].distanceTo(points[i]));
    }
    return distances;
  }
}
