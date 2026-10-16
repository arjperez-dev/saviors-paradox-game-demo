import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/player_command.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/ports/world_camera.dart';
import 'package:saviors_paradox/core/input/application/input_contexts.dart';
import 'package:saviors_paradox/core/input/application/menu_context.dart';
import 'package:saviors_paradox/core/input/application/playing_context.dart';
import 'package:saviors_paradox/core/input/application/translate_input.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';
import 'package:saviors_paradox/core/loop/application/game_loop.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/core/ui/domain/focus_group.dart';
import 'package:saviors_paradox/core/ui/presentation/button_state.dart';
import 'package:saviors_paradox/core/ui/presentation/cap_key.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_answer.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_question.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_texts.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap_button.dart';
import 'package:saviors_paradox/core/ui/presentation/menu_button.dart';

class MockWorldCamera extends Mock implements WorldCamera {}

const _oneFrame = Seconds(1 / 60);
const _texts = ConfirmTexts(
  ask: 'Quit?',
  note: 'Saved.',
  yes: 'Quit',
  no: 'Stay',
);

Future<void> _setView(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

Widget _wrap(Widget child) => Directionality(
  textDirection: TextDirection.ltr,
  child: InkTheme(
    child: Align(alignment: Alignment.topLeft, child: child),
  ),
);

void main() {
  group('the interface kit through the real loop', () {
    late EventQueue queue;
    late TranslateInput translate;
    late List<PlayerCommand> commands;
    late GameLoop loop;

    setUp(() {
      queue = EventQueue();
      translate = TranslateInput(
        events: queue,
        camera: MockWorldCamera(),
        contexts: InputContexts(
          menu: const MenuContext(),
          playing: const PlayingContext(),
        ),
      );
      commands = [];
      queue.subscribe<PlayerCommand>(commands.add);
      loop = GameLoop(
        queue: queue,
        clock: StepClock(),
        systems: const [],
        drain: translate.drainInto,
      );
    });

    testWidgets('clicking a key cap button publishes what its key does', (
      tester,
    ) async {
      await _setView(tester, const Size(1920, 1080));
      await tester.pumpWidget(
        _wrap(
          KeyCapButton(
            label: 'Resume',
            capKey: const CapKey(InputKey.escape, label: 'Esc'),
            state: const ButtonState(seed: Seed(31200)),
            onInput: translate.receive,
          ),
        ),
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(KeyCapButton)),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      loop.advance(_oneFrame);

      expect(commands, [const PressEscape()]);

      await gesture.up();
      await tester.pump();
      loop.advance(_oneFrame);

      expect(commands, [const PressEscape(), const ReleaseEscape()]);
    });

    testWidgets("the keys move a question's focus through its focus group", (
      tester,
    ) async {
      await _setView(tester, const Size(1920, 1080));
      final group = FocusGroup<ConfirmAnswer>([
        [ConfirmAnswer.yes, ConfirmAnswer.no],
      ]);
      var focused = ConfirmAnswer.no;
      queue.subscribe<MoveFocus>(
        (move) => focused = group.moved(focused, move),
      );

      Future<void> pumpQuestion() => tester.pumpWidget(
        _wrap(
          ConfirmQuestion(
            texts: _texts,
            focused: focused,
            onAnswer: (_) {},
            seed: const Seed(31400),
          ),
        ),
      );

      await pumpQuestion();

      translate.receive(const KeyDown(InputKey.a));
      loop.advance(_oneFrame);

      // 00-game/controls.md §4: A moves the focus left.
      expect(focused, ConfirmAnswer.yes);

      await pumpQuestion();

      final yes = tester.widget<MenuButton>(
        find.widgetWithText(MenuButton, _texts.yes),
      );
      expect(yes.state.focused, isTrue);
    });

    testWidgets("the kit lays out by the screen's height", (tester) async {
      await _setView(tester, const Size(2560, 1440));

      await tester.pumpWidget(
        _wrap(
          ConfirmQuestion(
            texts: _texts,
            focused: ConfirmAnswer.no,
            onAnswer: (_) {},
            seed: const Seed(31400),
          ),
        ),
      );
      final question = tester.getSize(find.byType(ConfirmQuestion));

      // 06-ui/ui.md §3: scaled by screen height ÷ 1080, here ×4/3.
      expect(question.width, closeTo(1066.667, 1e-3));
      expect(question.height, closeTo(386.667, 1e-3));

      await tester.pumpWidget(
        _wrap(
          KeyCapButton(
            label: 'Resume',
            capKey: const CapKey(InputKey.escape, label: 'Esc'),
            state: const ButtonState(seed: Seed(31200)),
            onInput: translate.receive,
          ),
        ),
      );
      final button = tester.getSize(find.byType(KeyCapButton));

      expect(button.height, closeTo(74.667, 1e-3));
    });
  });
}
