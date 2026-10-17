import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/status_effect_event.dart';

/// Every status effect on every body, and the time each has left.
final class StatusEffects {
  // Below this, a sum of repeated dt subtractions that should have reached
  // zero exactly is treated as expired; well under any real dt.
  static const Seconds _epsilon = Seconds(1e-9);

  // Parallel lists, one entry per body and kind, in the order applied.
  final List<EntityId> _targets = [];
  final List<StatusEffectKind> _kinds = [];
  final List<Seconds> _left = [];

  bool has(EntityId target, StatusEffectKind kind) =>
      _indexOf(target, kind) >= 0;

  Seconds remaining(EntityId target, StatusEffectKind kind) {
    final index = _indexOf(target, kind);
    return index < 0 ? Seconds.zero : _left[index];
  }

  /// Starts [kind] on [target] for [duration], or extends it to
  /// [duration]; null when [duration] is no time or does not outlast the
  /// effect already running.
  StatusStarted? apply(
    EntityId target,
    StatusEffectKind kind,
    Seconds duration,
  ) {
    if (duration <= Seconds.zero) {
      return null;
    }
    final index = _indexOf(target, kind);
    if (index >= 0 && duration <= _left[index]) {
      return null;
    }
    if (index < 0) {
      _targets.add(target);
      _kinds.add(kind);
      _left.add(duration);
    } else {
      _left[index] = duration;
    }
    return StatusStarted(target: target, kind: kind, duration: duration);
  }

  /// Ends [kind] on [target] at once; null when it was not running.
  StatusCleared? clear(EntityId target, StatusEffectKind kind) {
    final index = _indexOf(target, kind);
    if (index < 0) {
      return null;
    }
    _targets.removeAt(index);
    _kinds.removeAt(index);
    _left.removeAt(index);
    return StatusCleared(target: target, kind: kind);
  }

  /// Takes [dt] from every effect, adding one [StatusExpired] to [expired]
  /// for each whose time runs out, in the order they were applied.
  void advance(Seconds dt, List<StatusExpired> expired) {
    var kept = 0;
    for (var i = 0; i < _left.length; i++) {
      final left = _left[i] - dt;
      if (left <= _epsilon) {
        expired.add(StatusExpired(target: _targets[i], kind: _kinds[i]));
        continue;
      }
      _targets[kept] = _targets[i];
      _kinds[kept] = _kinds[i];
      _left[kept] = left;
      kept++;
    }
    _targets.length = kept;
    _kinds.length = kept;
    _left.length = kept;
  }

  int _indexOf(EntityId target, StatusEffectKind kind) {
    for (var i = 0; i < _targets.length; i++) {
      if (_targets[i] == target && _kinds[i] == kind) {
        return i;
      }
    }
    return -1;
  }
}
