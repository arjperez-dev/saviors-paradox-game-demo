import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';

/// What a zone shows of one of its altars.
final class AltarView {
  const AltarView({
    required this.altar,
    required this.room,
    required this.position,
    required this.gift,
  });

  final EntityId altar;
  final EntityId room;
  final Vec2 position;
  final AltarGift? gift;

  @override
  bool operator ==(Object other) =>
      other is AltarView &&
      other.altar == altar &&
      other.room == room &&
      other.position == position &&
      other.gift == gift;

  @override
  int get hashCode => Object.hash(altar, room, position, gift);
}
