import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';

final class MapOpened extends WorldHalted {
  const MapOpened() : super(HaltCause.map);
}
