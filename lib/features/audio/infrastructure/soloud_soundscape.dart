// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/events/sound_effect_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/music_cue_id.dart';
import 'package:saviors_paradox/core/contracts/ports/soundscape.dart';

final class SoloudSoundscape implements Soundscape {
  @override
  void playMusic(MusicCueId cue) {}

  @override
  void stopMusic(Seconds fadeOut) {}

  @override
  void playSoundEffect(SoundEffectId sound, Vec2 at) {}
}
