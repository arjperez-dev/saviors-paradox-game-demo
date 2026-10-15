import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_resumed.dart';
import 'package:saviors_paradox/core/contracts/state/cinematic_id.dart';

final class CinematicEnded extends WorldResumed {
  const CinematicEnded({
    required this.cinematic,
  }) : super(HaltCause.cinematic);

  final CinematicId cinematic;
}
