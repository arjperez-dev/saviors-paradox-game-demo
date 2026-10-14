import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class ChainThrown implements GameEvent {
  const ChainThrown({
    required this.from,
    required this.aim,
  });

  final Vec2 from;
  final Vec2 aim;
}
