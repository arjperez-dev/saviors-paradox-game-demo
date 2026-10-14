import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/music_cue_id.dart';

abstract interface class Soundscape {
  void playMusic(MusicCueId cue);

  void stopMusic(Seconds fadeOut);

  void playSoundEffect(SoundEffectId sound, Vec2 at);
}
