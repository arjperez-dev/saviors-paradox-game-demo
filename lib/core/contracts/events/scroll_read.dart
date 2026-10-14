import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';

final class ScrollRead implements GameEvent {
  const ScrollRead({
    required this.scroll,
  });

  final ScrollKind scroll;
}
