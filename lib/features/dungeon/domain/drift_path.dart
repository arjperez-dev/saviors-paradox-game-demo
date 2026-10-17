import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/edges_box.dart';

/// The path of a drifting platform, in su from its room's top left.
final class DriftPath {
  DriftPath({
    required this.left,
    required this.top,
    required this.width,
    required this.travel,
    required this.period,
  }) : assert(width > 0, 'a platform has a width'),
       assert(period.value > 0, 'a platform drifts over some time');

  /// The sandbox's `zoneBuild`: a drifting platform is 44 su thick.
  static const double thickness = 44;

  final double left;
  final double top;
  final double width;
  final Vec2 travel;
  final Seconds period;

  DriftPath mirrored(double roomWidth) => DriftPath(
    left: roomWidth - left - width,
    top: top,
    width: width,
    travel: Vec2(-travel.x, travel.y),
    period: period,
  );

  /// hazards.md: eased out and back along one line, `(1 − cos)/2`, never
  /// a jerk (the sandbox's `zDriftPos`).
  WorldBox boxAt({
    required Vec2 origin,
    required double phase,
    required Seconds time,
  }) {
    final turn = time.value / period.value + phase;
    final eased = (1 - math.cos(2 * math.pi * turn)) / 2;
    final x = origin.x + left + travel.x * eased;
    final y = origin.y + top + travel.y * eased;
    return edgesBox(x, y, x + width, y + thickness);
  }

  @override
  bool operator ==(Object other) =>
      other is DriftPath &&
      other.left == left &&
      other.top == top &&
      other.width == width &&
      other.travel == travel &&
      other.period == period;

  @override
  int get hashCode => Object.hash(left, top, width, travel, period);
}
