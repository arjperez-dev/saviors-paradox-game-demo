import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';

sealed class PlayerCommand implements GameEvent {
  const PlayerCommand();
}

final class StartMoving extends PlayerCommand {
  const StartMoving({
    required this.direction,
  });

  final Facing direction;
}

final class StopMoving extends PlayerCommand {
  const StopMoving();
}

final class StartJump extends PlayerCommand {
  const StartJump();
}

final class ReleaseJump extends PlayerCommand {
  const ReleaseJump();
}

final class Descend extends PlayerCommand {
  const Descend();
}

final class Roll extends PlayerCommand {
  const Roll();
}

final class StartCrouch extends PlayerCommand {
  const StartCrouch();
}

final class StopCrouch extends PlayerCommand {
  const StopCrouch();
}

final class Aim extends PlayerCommand {
  const Aim({
    required this.point,
  });

  final Vec2 point;
}

final class StartAttack extends PlayerCommand {
  const StartAttack({
    required this.aim,
    required this.isUpHeld,
    required this.isDownHeld,
  });

  final Vec2 aim;
  final bool isUpHeld;
  final bool isDownHeld;
}

final class ReleaseAttack extends PlayerCommand {
  const ReleaseAttack({
    required this.aim,
  });

  final Vec2 aim;
}

final class RaiseShield extends PlayerCommand {
  const RaiseShield({
    required this.aim,
  });

  final Vec2 aim;
}

final class LowerShield extends PlayerCommand {
  const LowerShield();
}

final class UseAbility extends PlayerCommand {
  const UseAbility({
    required this.slotIndex,
  });

  final int slotIndex;
}

final class StartDrinking extends PlayerCommand {
  const StartDrinking();
}

final class StopDrinking extends PlayerCommand {
  const StopDrinking();
}

final class CycleWeapon extends PlayerCommand {
  const CycleWeapon({
    required this.steps,
  });

  final int steps;
}

final class PickWeapon extends PlayerCommand {
  const PickWeapon({
    required this.slotIndex,
  });

  final int slotIndex;
}

final class Take extends PlayerCommand {
  const Take();
}

final class Talk extends PlayerCommand {
  const Talk();
}

final class ToggleMap extends PlayerCommand {
  const ToggleMap();
}

final class PanMap extends PlayerCommand {
  const PanMap({
    required this.delta,
  });

  final Vec2 delta;
}

final class ZoomMap extends PlayerCommand {
  const ZoomMap({
    required this.steps,
  });

  final int steps;
}

final class MoveFocus extends PlayerCommand {
  const MoveFocus({
    required this.columns,
    required this.rows,
  });

  final int columns;
  final int rows;
}

final class PressConfirm extends PlayerCommand {
  const PressConfirm();
}

final class ReleaseConfirm extends PlayerCommand {
  const ReleaseConfirm();
}

final class PressEscape extends PlayerCommand {
  const PressEscape();
}

final class ReleaseEscape extends PlayerCommand {
  const ReleaseEscape();
}

final class UpgradeWeapon extends PlayerCommand {
  const UpgradeWeapon({
    required this.weapon,
  });

  final WeaponId weapon;
}

final class UpgradeShield extends PlayerCommand {
  const UpgradeShield({
    required this.shield,
  });

  final ShieldId shield;
}

final class EquipShield extends PlayerCommand {
  const EquipShield({
    required this.shield,
  });

  final ShieldId shield;
}

final class RestoreShieldUses extends PlayerCommand {
  const RestoreShieldUses({
    required this.shield,
  });

  final ShieldId shield;
}

final class RepairShield extends PlayerCommand {
  const RepairShield({
    required this.shield,
  });

  final ShieldId shield;
}

final class MoveWeaponToSlot extends PlayerCommand {
  const MoveWeaponToSlot({
    required this.weapon,
    required this.slotIndex,
  });

  final WeaponId weapon;
  final int slotIndex;
}
