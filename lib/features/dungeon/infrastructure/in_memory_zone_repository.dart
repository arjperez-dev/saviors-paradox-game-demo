import 'package:saviors_paradox/features/dungeon/application/ports/zone_repository.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';

/// The current zone, held in memory for the run.
final class InMemoryZoneRepository implements ZoneRepository {
  Zone? _zone;

  @override
  Zone? load() => _zone;

  @override
  void save(Zone zone) => _zone = zone;
}
