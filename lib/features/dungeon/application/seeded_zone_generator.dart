import 'package:saviors_paradox/core/contracts/events/zone_entered.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/zone_generator.dart';
import 'package:saviors_paradox/core/contracts/state/zone_state.dart';
import 'package:saviors_paradox/features/dungeon/application/ports/zone_repository.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_reading.dart';
import 'package:saviors_paradox/features/dungeon/domain/biome_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

/// Builds the zone the run asks for, from the run's seed.
final class SeededZoneGenerator implements ZoneGenerator {
  SeededZoneGenerator({
    required List<BiomeKit> kits,
    required this._zones,
    required this._events,
  }) : _kits = List.unmodifiable(kits);

  // One kit per zone number, from zone 1.
  final List<BiomeKit> _kits;
  final ZoneRepository _zones;
  final EventSink _events;

  @override
  ZoneState generate(ZoneNumber zone, Seed seed) {
    if (zone.value > _kits.length) {
      throw StateError('no biome kit for zone ${zone.value} yet');
    }
    final built = const ZoneFactory().create(
      zone,
      _kits[zone.value - 1],
      seed.forZone(zone),
    );
    final created = switch (built) {
      Success<Zone, ZoneFailure>(:final value) => value,
      Failure<Zone, ZoneFailure>(:final reason) => throw StateError(
        'zone ${zone.value} could not be built: ${reason.name}',
      ),
    };
    _zones.save(created);
    _events.publish(ZoneEntered(zone: zone, biome: created.biome));
    return readZoneState(created);
  }
}
