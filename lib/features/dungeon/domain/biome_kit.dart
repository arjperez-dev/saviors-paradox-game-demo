import 'package:saviors_paradox/core/contracts/kernel/biome.dart';
import 'package:saviors_paradox/core/contracts/kernel/boss_id.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';

/// The family a biome's zones are built from (design-patterns.md §10):
/// one implementation per biome.
abstract interface class BiomeKit {
  /// The biome this kit builds.
  Biome get biome;

  /// The boss that closes the biome's zone.
  BossId get boss;

  /// The grid its zones are laid on.
  ZoneGrid get grid;

  /// The kinds of the main path after the start, in their fixed order.
  List<RoomKind> get mainPath;

  /// The kinds a branch room is drawn from, repeated by their weight.
  List<RoomKind> get branchKinds;

  /// The fewest rooms a zone of this biome holds.
  int get fewestRooms;

  /// The most rooms a zone of this biome holds.
  int get mostRooms;

  /// The altars a zone of this biome holds.
  int get altarCount;

  /// The templates of [kind]; empty for a kind the biome never uses.
  List<RoomTemplate> templatesOf(RoomKind kind);
}
