import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';

final class WeaponSlotSnapshot {
  const WeaponSlotSnapshot({
    required this.slotIndex,
    required this.weapon,
    required this.level,
  });

  final int slotIndex;
  final WeaponId? weapon;
  final int level;
}
