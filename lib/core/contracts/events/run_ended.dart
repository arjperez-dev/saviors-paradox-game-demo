import 'package:saviors_paradox/core/contracts/events/death_cause.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/run_outcome.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

final class RunEnded implements GameEvent {
  const RunEnded({
    required this.outcome,
    required this.zoneReached,
    required this.enemiesDefeated,
    required this.timePlayed,
    required this.xpLost,
    required this.coinsLost,
    required this.deathCause,
  });

  final RunOutcome outcome;
  final ZoneNumber zoneReached;
  final int enemiesDefeated;
  final Seconds timePlayed;
  final int xpLost;
  final int coinsLost;
  final DeathCause? deathCause;
}
