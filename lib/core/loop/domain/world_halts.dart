import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';

/// The causes that hold the world step, one per screen that stops it
/// (architecture.md §2.3). A repeated halt and a resume with no matching
/// halt change nothing.
final class WorldHalts {
  final Set<HaltCause> _causes = {};

  bool get isHalted => _causes.isNotEmpty;

  void halt(HaltCause cause) => _causes.add(cause);

  void resume(HaltCause cause) => _causes.remove(cause);
}
