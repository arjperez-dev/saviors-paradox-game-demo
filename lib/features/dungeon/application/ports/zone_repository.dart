import 'package:saviors_paradox/features/dungeon/domain/zone.dart';

/// Where the zone Akeris is in is kept.
abstract interface class ZoneRepository {
  /// The current zone, whole, or null before any zone is generated.
  Zone? load();

  /// Keeps [zone] as the current zone.
  void save(Zone zone);
}
