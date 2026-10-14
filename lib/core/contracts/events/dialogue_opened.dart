import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class DialogueOpened implements GameEvent {
  const DialogueOpened({
    required this.spirit,
  });

  final EntityId spirit;
}
