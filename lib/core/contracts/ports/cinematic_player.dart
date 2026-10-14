import 'package:saviors_paradox/core/contracts/state/cinematic_id.dart';
import 'package:saviors_paradox/core/contracts/state/cinematic_state.dart';

abstract interface class CinematicPlayer {
  void play(CinematicId cinematic);

  CinematicState get state;
}
