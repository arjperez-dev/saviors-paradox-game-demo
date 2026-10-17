import 'package:saviors_paradox/core/contracts/events/sound_effect_cued.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/ports/boss_room_seal.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/features/dungeon/application/ports/zone_repository.dart';

/// Opens the boss room's doors when the run says the boss is dead.
final class BossRoomDoors implements BossRoomSeal {
  BossRoomDoors(this._zones, this._events);

  /// 07-audio/sfx/sfx.md: the padlock breaks and the bars rise.
  static const SoundEffectId opened = SoundEffectId('sfx.bossDoor.open');

  final ZoneRepository _zones;
  final EventSink _events;

  @override
  void unseal() {
    final zone = _zones.load();
    if (zone == null) {
      return;
    }
    final unsealed = zone.unsealBossRoom();
    _zones.save(zone);
    if (unsealed != null) {
      _events.publish(SoundEffectCued(sound: opened, at: unsealed.at));
    }
  }
}
