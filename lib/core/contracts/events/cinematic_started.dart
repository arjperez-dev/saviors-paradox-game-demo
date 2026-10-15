import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';
import 'package:saviors_paradox/core/contracts/state/cinematic_id.dart';

final class CinematicStarted extends WorldHalted {
  const CinematicStarted({
    required this.cinematic,
  }) : super(HaltCause.cinematic);

  final CinematicId cinematic;
}
