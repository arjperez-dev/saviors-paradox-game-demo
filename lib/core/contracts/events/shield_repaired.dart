import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';

final class ShieldRepaired implements GameEvent {
  const ShieldRepaired({
    required this.shield,
  });

  final ShieldId shield;
}
