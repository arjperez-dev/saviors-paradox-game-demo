import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/weapon_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_altars.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';
import 'package:saviors_paradox/features/dungeon/domain/suspended_sanctuary_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_factory.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_failure.dart';

import '../mocks.dart';

const ZoneFactory _factory = ZoneFactory();
final SuspendedSanctuaryKit _kit = SuspendedSanctuaryKit();

// Acceptance: "the zone" is the zone of Seed(1).
Zone _zoneOfSeed1() {
  final result = _factory.create(ZoneNumber.first, _kit, const Seed(1));
  return (result as Success<Zone, ZoneFailure>).value;
}

void main() {
  setUpAll(() {
    registerFallbackValue(_zoneOfSeed1());
  });

  group('ZoneAltars', () {
    late MockZoneRepository zones;
    late ZoneAltars altars;

    setUp(() {
      zones = MockZoneRepository();
      altars = ZoneAltars(zones);
    });

    test('returns an item to its empty altar', () {
      final zone = _zoneOfSeed1();
      final altar = zone.altars.first.altar;
      when(() => zones.load()).thenReturn(zone);

      altars.returnTo(altar, const AltarScroll(scroll: ScrollKind.health));

      expect(zone.giftOn(altar), const ScrollGift(ScrollKind.health));
      verify(() => zones.save(zone)).called(1);
    });

    test('an altar that holds an item keeps it', () {
      final zone = _zoneOfSeed1();
      final altar = zone.altars.first.altar;
      when(() => zones.load()).thenReturn(zone);

      altars.returnTo(altar, const AltarScroll(scroll: ScrollKind.health));
      altars.returnTo(altar, const AltarWeapon(weapon: WeaponId.spear));

      expect(zone.giftOn(altar), const ScrollGift(ScrollKind.health));
    });

    test('with no zone nothing happens', () {
      when(() => zones.load()).thenReturn(null);

      altars.returnTo(
        const EntityId(1),
        const AltarScroll(scroll: ScrollKind.health),
      );

      verifyNever(() => zones.save(any()));
    });
  });
}
