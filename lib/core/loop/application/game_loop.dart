import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';
import 'package:saviors_paradox/core/contracts/events/world_resumed.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';

/// One step of a system, as the composition root hands it to the loop.
typedef SystemStep = void Function(Seconds dt);

/// Steps the systems in their fixed order and delivers the events each one
/// raised before the next one steps (design-patterns.md §7).
final class GameLoop {
  GameLoop({
    required EventQueue queue,
    required StepClock clock,
    required List<SystemStep> systems,
  }) : _queue = queue,
       _clock = clock,
       _systems = List.unmodifiable(systems) {
    final halts = clock.halts;
    queue
      ..subscribe<WorldHalted>((event) => halts.halt(event.cause))
      ..subscribe<WorldResumed>((event) => halts.resume(event.cause))
      ..subscribe<HitstopStarted>((event) => clock.holdFor(event.duration));
  }

  final EventQueue _queue;
  final StepClock _clock;
  final List<SystemStep> _systems;

  /// Advances the game by one frame that took [frame] seconds.
  void advance(Seconds frame) {
    _queue.deliver();
    final dt = _clock.advance(frame);
    if (dt <= Seconds.zero) {
      return;
    }
    for (var i = 0; i < _systems.length; i++) {
      _systems[i](dt);
      _queue.deliver();
    }
  }
}
