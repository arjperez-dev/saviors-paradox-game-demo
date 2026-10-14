import 'package:saviors_paradox/core/contracts/events/game_event.dart';

final class CurseProgressed implements GameEvent {
  const CurseProgressed({
    required this.kills,
    required this.total,
  });

  final int kills;
  final int total;
}
