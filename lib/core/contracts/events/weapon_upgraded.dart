import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';

final class WeaponUpgraded implements GameEvent {
  const WeaponUpgraded({
    required this.weapon,
    required this.level,
  });

  final WeaponId weapon;
  final int level;
}
