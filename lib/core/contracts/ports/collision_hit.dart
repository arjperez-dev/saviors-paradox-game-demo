import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class CollisionHit {
  const CollisionHit({
    required this.point,
    required this.normal,
    required this.fraction,
  });

  final Vec2 point;
  final Vec2 normal;
  final double fraction;
}
