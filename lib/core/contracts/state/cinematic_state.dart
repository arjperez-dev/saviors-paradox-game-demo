import 'package:saviors_paradox/core/contracts/state/cinematic_id.dart';

final class CinematicState {
  const CinematicState({
    required this.playing,
    required this.hasFinished,
  });

  final CinematicId? playing;
  final bool hasFinished;
}
