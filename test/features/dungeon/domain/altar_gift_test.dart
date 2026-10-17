import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';

void main() {
  group('AltarGift', () {
    test('gifts of one kind are equal by what they hold', () {
      const spear = WeaponGift(WeaponId.spear);
      const otherSpear = WeaponGift(WeaponId.spear);
      const hammer = WeaponGift(WeaponId.hammer);

      expect(spear, otherSpear);
      expect(spear.hashCode, otherSpear.hashCode);
      expect(spear, isNot(hammer));

      const ice = ShieldGift(ShieldId.ice);
      const otherIce = ShieldGift(ShieldId.ice);
      const fire = ShieldGift(ShieldId.fire);

      expect(ice, otherIce);
      expect(ice.hashCode, otherIce.hashCode);
      expect(ice, isNot(fire));

      const health = ScrollGift(ScrollKind.health);
      const otherHealth = ScrollGift(ScrollKind.health);
      const cursed = ScrollGift(ScrollKind.cursed);

      expect(health, otherHealth);
      expect(health.hashCode, otherHealth.hashCode);
      expect(health, isNot(cursed));
    });

    test('gifts of different kinds are never equal', () {
      const fireShield = ShieldGift(ShieldId.fire);
      const cursedScroll = ScrollGift(ScrollKind.cursed);
      const flailWeapon = WeaponGift(WeaponId.flail);
      const iceShield = ShieldGift(ShieldId.ice);

      expect(fireShield, isNot(cursedScroll));
      expect(flailWeapon, isNot(iceShield));
    });
  });
}
