import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_resumed.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';

final class DialogueClosed extends WorldResumed {
  const DialogueClosed({
    required this.spirit,
  }) : super(HaltCause.dialogue);

  final EntityId spirit;
}
