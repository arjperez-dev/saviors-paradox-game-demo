import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/state/shield_snapshot.dart';
import 'package:saviors_paradox/core/contracts/state/weapon_slot_snapshot.dart';

final class ArsenalState {
  const ArsenalState({
    required this.slots,
    required this.heldSlotIndex,
    required this.shields,
    required this.equippedShield,
    required this.xp,
  });

  final List<WeaponSlotSnapshot> slots;
  final int heldSlotIndex;
  final List<ShieldSnapshot> shields;
  final ShieldId equippedShield;
  final int xp;
}
