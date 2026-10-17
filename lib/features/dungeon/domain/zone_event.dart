import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';

/// What happened in a zone.
sealed class ZoneEvent {
  const ZoneEvent();
}

final class BossRoomSealed extends ZoneEvent {
  const BossRoomSealed({required this.room, required this.boss});

  final EntityId room;
  final BossId boss;

  @override
  bool operator ==(Object other) =>
      other is BossRoomSealed && other.room == room && other.boss == boss;

  @override
  int get hashCode => Object.hash(room, boss);
}

final class BossRoomUnsealed extends ZoneEvent {
  const BossRoomUnsealed({required this.room, required this.at});

  final EntityId room;
  final Vec2 at;

  @override
  bool operator ==(Object other) =>
      other is BossRoomUnsealed && other.room == room && other.at == at;

  @override
  int get hashCode => Object.hash(room, at);
}

final class ItemTakenFromAltar extends ZoneEvent {
  const ItemTakenFromAltar({
    required this.altar,
    required this.gift,
    required this.at,
  });

  final EntityId altar;
  final AltarGift gift;
  final Vec2 at;

  @override
  bool operator ==(Object other) =>
      other is ItemTakenFromAltar &&
      other.altar == altar &&
      other.gift == gift &&
      other.at == at;

  @override
  int get hashCode => Object.hash(altar, gift, at);
}

final class ItemReturnedToAltar extends ZoneEvent {
  const ItemReturnedToAltar({required this.altar, required this.gift});

  final EntityId altar;
  final AltarGift gift;

  @override
  bool operator ==(Object other) =>
      other is ItemReturnedToAltar &&
      other.altar == altar &&
      other.gift == gift;

  @override
  int get hashCode => Object.hash(altar, gift);
}
