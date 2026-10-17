import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';

/// What happened to the status effects of a body.
sealed class StatusEffectEvent {
  const StatusEffectEvent();
}

/// [kind] began on [target], or was extended, to last [duration].
final class StatusStarted extends StatusEffectEvent {
  const StatusStarted({
    required this.target,
    required this.kind,
    required this.duration,
  });

  final EntityId target;
  final StatusEffectKind kind;
  final Seconds duration;

  @override
  bool operator ==(Object other) =>
      other is StatusStarted &&
      other.target == target &&
      other.kind == kind &&
      other.duration == duration;

  @override
  int get hashCode => Object.hash(target, kind, duration);
}

/// [kind] was cleared from [target] before its time ran out.
final class StatusCleared extends StatusEffectEvent {
  const StatusCleared({required this.target, required this.kind});

  final EntityId target;
  final StatusEffectKind kind;

  @override
  bool operator ==(Object other) =>
      other is StatusCleared && other.target == target && other.kind == kind;

  @override
  int get hashCode => Object.hash(target, kind);
}

/// [kind]'s time on [target] ran out.
final class StatusExpired extends StatusEffectEvent {
  const StatusExpired({required this.target, required this.kind});

  final EntityId target;
  final StatusEffectKind kind;

  @override
  bool operator ==(Object other) =>
      other is StatusExpired && other.target == target && other.kind == kind;

  @override
  int get hashCode => Object.hash(target, kind);
}
