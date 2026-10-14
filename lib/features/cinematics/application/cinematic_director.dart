// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/ports/cinematic_player.dart';
import 'package:saviors_paradox/core/contracts/state/cinematic_id.dart';
import 'package:saviors_paradox/core/contracts/state/cinematic_state.dart';

final class CinematicDirector implements CinematicPlayer {
  @override
  void play(CinematicId cinematic) {}

  @override
  CinematicState get state => const CinematicState(playing: null, hasFinished: false);
}
