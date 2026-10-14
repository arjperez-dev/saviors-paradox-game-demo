import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_hit.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point.dart';

abstract interface class CollisionWorld {
  CollisionHit? sweep(WorldBox box, Vec2 displacement);

  CollisionHit? cast(Vec2 from, Vec2 to);

  bool isSolidAt(Vec2 point);

  bool isAbyssAt(Vec2 point);

  Iterable<HookPoint> hookPointsNear(Vec2 point, double radius);
}
