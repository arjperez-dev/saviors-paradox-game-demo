import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';

/// Whether a circle reaches a box: the box's point nearest [point] lies
/// within [radius] of it.
final class Reach {
  const Reach();

  bool reaches(WorldBox box, Vec2 point, double radius) {
    final dx = _outside(point.x, box.left, box.right);
    final dy = _outside(point.y, box.top, box.bottom);
    return dx * dx + dy * dy <= radius * radius;
  }

  static double _outside(double value, double low, double high) {
    if (value < low) {
      return low - value;
    }
    return value > high ? value - high : 0;
  }
}
