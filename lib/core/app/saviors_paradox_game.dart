import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:saviors_paradox/core/input/application/input_contexts.dart';
import 'package:saviors_paradox/core/input/application/menu_context.dart';
import 'package:saviors_paradox/core/input/application/playing_context.dart';
import 'package:saviors_paradox/core/input/application/translate_input.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/core/loop/presentation/loop_component.dart';
import 'package:saviors_paradox/core/rendering/presentation/follow_camera.dart';

/// The game the composition root builds: the loop, the input it drains
/// each frame, and the systems later waves add to it in their fixed order.
final class SaviorsParadoxGame extends FlameGame<World> {
  factory SaviorsParadoxGame() {
    final events = EventQueue();
    return SaviorsParadoxGame._(
      events,
      TranslateInput(
        events: events,
        camera: FollowCamera(),
        contexts: InputContexts(
          menu: const MenuContext(),
          playing: const PlayingContext(),
        ),
      ),
    );
  }

  SaviorsParadoxGame._(this._events, this.input);

  final EventQueue _events;

  /// Where the window's keys and pointer arrive (core/input).
  final TranslateInput input;

  @override
  FutureOr<void> onLoad() => add(
    LoopComponent(
      GameLoop(
        queue: _events,
        clock: StepClock(),
        systems: const [],
        drain: input.drainInto,
      ),
    ),
  );
}
