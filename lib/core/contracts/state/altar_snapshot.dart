import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';

final class AltarSnapshot {
  const AltarSnapshot({
    required this.altar,
    required this.room,
    required this.position,
    required this.item,
  });

  final EntityId altar;
  final EntityId room;
  final Vec2 position;
  final AltarItem? item;
}
