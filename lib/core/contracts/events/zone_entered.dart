import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

/// Delivered only after the zone it names is saved, so `ZoneState.start`
/// is readable when it arrives.
final class ZoneEntered implements GameEvent {
  const ZoneEntered({
    required this.zone,
    required this.biome,
  });

  final ZoneNumber zone;
  final Biome biome;
}
