import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';

/// What lies on an altar (05-items/altar/altar.md §1).
sealed class AltarGift {
  const AltarGift();
}

final class WeaponGift extends AltarGift {
  const WeaponGift(this.weapon);

  final WeaponId weapon;

  @override
  bool operator ==(Object other) =>
      other is WeaponGift && other.weapon == weapon;

  @override
  int get hashCode => weapon.hashCode;
}

final class ShieldGift extends AltarGift {
  const ShieldGift(this.shield);

  final ShieldId shield;

  @override
  bool operator ==(Object other) =>
      other is ShieldGift && other.shield == shield;

  @override
  int get hashCode => shield.hashCode;
}

final class ScrollGift extends AltarGift {
  const ScrollGift(this.scroll);

  final ScrollKind scroll;

  @override
  bool operator ==(Object other) =>
      other is ScrollGift && other.scroll == scroll;

  @override
  int get hashCode => scroll.hashCode;
}
