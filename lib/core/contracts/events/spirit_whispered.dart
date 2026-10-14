import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class SpiritWhispered implements GameEvent {
  const SpiritWhispered({
    required this.spirit,
    required this.pitch,
    required this.syllables,
  });

  final EntityId spirit;
  final double pitch;
  final int syllables;
}
