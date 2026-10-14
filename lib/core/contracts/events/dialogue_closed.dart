import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class DialogueClosed implements GameEvent {
  const DialogueClosed({
    required this.spirit,
  });

  final EntityId spirit;
}
