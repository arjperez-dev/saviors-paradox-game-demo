import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/map_opened.dart';
import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/contracts/events/run_started.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/world_camera.dart';
import 'package:saviors_paradox/core/input/application/input_contexts.dart';
import 'package:saviors_paradox/core/input/application/menu_context.dart';
import 'package:saviors_paradox/core/input/application/playing_context.dart';
import 'package:saviors_paradox/core/input/application/translate_input.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';

class MockWorldCamera extends Mock implements WorldCamera {}

const _oneFrame = Seconds(1 / 60);
const _runStarted = RunStarted(seed: Seed(1), slot: 0);

void main() {
  setUpAll(() {
    registerFallbackValue(ScreenVec2.zero);
  });

  group('commands flowing from raw input through the loop', () {
    late EventQueue queue;
    late MockWorldCamera camera;
    late TranslateInput translate;
    late List<PlayerCommand> commands;
    late int worldSteps;
    late GameLoop loop;

    setUp(() {
      queue = EventQueue();
      camera = MockWorldCamera();
      translate = TranslateInput(
        events: queue,
        camera: camera,
        contexts: InputContexts(
          menu: const MenuContext(),
          playing: const PlayingContext(),
        ),
      );
      commands = [];
      queue.subscribe<PlayerCommand>(commands.add);
      worldSteps = 0;
      loop = GameLoop(
        queue: queue,
        clock: StepClock(),
        systems: [(dt) => worldSteps++],
        drain: translate.drainInto,
      );
    });

    test(
      'D moves the menu focus before a run and walks right during one',
      () {
        translate.receive(const KeyDown(InputKey.d));
        loop.advance(_oneFrame);
        // 00-game/controls.md §4: D moves the menu focus right.
        expect(commands, [const MoveFocus(columns: 1, rows: 0)]);
        commands.clear();

        queue.publish(_runStarted);
        loop.advance(_oneFrame);
        commands.clear();

        translate.receive(const KeyUp(InputKey.d));
        translate.receive(const KeyDown(InputKey.d));
        loop.advance(_oneFrame);
        // 00-game/controls.md §1: D starts walking to the right.
        expect(commands, [const StartMoving(direction: Facing.right)]);
      },
    );

    test('commands still flow while the map halts the world', () {
      queue.publish(_runStarted);
      loop.advance(_oneFrame);
      commands.clear();

      queue.publish(const MapOpened());
      loop.advance(_oneFrame);
      commands.clear();
      final stepsAtHalt = worldSteps;

      translate.receive(const KeyDown(InputKey.escape));
      for (var i = 0; i < 3; i++) {
        loop.advance(_oneFrame);
      }

      expect(worldSteps, stepsAtHalt);
      expect(commands, [const PressEscape()]);
    });

    test("opening the map stops Akeris's walk", () {
      queue.publish(_runStarted);
      loop.advance(_oneFrame);
      commands.clear();

      translate.receive(const KeyDown(InputKey.d));
      loop.advance(_oneFrame);
      commands.clear();

      queue.publish(const MapOpened());
      loop.advance(_oneFrame);
      commands.clear();

      loop.advance(_oneFrame);
      expect(commands, [const StopMoving()]);
      commands.clear();

      translate.receive(const KeyUp(InputKey.d));
      loop.advance(_oneFrame);
      expect(commands, isEmpty);
    });

    test(
      "a click carries the camera's world point and the pointer's stillness",
      () {
        when(() => camera.toWorld(any())).thenReturn(const Vec2(500, 300));
        queue.publish(_runStarted);
        loop.advance(_oneFrame);
        commands.clear();

        translate.receive(
          const PointerMoved(
            position: ScreenVec2(Vec2(10, 10)),
            delta: ScreenVec2.zero,
          ),
        );
        loop.advance(_oneFrame);
        loop.advance(_oneFrame);
        translate.receive(const ButtonDown(PointerButton.primary));
        loop.advance(_oneFrame);

        expect(commands, hasLength(1));
        final command = commands.single as StartAttack;
        expect(command.aim, const Vec2(500, 300));
        expect(command.pointerStillFor.value, closeTo(2 / 60, 1e-9));
      },
    );
  });
}
