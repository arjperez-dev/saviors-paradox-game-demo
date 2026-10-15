import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';
import 'package:saviors_paradox/core/contracts/events/world_resumed.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';

/// One step of a system, as the composition root hands it to the loop.
typedef SystemStep = void Function(Seconds dt);

/// How `core/input` hands the loop a frame's commands: it publishes them
/// into [events], given the interface step [dt].
typedef CommandDrain = void Function(EventSink events, Seconds dt);

void _drainNothing(EventSink events, Seconds dt) {}

/// Each frame, drains the commands and delivers what waits, whatever halts
/// the world; steps the world [systems] unless a halt or a hitstop holds
/// them; then steps the interface systems, which never halt
/// (architecture.md §5). What a system raises is delivered before the next
/// one steps (design-patterns.md §7).
final class GameLoop {
  GameLoop({
    required EventQueue queue,
    required StepClock clock,
    required List<SystemStep> systems,
    List<SystemStep> interfaceSystems = const [],
    this._drain = _drainNothing,
  }) : _queue = queue,
       _clock = clock,
       _systems = List.unmodifiable(systems),
       _interfaceSystems = List.unmodifiable(interfaceSystems) {
    final halts = clock.halts;
    queue
      ..subscribe<WorldHalted>((event) => halts.halt(event.cause))
      ..subscribe<WorldResumed>((event) => halts.resume(event.cause))
      ..subscribe<HitstopStarted>((event) => clock.holdFor(event.duration));
  }

  final EventQueue _queue;
  final StepClock _clock;
  final List<SystemStep> _systems;
  final List<SystemStep> _interfaceSystems;
  final CommandDrain _drain;

  /// Advances the game by one frame that took [frame] seconds.
  void advance(Seconds frame) {
    final step = _clock.clamp(frame);
    _drain(_queue, step);
    _queue.deliver();
    _stepAll(_systems, _clock.advance(frame));
    _stepAll(_interfaceSystems, step);
  }

  void _stepAll(List<SystemStep> systems, Seconds dt) {
    if (dt <= Seconds.zero) {
      return;
    }
    for (var i = 0; i < systems.length; i++) {
      systems[i](dt);
      _queue.deliver();
    }
  }
}
