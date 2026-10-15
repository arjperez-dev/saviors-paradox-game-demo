import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

extension type const UiVec2(Vec2 _value) {
  static const UiVec2 zero = UiVec2(Vec2.zero);

  static const double referenceWidth = 1920;

  static const double referenceHeight = 1080;

  double get x => _value.x;

  double get y => _value.y;

  UiVec2 operator +(UiVec2 other) => UiVec2(_value + other._value);

  UiVec2 operator -(UiVec2 other) => UiVec2(_value - other._value);

  UiVec2 operator -() => UiVec2(-_value);

  UiVec2 scaled(double factor) => UiVec2(_value.scaled(factor));

  double get length => _value.length;
}
