import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/block_judge.dart';
import 'package:saviors_paradox/features/combat/domain/block_verdict.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/flight_event.dart';
import 'package:saviors_paradox/features/combat/domain/flight_id.dart';
import 'package:saviors_paradox/features/combat/domain/flight_track.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/hitstop_rule.dart';
import 'package:saviors_paradox/features/combat/domain/missile.dart';
import 'package:saviors_paradox/features/combat/domain/reach.dart';

part 'flight.dart';

/// The projectiles in the air (design-patterns.md §8): a pool of
/// [capacity] flights made once and reused; nothing outside reaches a
/// flight but through this root.
final class Flights {
  Flights()
    : _slots = List<Flight>.generate(
        capacity,
        (_) => Flight._(),
        growable: false,
      );

  /// Operator, 2026-10-16.
  static const int capacity = 64;

  /// Operator, 2026-10-16.
  static const Seconds lifetime = Seconds(4);

  /// reflect.md: "faster"; operator, 2026-10-16.
  static const double reflectSpeedFactor = 1.6;

  final List<Flight> _slots;
  int _nextId = 1;

  int get flyingCount {
    var count = 0;
    for (var i = 0; i < capacity; i++) {
      if (_slots[i]._isFlying) {
        count++;
      }
    }
    return count;
  }

  /// Puts [missile] in the air; when the pool is full, the oldest flight
  /// is reused.
  FlightId launch(Missile missile) {
    final id = FlightId(_nextId++);
    _slots[_freeOrOldest()]._launch(id, missile);
    return id;
  }

  /// Moves every flight by its velocity; one older than [lifetime] is
  /// spent.
  void advance(Seconds dt) {
    for (var i = 0; i < capacity; i++) {
      if (_slots[i]._isFlying) {
        _slots[i]._move(dt);
      }
    }
  }

  /// The flight in [slot], or null when the slot is free.
  FlightId? flyingAt(int slot) {
    final flight = _slots[slot];
    return flight._isFlying ? flight._id : null;
  }

  FlightTrack trackOf(FlightId id) {
    final flight = _flying(id);
    if (flight == null) {
      throw ArgumentError.value(id, 'id', 'no flight of this id is flying');
    }
    return FlightTrack(
      id: id,
      thrower: flight._thrower,
      from: flight._from,
      to: flight._at,
      radius: flight._radius,
    );
  }

  /// Spends the flight where it met the world; null when it is not flying.
  FlightCrashed? crash(FlightId id) {
    final flight = _flying(id);
    if (flight == null) {
      return null;
    }
    flight._spend();
    return FlightCrashed(element: flight._element, at: flight._at);
  }

  /// The flight meets [defender]: it strikes, is blocked or turns back;
  /// null when it is not flying or cannot meet that body.
  FlightEvent? meet(FlightId id, Defender defender, {Vec2? throwerAt}) {
    final flight = _flying(id);
    if (flight == null || !_canMeet(flight, defender)) {
      return null;
    }
    final guard = defender.guard;
    if (guard == null) {
      return _struck(flight, defender);
    }
    return _resolveGuarded(flight, defender, guard, throwerAt);
  }

  FlightEvent _resolveGuarded(
    Flight flight,
    Defender defender,
    Guard guard,
    Vec2? throwerAt,
  ) {
    final verdict = const BlockJudge().judge(
      element: flight._element,
      isBlockable: true,
      guard: guard,
    );
    return switch (verdict) {
      BlockVerdict.unguarded => _struck(flight, defender),
      BlockVerdict.perfect
          when flight._isReflectable && flight._turnedBy == null =>
        _turned(flight, defender, guard.shield, throwerAt),
      BlockVerdict.perfect ||
      BlockVerdict.blocked => _blocked(flight, defender, guard, verdict),
    };
  }

  bool _canMeet(Flight flight, Defender defender) =>
      defender.side != flight._side &&
      !defender.isInvulnerable &&
      (flight._turnedBy == null || defender.id == flight._thrower) &&
      const Reach().reaches(defender.hurtbox, flight._at, flight._radius);

  FlightStruck _struck(Flight flight, Defender defender) {
    flight._spend();
    final turnedBy = flight._turnedBy;
    return FlightStruck(
      striker: flight._striker,
      target: defender.id,
      element: flight._element,
      damage: flight._damage,
      at: flight._at,
      hitstop: _struckHitstop(turnedBy, defender.side),
      affliction: _struckAffliction(turnedBy, defender),
    );
  }

  Seconds _struckHitstop(ShieldId? turnedBy, CombatantSide target) =>
      turnedBy == null
      ? const HitstopRule().onHit(
          target: target,
          kind: AttackKind.projectile,
        )
      : HitstopRule.onReflectedHit;

  Affliction? _struckAffliction(ShieldId? turnedBy, Defender defender) =>
      turnedBy == null
      ? null
      : Affliction.byShield(
          shield: turnedBy,
          target: defender.id,
          immunities: defender.immunities,
          duration: Affliction.afterReflect,
        );

  FlightTurned _turned(
    Flight flight,
    Defender defender,
    ShieldId shield,
    Vec2? throwerAt,
  ) {
    flight._turn(defender, shield, throwerAt);
    return FlightTurned(
      reflector: defender.id,
      thrower: flight._thrower,
      shield: shield,
      at: flight._at,
      hitstop: HitstopRule.onReflect,
    );
  }

  FlightBlocked _blocked(
    Flight flight,
    Defender defender,
    Guard guard,
    BlockVerdict verdict,
  ) {
    flight._spend();
    return FlightBlocked(
      thrower: flight._striker,
      defender: defender.id,
      element: flight._element,
      shield: guard.shield,
      isPerfect: verdict == BlockVerdict.perfect,
      at: flight._at,
      hitstop: HitstopRule.onBlock,
    );
  }

  Flight? _flying(FlightId id) {
    for (var i = 0; i < capacity; i++) {
      final flight = _slots[i];
      if (flight._isFlying && flight._id == id) {
        return flight;
      }
    }
    return null;
  }

  int _freeOrOldest() {
    var oldest = 0;
    for (var i = 0; i < capacity; i++) {
      if (!_slots[i]._isFlying) {
        return i;
      }
      if (_slots[i]._id.value < _slots[oldest]._id.value) {
        oldest = i;
      }
    }
    return oldest;
  }
}
