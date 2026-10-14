import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';

final class RunStarted implements GameEvent {
  const RunStarted({
    required this.seed,
    required this.slot,
  });

  final Seed seed;
  final int slot;
}
