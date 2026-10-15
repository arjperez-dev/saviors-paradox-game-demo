import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/hitstop_started.dart';
import 'package:saviors_paradox/core/contracts/events/pause_closed.dart';
import 'package:saviors_paradox/core/contracts/events/pause_opened.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/core/loop/presentation/loop_component.dart';

/// A Flame game, mounted and ready, stepped by [systems] through a
/// [GameLoop] subscribed to [queue].
Future<FlameGame> gameStepping(
  EventQueue queue,
  List<SystemStep> systems,
) async {
  final loop = GameLoop(queue: queue, clock: StepClock(), systems: systems);
  final game = await initializeGame(FlameGame.new);
  await game.add(LoopComponent(loop));
  await game.ready();
  return game;
}

void main() {
  group('the loop, frame by frame in a Flame game', () {
    test(
      'a hitstop raised by one system holds every system for its duration',
      () async {
        final queue = EventQueue();
        final stepsB = <Seconds>[];
        var callsA = 0;
        void stepA(Seconds dt) {
          if (callsA++ == 0) {
            queue.publish(const HitstopStarted(duration: Seconds(0.05)));
          }
        }

        final game = await gameStepping(queue, [stepA, stepsB.add]);

        for (var i = 0; i < 6; i++) {
          game.update(0.02);
        }

        expect(stepsB.length, 4);
        const expectedSteps = [0.02, 0.01, 0.02, 0.02];
        for (var i = 0; i < expectedSteps.length; i++) {
          expect(stepsB[i].value, closeTo(expectedSteps[i], 1e-9));
        }
      },
    );

    test(
      'a pause opened between frames freezes the systems until it closes',
      () async {
        final queue = EventQueue();
        final EventSink sink = queue;
        var stepsA = 0;
        var stepsB = 0;
        final game = await gameStepping(queue, [
          (dt) => stepsA++,
          (dt) => stepsB++,
        ]);

        sink.publish(const PauseOpened());
        for (var i = 0; i < 3; i++) {
          game.update(1 / 60);
        }

        expect(stepsA, 0);
        expect(stepsB, 0);

        sink.publish(const PauseClosed());
        game.update(1 / 60);

        expect(stepsA, 1);
        expect(stepsB, 1);
      },
    );

    test('the same frames give the same steps', () async {
      Future<List<Seconds>> recordSteps() async {
        final steps = <Seconds>[];
        final game = await gameStepping(EventQueue(), [steps.add]);
        for (final frame in const [0.02, 0.5, 1 / 60, 0.03]) {
          game.update(frame);
        }
        return steps;
      }

      final first = await recordSteps();
      final second = await recordSteps();

      expect(first.length, second.length);
      for (var i = 0; i < first.length; i++) {
        expect(first[i].value, closeTo(second[i].value, 1e-9));
      }
    });
  });
}
