import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';

final class ItemTaken implements GameEvent {
  const ItemTaken({
    required this.altar,
    required this.item,
  });

  final EntityId altar;
  final AltarItem item;
}
