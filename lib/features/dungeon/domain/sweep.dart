import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/contact.dart';

/// Where a moving box first meets a solid: its centre swept through each
/// solid grown by the box's half sizes.
final class Sweep {
  const Sweep();

  /// The earliest contact of [box] moved by [displacement] with any of
  /// [solids]: where its centre stops, the face it meets and the fraction
  /// of the move done. A solid [box] already overlaps is passed through.
  Contact? box(WorldBox box, Vec2 displacement, List<WorldBox> solids) {
    Contact? first;
    for (var i = 0; i < solids.length; i++) {
      final solid = solids[i];
      if (solid.overlaps(box)) {
        continue;
      }
      final contact = _enter(box.centre, displacement, solid, box);
      if (contact != null &&
          (first == null || contact.fraction < first.fraction)) {
        first = contact;
      }
    }
    return first;
  }

  /// The earliest contact of the ray from [from] to [to] with [solids].
  Contact? ray(Vec2 from, Vec2 to, List<WorldBox> solids) => box(
    WorldBox(centre: from, halfWidth: 0, halfHeight: 0),
    to - from,
    solids,
  );

  Contact? _enter(Vec2 origin, Vec2 move, WorldBox solid, WorldBox box) {
    final (left, right, top, bottom) = _grown(solid, box);
    final enterX = _entry(origin.x, move.x, left, right);
    final enterY = _entry(origin.y, move.y, top, bottom);
    final enter = math.max(enterX, enterY);
    final exit = math.min(
      _exit(origin.x, move.x, left, right),
      _exit(origin.y, move.y, top, bottom),
    );
    if (enter > exit || enter < 0 || enter > 1) {
      return null;
    }
    return Contact(
      point: origin + move.scaled(enter),
      normal: enterX > enterY
          ? Vec2(move.x > 0 ? -1 : 1, 0)
          : Vec2(0, move.y > 0 ? -1 : 1),
      fraction: enter,
    );
  }

  static (double, double, double, double) _grown(
    WorldBox solid,
    WorldBox box,
  ) => (
    solid.left - box.halfWidth,
    solid.right + box.halfWidth,
    solid.top - box.halfHeight,
    solid.bottom + box.halfHeight,
  );

  static double _entry(double origin, double move, double low, double high) {
    if (move == 0) {
      return origin > low && origin < high
          ? double.negativeInfinity
          : double.infinity;
    }
    return math.min((low - origin) / move, (high - origin) / move);
  }

  static double _exit(double origin, double move, double low, double high) {
    if (move == 0) {
      return origin > low && origin < high
          ? double.infinity
          : double.negativeInfinity;
    }
    return math.max((low - origin) / move, (high - origin) / move);
  }
}
