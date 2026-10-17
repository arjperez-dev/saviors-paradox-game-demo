import 'package:saviors_paradox/core/contracts/events/attack_blocked.dart';
import 'package:saviors_paradox/core/contracts/events/counter_triggered.dart';
import 'package:saviors_paradox/core/contracts/events/hit_landed.dart';
import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/projectile_reflected.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_cued.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_control.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/combat_sounds.dart';
import 'package:saviors_paradox/features/combat/domain/engagement_event.dart';
import 'package:saviors_paradox/features/combat/domain/flight_event.dart';

/// Publishes what combat resolved, as the integration events other
/// features hear (architecture.md §4).
final class ReportExchange {
  ReportExchange(this._events, this._statuses);

  final EventSink _events;
  final StatusEffectControl _statuses;

  void engagement(EngagementEvent event) {
    switch (event) {
      case StrikeLanded():
        _strikeLanded(event);
      case StrikeBlocked():
        _strikeBlocked(event);
    }
  }

  void flight(FlightEvent event) {
    switch (event) {
      case FlightStruck():
        _flightStruck(event);
      case FlightBlocked():
        _flightBlocked(event);
      case FlightTurned():
        _flightTurned(event);
      case FlightCrashed():
        _cue(const CombatSounds().impact(event.element), event.at);
    }
  }

  void _strikeLanded(StrikeLanded event) {
    final strike = event.strike;
    _events.publish(
      HitLanded(
        attacker: strike.attacker,
        target: event.target,
        kind: strike.kind,
        element: strike.element,
        damage: strike.damage.amount,
        knockback: strike.knockback,
        at: event.at,
        isLethal: strike.isLethal,
      ),
    );
    _hold(event.hitstop);
  }

  void _strikeBlocked(StrikeBlocked event) {
    final strike = event.strike;
    _events.publish(
      AttackBlocked(
        attacker: strike.attacker,
        defender: event.defender,
        kind: strike.kind,
        element: strike.element,
        shield: event.shield,
        isPerfect: event.isPerfect,
        at: event.at,
      ),
    );
    _hold(event.hitstop);
    if (event.isPerfect) {
      _cuePerfectBlock(event.shield, event.at);
    } else {
      _cueBlock(event.shield, event.at);
    }
    if (event.opensCounter) {
      _events.publish(
        CounterTriggered(defender: event.defender, attacker: strike.attacker),
      );
    }
    _inflict(event.affliction, event.at);
  }

  void _flightStruck(FlightStruck event) {
    _events.publish(
      HitLanded(
        attacker: event.striker,
        target: event.target,
        kind: AttackKind.projectile,
        element: event.element,
        damage: event.damage.amount,
        knockback: Vec2.zero,
        at: event.at,
        isLethal: false,
      ),
    );
    _hold(event.hitstop);
    _cue(const CombatSounds().impact(event.element), event.at);
    _inflict(event.affliction, event.at);
  }

  void _flightBlocked(FlightBlocked event) {
    _events.publish(
      AttackBlocked(
        attacker: event.thrower,
        defender: event.defender,
        kind: AttackKind.projectile,
        element: event.element,
        shield: event.shield,
        isPerfect: event.isPerfect,
        at: event.at,
      ),
    );
    _hold(event.hitstop);
    if (event.isPerfect) {
      _cuePerfectBlock(event.shield, event.at);
    } else {
      _cueBlock(event.shield, event.at);
    }
  }

  void _flightTurned(FlightTurned event) {
    _events.publish(
      ProjectileReflected(
        reflector: event.reflector,
        thrower: event.thrower,
        shield: event.shield,
        at: event.at,
      ),
    );
    _hold(event.hitstop);
    _cue(CombatSounds.reflect, event.at);
    _cue(CombatSounds.perfectBlock, event.at);
  }

  void _hold(Seconds hitstop) =>
      _events.publish(HitstopStarted(duration: hitstop));

  void _cueBlock(ShieldId shield, Vec2 at) {
    _cue(const CombatSounds().block(shield), at);
  }

  void _cuePerfectBlock(ShieldId shield, Vec2 at) {
    _cueBlock(shield, at);
    _cue(CombatSounds.perfectBlock, at);
  }

  void _inflict(Affliction? affliction, Vec2 at) {
    if (affliction == null) {
      return;
    }
    _statuses.apply(affliction.target, affliction.kind, affliction.duration);
    _cue(const CombatSounds().affliction(affliction.kind), at);
  }

  void _cue(SoundEffectId? sound, Vec2 at) {
    if (sound != null) {
      _events.publish(SoundEffectCued(sound: sound, at: at));
    }
  }
}
