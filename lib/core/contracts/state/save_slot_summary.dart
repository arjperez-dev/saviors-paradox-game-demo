import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/weapon_slot_snapshot.dart';

final class SaveSlotSummary {
  const SaveSlotSummary({
    required this.slot,
    required this.isEmpty,
    required this.isWon,
    required this.isLastPlayed,
    required this.zone,
    required this.weapons,
    required this.shield,
    required this.xp,
    required this.coins,
    required this.timePlayed,
    required this.savedAt,
  });

  final int slot;
  final bool isEmpty;
  final bool isWon;
  final bool isLastPlayed;
  final ZoneNumber? zone;
  final List<WeaponSlotSnapshot> weapons;
  final ShieldId? shield;
  final int xp;
  final int coins;
  final Seconds timePlayed;
  final DateTime? savedAt;
}
