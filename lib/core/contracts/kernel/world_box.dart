import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class WorldBox {
  const WorldBox({
    required this.centre,
    required this.halfWidth,
    required this.halfHeight,
  }) : assert(halfWidth >= 0),
       assert(halfHeight >= 0);

  final Vec2 centre;
  final double halfWidth;
  final double halfHeight;

  double get left => centre.x - halfWidth;

  double get right => centre.x + halfWidth;

  double get top => centre.y - halfHeight;

  double get bottom => centre.y + halfHeight;

  bool overlaps(WorldBox other) =>
      left < other.right &&
      other.left < right &&
      top < other.bottom &&
      other.top < bottom;

  bool contains(Vec2 point) =>
      point.x >= left &&
      point.x <= right &&
      point.y >= top &&
      point.y <= bottom;

  WorldBox translated(Vec2 offset) => WorldBox(
    centre: centre + offset,
    halfWidth: halfWidth,
    halfHeight: halfHeight,
  );

  @override
  bool operator ==(Object other) =>
      other is WorldBox &&
      other.centre == centre &&
      other.halfWidth == halfWidth &&
      other.halfHeight == halfHeight;

  @override
  int get hashCode => Object.hash(centre, halfWidth, halfHeight);
}
