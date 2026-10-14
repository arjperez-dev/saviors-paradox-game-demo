import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/hazard_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class HazardBroken implements GameEvent {
  const HazardBroken({
    required this.hazard,
    required this.kind,
    required this.at,
  });

  final EntityId hazard;
  final HazardKind kind;
  final Vec2 at;
}
