// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/state/arsenal_state.dart';

final class HandleArsenalCommands {
  ArsenalState get state => const ArsenalState(
    slots: [],
    heldSlotIndex: 0,
    shields: [],
    equippedShield: ShieldId.sacred,
    xp: 0,
  );

  void handle(PlayerCommand command) {}
}
