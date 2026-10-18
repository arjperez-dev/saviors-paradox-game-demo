import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/altars.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';
import 'package:saviors_paradox/features/dungeon/application/ports/zone_repository.dart';
import 'package:saviors_paradox/features/dungeon/application/zone_reading.dart';

/// Lays an item back on its altar when another feature gives it back.
final class ZoneAltars implements Altars {
  ZoneAltars(this._zones);

  final ZoneRepository _zones;

  @override
  void returnTo(EntityId altar, AltarItem item) {
    final zone = _zones.load();
    if (zone == null) {
      return;
    }
    zone.returnTo(altar, readGift(item));
    _zones.save(zone);
  }

  // Stub: not implemented (architect change-04).
  @override
  AltarItem? takeWithin(Vec2 point) => null;
}
