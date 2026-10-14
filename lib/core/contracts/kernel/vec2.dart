import 'dart:math' as math;


final class Vec2 {
  const Vec2(this.x, this.y);

  static const Vec2 zero = Vec2(0, 0);

  final double x;
  final double y;

  Vec2 operator +(Vec2 other) => Vec2(x + other.x, y + other.y);

  Vec2 operator -(Vec2 other) => Vec2(x - other.x, y - other.y);

  Vec2 operator -() => Vec2(-x, -y);

  Vec2 scaled(double factor) => Vec2(x * factor, y * factor);

  double dot(Vec2 other) => x * other.x + y * other.y;

  double get length => math.sqrt(dot(this));

  double distanceTo(Vec2 other) => (this - other).length;

  @override
  bool operator ==(Object other) =>
      other is Vec2 && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Vec2($x, $y)';
}
