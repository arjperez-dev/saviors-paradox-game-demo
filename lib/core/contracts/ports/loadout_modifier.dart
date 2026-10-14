import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';

sealed class LoadoutModifier {
  const LoadoutModifier();
}

final class HeldWeapon extends LoadoutModifier {
  const HeldWeapon({
    required this.weapon,
    required this.level,
  });

  final WeaponId weapon;
  final int level;
}

final class StrappedShield extends LoadoutModifier {
  const StrappedShield({
    required this.shield,
    required this.level,
    required this.isBroken,
  });

  final ShieldId shield;
  final int level;
  final bool isBroken;
}

final class AttackBoost extends LoadoutModifier {
  const AttackBoost({
    required this.factor,
  });

  final double factor;
}

final class Rage extends LoadoutModifier {
  const Rage();
}

final class Curse extends LoadoutModifier {
  const Curse();
}

final class VenomEdgeActive extends LoadoutModifier {
  const VenomEdgeActive();
}

final class StoneOrbitActive extends LoadoutModifier {
  const StoneOrbitActive();
}

final class CarriedTorch extends LoadoutModifier {
  const CarriedTorch();
}
