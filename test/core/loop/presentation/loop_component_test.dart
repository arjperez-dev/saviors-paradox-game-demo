import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/core/loop/presentation/loop_component.dart';

void main() {
  group('LoopComponent', () {
    testWithFlameGame('advances the loop by the dt Flame updates it with', (
      game,
    ) async {
      final steps = <Seconds>[];
      final loop = GameLoop(
        queue: EventQueue(),
        clock: StepClock(),
        systems: [steps.add],
      );
      await game.add(LoopComponent(loop));
      await game.ready();

      game.update(1 / 60);

      expect(steps.single.value, closeTo(1 / 60, 1e-9));
    });
  });
}
