import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/features/combat/domain/flights.dart';
import 'package:saviors_paradox/features/combat/infrastructure/in_memory_flights_repository.dart';

void main() {
  group('InMemoryFlightsRepository', () {
    test('loads the flights it was given', () {
      final flights = Flights();
      final repository = InMemoryFlightsRepository(flights);

      expect(repository.load(), same(flights));
    });

    test('loads what was saved last', () {
      final repository = InMemoryFlightsRepository(Flights());
      final other = Flights();

      repository.save(other);

      expect(repository.load(), same(other));
    });

    test('starts with nothing in the air', () {
      final repository = InMemoryFlightsRepository();

      expect(repository.load().flyingCount, 0);
    });
  });
}
