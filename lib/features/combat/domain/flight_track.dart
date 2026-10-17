import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/combat/domain/flight_id.dart';

/// Where a flight went in its last step, and who threw it.
final class FlightTrack {
  const FlightTrack({
    required this.id,
    required this.thrower,
    required this.from,
    required this.to,
    required this.radius,
  }) : assert(radius > 0, 'a flight has some size');

  final FlightId id;
  final EntityId thrower;
  final Vec2 from;
  final Vec2 to;
  final double radius;

  @override
  bool operator ==(Object other) =>
      other is FlightTrack &&
      other.id == id &&
      other.thrower == thrower &&
      other.from == from &&
      other.to == to &&
      other.radius == radius;

  @override
  int get hashCode => Object.hash(id, thrower, from, to, radius);
}
