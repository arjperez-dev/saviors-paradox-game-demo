import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';

final class ShieldBroken implements GameEvent {
  const ShieldBroken({
    required this.shield,
  });

  final ShieldId shield;
}
