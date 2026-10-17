import 'package:saviors_paradox/features/combat/application/ports/flights_repository.dart';
import 'package:saviors_paradox/features/combat/domain/flights.dart';

/// The projectiles in the air, held in memory for the zone.
final class InMemoryFlightsRepository implements FlightsRepository {
  InMemoryFlightsRepository([Flights? flights])
    : _flights = flights ?? Flights();

  Flights _flights;

  @override
  Flights load() => _flights;

  @override
  void save(Flights flights) => _flights = flights;
}
