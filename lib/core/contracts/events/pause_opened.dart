import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';

final class PauseOpened extends WorldHalted {
  const PauseOpened() : super(HaltCause.pauseMenu);
}
