import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// One stroke of hatching.
final class HatchLine {
  const HatchLine(this.from, this.to);

  final Vec2 from;
  final Vec2 to;

  @override
  bool operator ==(Object other) =>
      other is HatchLine && other.from == from && other.to == to;

  @override
  int get hashCode => Object.hash(from, to);
}
