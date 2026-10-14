import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';

final class StatusEffectEnded implements GameEvent {
  const StatusEffectEnded({
    required this.target,
    required this.effect,
  });

  final EntityId target;
  final StatusEffectKind effect;
}
