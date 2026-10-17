import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// Where a moving box or a ray first met a solid.
final class Contact {
  const Contact({
    required this.point,
    required this.normal,
    required this.fraction,
  }) : assert(fraction >= 0 && fraction <= 1, 'a contact lies on the move');

  final Vec2 point;
  final Vec2 normal;
  final double fraction;

  @override
  bool operator ==(Object other) =>
      other is Contact &&
      other.point == point &&
      other.normal == normal &&
      other.fraction == fraction;

  @override
  int get hashCode => Object.hash(point, normal, fraction);
}
