import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';
import 'package:saviors_paradox/core/ui/presentation/button_state.dart';
import 'package:saviors_paradox/core/ui/presentation/cap_key.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap.dart';
import 'package:saviors_paradox/core/ui/presentation/key_cap_button.dart';
import 'package:saviors_paradox/core/ui/presentation/menu_button.dart';

Future<void> _setView(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(1920, 1080);
  addTearDown(tester.view.reset);
}

Widget _wrap(Widget child) => Directionality(
  textDirection: TextDirection.ltr,
  child: InkTheme(
    child: Align(alignment: Alignment.topLeft, child: child),
  ),
);

Widget _keyCapButton(List<RawInput> inputs) => KeyCapButton(
  label: 'Resume',
  capKey: const CapKey(InputKey.escape, label: 'Esc'),
  state: const ButtonState(seed: Seed(5)),
  onInput: inputs.add,
);

void main() {
  group('KeyCapButton', () {
    testWidgets('pressing the button presses its key', (tester) async {
      await _setView(tester);
      final inputs = <RawInput>[];
      await tester.pumpWidget(_wrap(_keyCapButton(inputs)));

      await tester.startGesture(
        tester.getCenter(find.byType(KeyCapButton)),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();

      expect(inputs, [const KeyDown(InputKey.escape)]);
    });

    testWidgets('letting go releases its key', (tester) async {
      await _setView(tester);
      final inputs = <RawInput>[];
      await tester.pumpWidget(_wrap(_keyCapButton(inputs)));

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(KeyCapButton)),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      await gesture.up();
      await tester.pump();

      expect(inputs, [
        const KeyDown(InputKey.escape),
        const KeyUp(InputKey.escape),
      ]);
    });

    testWidgets('a cancelled press releases its key', (tester) async {
      await _setView(tester);
      final inputs = <RawInput>[];
      await tester.pumpWidget(_wrap(_keyCapButton(inputs)));

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(KeyCapButton)),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      await gesture.cancel();
      await tester.pump();

      expect(inputs, [
        const KeyDown(InputKey.escape),
        const KeyUp(InputKey.escape),
      ]);
    });

    testWidgets('a right click presses nothing', (tester) async {
      await _setView(tester);
      final inputs = <RawInput>[];
      await tester.pumpWidget(_wrap(_keyCapButton(inputs)));

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(KeyCapButton)),
        kind: PointerDeviceKind.mouse,
        buttons: kSecondaryButton,
      );
      await tester.pump();
      await gesture.up();
      await tester.pump();

      expect(inputs, isEmpty);
    });

    testWidgets('a release once the key is already up does nothing more', (
      tester,
    ) async {
      await _setView(tester);
      final inputs = <RawInput>[];
      await tester.pumpWidget(_wrap(_keyCapButton(inputs)));

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(KeyCapButton)),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();
      await gesture.up();
      await tester.pump();
      await tester.pumpWidget(_wrap(const SizedBox()));

      // Constraint: the key is released once per press — up, then dispose,
      // hands only one KeyUp.
      expect(inputs, [
        const KeyDown(InputKey.escape),
        const KeyUp(InputKey.escape),
      ]);
    });

    testWidgets('a second press while the key is held presses nothing more', (
      tester,
    ) async {
      await _setView(tester);
      final inputs = <RawInput>[];
      await tester.pumpWidget(_wrap(_keyCapButton(inputs)));
      final centre = tester.getCenter(find.byType(KeyCapButton));

      await tester.startGesture(centre, kind: PointerDeviceKind.mouse);
      await tester.pump();
      await tester.startGesture(
        centre,
        kind: PointerDeviceKind.mouse,
        pointer: 2,
      );
      await tester.pump();

      expect(inputs, [const KeyDown(InputKey.escape)]);
    });

    testWidgets('a button that goes away while held releases its key', (
      tester,
    ) async {
      await _setView(tester);
      final inputs = <RawInput>[];
      await tester.pumpWidget(_wrap(_keyCapButton(inputs)));

      await tester.startGesture(
        tester.getCenter(find.byType(KeyCapButton)),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();

      await tester.pumpWidget(_wrap(const SizedBox()));

      expect(inputs, [
        const KeyDown(InputKey.escape),
        const KeyUp(InputKey.escape),
      ]);
    });

    testWidgets('the button shows its label and its key cap', (
      tester,
    ) async {
      await _setView(tester);
      await tester.pumpWidget(_wrap(_keyCapButton(<RawInput>[])));

      expect(find.text('Resume'), findsOneWidget);
      expect(
        tester.widget<KeyCap>(find.byType(KeyCap)).label,
        'Esc',
      );
    });

    testWidgets('the button is 56 tall', (tester) async {
      await _setView(tester);
      await tester.pumpWidget(_wrap(_keyCapButton(<RawInput>[])));

      // 06-ui/map/map.md §3: a button 56 tall with an Esc key cap.
      expect(tester.getSize(find.byType(MenuButton)).height, 56);
    });
  });
}
