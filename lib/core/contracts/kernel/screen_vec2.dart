import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

extension type const ScreenVec2(Vec2 _value) {
  static const ScreenVec2 zero = ScreenVec2(Vec2.zero);

  double get x => _value.x;

  double get y => _value.y;

  ScreenVec2 operator +(ScreenVec2 other) => ScreenVec2(_value + other._value);

  ScreenVec2 operator -(ScreenVec2 other) => ScreenVec2(_value - other._value);

  ScreenVec2 operator -() => ScreenVec2(-_value);

  ScreenVec2 scaled(double factor) => ScreenVec2(_value.scaled(factor));

  double get length => _value.length;
}
