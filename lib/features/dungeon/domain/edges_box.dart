import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';

/// The box between four edges, in world units, y downward.
WorldBox edgesBox(double left, double top, double right, double bottom) =>
    WorldBox(
      centre: Vec2((left + right) / 2, (top + bottom) / 2),
      halfWidth: (right - left) / 2,
      halfHeight: (bottom - top) / 2,
    );
