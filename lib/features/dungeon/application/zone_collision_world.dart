import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_hit.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_world.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point.dart';
import 'package:saviors_paradox/features/dungeon/application/ports/zone_repository.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_reading.dart';

/// The current zone's solid world, as the other features ask it.
final class ZoneCollisionWorld implements CollisionWorld {
  ZoneCollisionWorld(this._zones);

  final ZoneRepository _zones;

  @override
  CollisionHit? sweep(WorldBox box, Vec2 displacement) {
    final contact = _zones.load()?.sweep(box, displacement);
    return contact == null ? null : readContact(contact);
  }

  @override
  CollisionHit? cast(Vec2 from, Vec2 to) {
    final contact = _zones.load()?.cast(from, to);
    return contact == null ? null : readContact(contact);
  }

  @override
  bool isSolidAt(Vec2 point) => _zones.load()?.isSolidAt(point) ?? false;

  @override
  bool isAbyssAt(Vec2 point) => _zones.load()?.isAbyssAt(point) ?? false;

  @override
  Iterable<HookPoint> hookPointsNear(Vec2 point, double radius) {
    final zone = _zones.load();
    return zone == null
        ? const []
        : zone.ringsNear(point, radius).map(readHookPoint);
  }
}
