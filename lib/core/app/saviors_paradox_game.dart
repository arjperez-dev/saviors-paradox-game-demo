import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/core/loop/presentation/loop_component.dart';

/// The game the composition root builds: the loop, and the systems later
/// waves add to it in their fixed order.
final class SaviorsParadoxGame extends FlameGame<World> {
  final EventQueue _events = EventQueue();

  @override
  FutureOr<void> onLoad() => add(
    LoopComponent(
      GameLoop(queue: _events, clock: StepClock(), systems: const []),
    ),
  );
}
