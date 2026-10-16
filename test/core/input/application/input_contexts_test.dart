import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/input/application/input_contexts.dart';

import '../mocks.dart';

void main() {
  group('InputContexts', () {
    late MockInputContext menu;
    late MockInputContext playing;
    late MockInputContext map;
    late MockInputContext dialogue;

    setUp(() {
      menu = MockInputContext();
      playing = MockInputContext();
      map = MockInputContext();
      dialogue = MockInputContext();
    });

    test('starts at the menu context', () {
      final contexts = InputContexts(menu: menu, playing: playing);

      expect(contexts.active, same(menu));
    });

    test('a started run makes playing active', () {
      final contexts = InputContexts(menu: menu, playing: playing);

      contexts.startRun();

      expect(contexts.active, same(playing));
    });

    test('an ended run returns to the menu', () {
      final contexts = InputContexts(menu: menu, playing: playing);

      contexts.startRun();
      contexts.endRun();

      expect(contexts.active, same(menu));
    });

    test('a halt makes its registered context active', () {
      final contexts = InputContexts(
        menu: menu,
        playing: playing,
        halts: {HaltCause.map: map},
      );
      contexts.startRun();

      contexts.halt(HaltCause.map);

      expect(contexts.active, same(map));
    });

    test(
      'a halt with no context registered makes the menu active',
      () {
        final contexts = InputContexts(menu: menu, playing: playing);
        contexts.startRun();

        contexts.halt(HaltCause.pauseMenu);

        expect(contexts.active, same(menu));
      },
    );

    test('the latest standing halt is the active one', () {
      final contexts = InputContexts(
        menu: menu,
        playing: playing,
        halts: {HaltCause.map: map, HaltCause.dialogue: dialogue},
      );
      contexts.startRun();

      contexts.halt(HaltCause.map);
      contexts.halt(HaltCause.dialogue);

      expect(contexts.active, same(dialogue));
    });

    test('a resume removes its halt wherever it stands', () {
      final contexts = InputContexts(
        menu: menu,
        playing: playing,
        halts: {HaltCause.map: map, HaltCause.dialogue: dialogue},
      );
      contexts.startRun();
      contexts.halt(HaltCause.map);
      contexts.halt(HaltCause.dialogue);

      contexts.resume(HaltCause.map);
      expect(contexts.active, same(dialogue));

      contexts.resume(HaltCause.dialogue);
      expect(contexts.active, same(playing));
    });

    test('a repeated halt changes nothing', () {
      final contexts = InputContexts(
        menu: menu,
        playing: playing,
        halts: {HaltCause.map: map, HaltCause.dialogue: dialogue},
      );
      contexts.startRun();
      contexts.halt(HaltCause.map);
      contexts.halt(HaltCause.dialogue);

      contexts.halt(HaltCause.map);
      expect(contexts.active, same(dialogue));

      contexts.resume(HaltCause.dialogue);
      expect(contexts.active, same(map));
    });

    test('an unmatched resume changes nothing', () {
      final contexts = InputContexts(menu: menu, playing: playing);
      contexts.startRun();

      contexts.resume(HaltCause.map);

      expect(contexts.active, same(playing));
    });
  });
}
