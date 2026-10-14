import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';

final class RunState {
  const RunState({
    required this.seed,
    required this.slot,
    required this.zone,
    required this.coins,
    required this.enemiesDefeated,
    required this.timePlayed,
  });

  final Seed seed;
  final int slot;
  final ZoneNumber zone;
  final int coins;
  final int enemiesDefeated;
  final Seconds timePlayed;
}
