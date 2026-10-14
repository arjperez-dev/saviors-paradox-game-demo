import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class SoundEffectCued implements GameEvent {
  const SoundEffectCued({
    required this.sound,
    required this.at,
  });

  final SoundEffectId sound;
  final Vec2 at;
}
