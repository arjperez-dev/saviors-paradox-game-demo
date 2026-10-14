import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';

final class StatusEffectApplied implements GameEvent {
  const StatusEffectApplied({
    required this.target,
    required this.effect,
    required this.duration,
  });

  final EntityId target;
  final StatusEffectKind effect;
  final Seconds duration;
}
