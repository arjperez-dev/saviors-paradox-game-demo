// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_hit.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_world.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point.dart';

final class ZoneCollisionWorld implements CollisionWorld {
  @override
  CollisionHit? sweep(WorldBox box, Vec2 displacement) => null;

  @override
  CollisionHit? cast(Vec2 from, Vec2 to) => null;

  @override
  bool isSolidAt(Vec2 point) => false;

  @override
  bool isAbyssAt(Vec2 point) => false;

  @override
  Iterable<HookPoint> hookPointsNear(Vec2 point, double radius) => const [];
}
