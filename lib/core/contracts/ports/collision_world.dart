import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_hit.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point.dart';

abstract interface class CollisionWorld {
  CollisionHit? sweep(WorldBox box, Vec2 displacement);

  CollisionHit? cast(Vec2 from, Vec2 to);

  bool isSolidAt(Vec2 point);

  bool isAbyssAt(Vec2 point);

  bool isStaticSolidAt(Vec2 point);

  /// How far the zone's last step moved [box] with its ground: the
  /// displacement of the platform it stood on, the shift that puts it out
  /// of a platform that rose into it, or `Vec2.zero`. It answers for the
  /// zone's last step, so the zone steps before any body that asks it.
  Vec2 carry(WorldBox box);

  Iterable<HookPoint> hookPointsNear(Vec2 point, double radius);
}
