import 'package:saviors_paradox/core/contracts/events/status_effect_ended.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/features/combat/application/ports/status_effects_repository.dart';
import 'package:saviors_paradox/features/combat/domain/status_effect_event.dart';

/// Counts every status effect down by the world step.
final class StepStatusEffects {
  StepStatusEffects(this._effects, this._events);

  final StatusEffectsRepository _effects;
  final EventSink _events;

  // Scratch, reused every step and emptied before it returns: no game
  // state, no allocation (architecture.md §6.1).
  final List<StatusExpired> _expired = [];

  void step(Seconds dt) {
    final effects = _effects.load();
    effects.advance(dt, _expired);
    _effects.save(effects);
    for (var i = 0; i < _expired.length; i++) {
      final expired = _expired[i];
      _events.publish(
        StatusEffectEnded(target: expired.target, effect: expired.kind),
      );
    }
    _expired.clear();
  }
}
