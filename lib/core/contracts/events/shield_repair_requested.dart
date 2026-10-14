import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';

final class ShieldRepairRequested implements GameEvent {
  const ShieldRepairRequested({
    required this.shield,
  });

  final ShieldId shield;
}
