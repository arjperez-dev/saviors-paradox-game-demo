import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point_kind.dart';

final class ChainHooked implements GameEvent {
  const ChainHooked({
    required this.kind,
    required this.at,
  });

  final HookPointKind kind;
  final Vec2 at;
}
