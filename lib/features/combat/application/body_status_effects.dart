import 'package:saviors_paradox/core/contracts/events/status_effect_applied.dart';
import 'package:saviors_paradox/core/contracts/events/status_effect_ended.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_control.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/application/ports/status_effects_repository.dart';

/// Starts and ends the status effects other features ask for.
final class BodyStatusEffects implements StatusEffectControl {
  BodyStatusEffects(this._effects, this._events);

  final StatusEffectsRepository _effects;
  final EventSink _events;

  @override
  void apply(EntityId target, StatusEffectKind effect, Seconds duration) {
    final effects = _effects.load();
    final started = effects.apply(target, effect, duration);
    _effects.save(effects);
    if (started != null) {
      _events.publish(
        StatusEffectApplied(
          target: started.target,
          effect: started.kind,
          duration: started.duration,
        ),
      );
    }
  }

  @override
  void clear(EntityId target, StatusEffectKind effect) {
    final effects = _effects.load();
    final cleared = effects.clear(target, effect);
    _effects.save(effects);
    if (cleared != null) {
      _events.publish(
        StatusEffectEnded(target: cleared.target, effect: cleared.kind),
      );
    }
  }

  @override
  bool has(EntityId target, StatusEffectKind effect) =>
      _effects.load().has(target, effect);
}
