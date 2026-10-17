import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';

/// What happened to a projectile in the air.
sealed class FlightEvent {
  const FlightEvent();
}

/// The flight [striker] last sent hit [target].
final class FlightStruck extends FlightEvent {
  const FlightStruck({
    required this.striker,
    required this.target,
    required this.element,
    required this.damage,
    required this.at,
    required this.hitstop,
    required this.affliction,
  });

  final EntityId striker;
  final EntityId target;
  final Element element;
  final Damage damage;
  final Vec2 at;
  final Seconds hitstop;
  final Affliction? affliction;

  @override
  bool operator ==(Object other) =>
      other is FlightStruck &&
      other.striker == striker &&
      other.target == target &&
      other.element == element &&
      other.damage == damage &&
      other.at == at &&
      other.hitstop == hitstop &&
      other.affliction == affliction;

  @override
  int get hashCode =>
      Object.hash(striker, target, element, damage, at, hitstop, affliction);
}

/// [defender]'s [shield] stopped the flight.
final class FlightBlocked extends FlightEvent {
  const FlightBlocked({
    required this.thrower,
    required this.defender,
    required this.element,
    required this.shield,
    required this.isPerfect,
    required this.at,
    required this.hitstop,
  });

  final EntityId thrower;
  final EntityId defender;
  final Element element;
  final ShieldId shield;
  final bool isPerfect;
  final Vec2 at;
  final Seconds hitstop;

  @override
  bool operator ==(Object other) =>
      other is FlightBlocked &&
      other.thrower == thrower &&
      other.defender == defender &&
      other.element == element &&
      other.shield == shield &&
      other.isPerfect == isPerfect &&
      other.at == at &&
      other.hitstop == hitstop;

  @override
  int get hashCode =>
      Object.hash(thrower, defender, element, shield, isPerfect, at, hitstop);
}

/// [reflector]'s [shield] sent the flight back toward [thrower].
final class FlightTurned extends FlightEvent {
  const FlightTurned({
    required this.reflector,
    required this.thrower,
    required this.shield,
    required this.at,
    required this.hitstop,
  });

  final EntityId reflector;
  final EntityId thrower;
  final ShieldId shield;
  final Vec2 at;
  final Seconds hitstop;

  @override
  bool operator ==(Object other) =>
      other is FlightTurned &&
      other.reflector == reflector &&
      other.thrower == thrower &&
      other.shield == shield &&
      other.at == at &&
      other.hitstop == hitstop;

  @override
  int get hashCode => Object.hash(reflector, thrower, shield, at, hitstop);
}

/// The flight met the world at [at] and is spent.
final class FlightCrashed extends FlightEvent {
  const FlightCrashed({required this.element, required this.at});

  final Element element;
  final Vec2 at;

  @override
  bool operator ==(Object other) =>
      other is FlightCrashed && other.element == element && other.at == at;

  @override
  int get hashCode => Object.hash(element, at);
}
