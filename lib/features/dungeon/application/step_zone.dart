import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/state/zone_state.dart';
import 'package:saviors_paradox/features/dungeon/application/ports/zone_repository.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_reading.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';

/// Advances the current zone by the world step, and shows its snapshot.
final class StepZone {
  StepZone(this._zones);

  final ZoneRepository _zones;

  // A memo of the last snapshot, rebuilt only when the zone or its
  // revision changes: derived, not game state (architecture.md §4, §6.5).
  Zone? _shown;
  int _shownRevision = -1;
  ZoneState? _state;

  ZoneState get state {
    final zone = _zones.load();
    if (zone == null) {
      throw StateError('no zone has been generated yet');
    }
    final shown = _state;
    if (shown != null &&
        identical(zone, _shown) &&
        zone.revision == _shownRevision) {
      return shown;
    }
    _shown = zone;
    _shownRevision = zone.revision;
    return _state = readZoneState(zone);
  }

  void step(Seconds dt) {
    final zone = _zones.load();
    if (zone == null) {
      return;
    }
    zone.advance(dt);
    _zones.save(zone);
  }
}
