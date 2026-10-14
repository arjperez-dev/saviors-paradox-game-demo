final class ZoneNumber implements Comparable<ZoneNumber> {
  const ZoneNumber(this.value) : assert(value >= 1 && value <= 20);

  static const ZoneNumber first = ZoneNumber(1);

  final int value;

  ZoneNumber get next => ZoneNumber(value + 1);

  @override
  int compareTo(ZoneNumber other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) =>
      other is ZoneNumber && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
