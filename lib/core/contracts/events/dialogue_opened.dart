import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class DialogueOpened extends WorldHalted {
  const DialogueOpened({
    required this.spirit,
  }) : super(HaltCause.dialogue);

  final EntityId spirit;
}
