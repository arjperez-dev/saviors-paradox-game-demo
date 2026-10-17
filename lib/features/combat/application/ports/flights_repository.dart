import 'package:saviors_paradox/features/combat/domain/flights.dart';

/// Where the projectiles in the air are kept.
abstract interface class FlightsRepository {
  /// The projectiles in the air, whole.
  Flights load();

  /// Keeps [flights] as the projectiles in the air.
  void save(Flights flights);
}
