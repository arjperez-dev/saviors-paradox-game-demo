import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';

sealed class AltarItem {
  const AltarItem();
}

final class AltarWeapon extends AltarItem {
  const AltarWeapon({
    required this.weapon,
  });

  final WeaponId weapon;
}

final class AltarShield extends AltarItem {
  const AltarShield({
    required this.shield,
  });

  final ShieldId shield;
}

final class AltarScroll extends AltarItem {
  const AltarScroll({
    required this.scroll,
  });

  final ScrollKind scroll;
}
