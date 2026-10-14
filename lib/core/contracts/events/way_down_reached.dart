import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

final class WayDownReached implements GameEvent {
  const WayDownReached({
    required this.zone,
  });

  final ZoneNumber zone;
}
