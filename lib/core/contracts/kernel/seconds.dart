extension type const Seconds(double value) {
  static const Seconds zero = Seconds(0);

  Seconds operator +(Seconds other) => Seconds(value + other.value);

  Seconds operator -(Seconds other) => Seconds(value - other.value);

  Seconds operator *(double factor) => Seconds(value * factor);

  bool operator <(Seconds other) => value < other.value;

  bool operator <=(Seconds other) => value <= other.value;

  bool operator >(Seconds other) => value > other.value;

  bool operator >=(Seconds other) => value >= other.value;

  Seconds atMost(Seconds maximum) => value > maximum.value ? maximum : this;

  Seconds atLeast(Seconds minimum) => value < minimum.value ? minimum : this;
}
