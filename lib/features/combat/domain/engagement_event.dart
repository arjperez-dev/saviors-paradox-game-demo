import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

/// What an engagement resolved.
sealed class EngagementEvent {
  const EngagementEvent();
}

/// The strike landed on [target] at [at].
final class StrikeLanded extends EngagementEvent {
  const StrikeLanded({
    required this.strike,
    required this.target,
    required this.at,
    required this.hitstop,
  });

  final Strike strike;
  final EntityId target;
  final Vec2 at;
  final Seconds hitstop;

  @override
  bool operator ==(Object other) =>
      other is StrikeLanded &&
      other.strike == strike &&
      other.target == target &&
      other.at == at &&
      other.hitstop == hitstop;

  @override
  int get hashCode => Object.hash(strike, target, at, hitstop);
}

/// [defender]'s [shield] stopped the strike at [at].
final class StrikeBlocked extends EngagementEvent {
  const StrikeBlocked({
    required this.strike,
    required this.defender,
    required this.shield,
    required this.isPerfect,
    required this.opensCounter,
    required this.affliction,
    required this.at,
    required this.hitstop,
  });

  final Strike strike;
  final EntityId defender;
  final ShieldId shield;
  final bool isPerfect;
  final bool opensCounter;
  final Affliction? affliction;
  final Vec2 at;
  final Seconds hitstop;

  @override
  bool operator ==(Object other) =>
      other is StrikeBlocked &&
      other.strike == strike &&
      other.defender == defender &&
      other.shield == shield &&
      other.isPerfect == isPerfect &&
      other.opensCounter == opensCounter &&
      other.affliction == affliction &&
      other.at == at &&
      other.hitstop == hitstop;

  @override
  int get hashCode => Object.hash(
    strike,
    defender,
    shield,
    isPerfect,
    opensCounter,
    affliction,
    at,
    hitstop,
  );
}
