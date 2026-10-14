import 'package:saviors_paradox/core/contracts/events/game_event.dart';

final class CurseStarted implements GameEvent {
  const CurseStarted({
    required this.total,
  });

  final int total;
}
