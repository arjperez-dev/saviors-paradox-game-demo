import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/world_resumed.dart';

final class MapClosed extends WorldResumed {
  const MapClosed() : super(HaltCause.map);
}
