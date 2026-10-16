import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/events/map_closed.dart';
import 'package:saviors_paradox/core/contracts/events/map_opened.dart';
import 'package:saviors_paradox/core/contracts/events/quit_to_title_requested.dart';
import 'package:saviors_paradox/core/contracts/events/run_ended.dart';
import 'package:saviors_paradox/core/contracts/events/run_outcome.dart';
import 'package:saviors_paradox/core/contracts/events/run_started.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/zone_number.dart';
import 'package:saviors_paradox/core/input/application/input_contexts.dart';
import 'package:saviors_paradox/core/input/application/input_reading.dart';
import 'package:saviors_paradox/core/input/application/translate_input.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';
import 'package:saviors_paradox/core/loop/application/event_queue.dart';

import '../mocks.dart';

const _aDown = KeyDown(InputKey.a);
const _aUp = KeyUp(InputKey.a);
const _dDown = KeyDown(InputKey.d);
const _dUp = KeyUp(InputKey.d);
const _wDown = KeyDown(InputKey.w);
const _wUp = KeyUp(InputKey.w);
const _primaryDown = ButtonDown(PointerButton.primary);
const _primaryUp = ButtonUp(PointerButton.primary);
const _secondaryDown = ButtonDown(PointerButton.secondary);
const _secondaryUp = ButtonUp(PointerButton.secondary);

const _runStarted = RunStarted(seed: Seed(1), slot: 0);
const _runEnded = RunEnded(
  outcome: RunOutcome.lost,
  zoneReached: ZoneNumber.first,
  enemiesDefeated: 0,
  timePlayed: Seconds.zero,
  xpLost: 0,
  coinsLost: 0,
  deathCause: null,
);

RawInput _movedTo(double x, double y) =>
    PointerMoved(position: ScreenVec2(Vec2(x, y)), delta: ScreenVec2.zero);

bool _isWHeld(InputReading reading) => reading.isHeld(InputKey.w);

bool _isSecondaryPressed(InputReading reading) =>
    reading.isPressed(PointerButton.secondary);

// A one-slot box: the stub fills it from [select] when [context] is asked
// to translate [trigger]; a test reads it back once `drainInto` returns.
List<T?> _snapshotOn<T>(
  MockInputContext context,
  RawInput trigger,
  MockEventSink commands,
  T Function(InputReading reading) select,
) {
  final captured = <T?>[null];
  when(() => context.translate(trigger, any(), commands)).thenAnswer(
    (i) => captured[0] = select(i.positionalArguments[1] as InputReading),
  );
  return captured;
}

void main() {
  setUpAll(() {
    registerFallbackValue(_aDown);
    registerFallbackValue(MockInputReading());
  });

  group('TranslateInput', () {
    late EventQueue events;
    late MockInputContext menu;
    late MockInputContext playing;
    late MockInputContext map;
    late MockWorldCamera camera;
    late TranslateInput translate;
    late MockEventSink commands;

    void startRun() {
      events.publish(_runStarted);
      events.deliver();
    }

    void drainAndExpect(MockInputContext context, RawInput input) {
      translate.receive(input);
      translate.drainInto(commands, Seconds.zero);
      verify(() => context.translate(input, any(), commands)).called(1);
    }

    void switchToMapWhileHoldingDAndPrimary() {
      startRun();
      translate.receive(_dDown);
      translate.receive(_primaryDown);
      translate.drainInto(commands, Seconds.zero);
      events.publish(const MapOpened());
      events.deliver();
      translate.drainInto(commands, Seconds.zero);
    }

    List<T?> snapshotOn<T>(RawInput trigger, T Function(InputReading) pick) =>
        _snapshotOn(playing, trigger, commands, pick);

    setUp(() {
      events = EventQueue();
      menu = MockInputContext();
      playing = MockInputContext();
      map = MockInputContext();
      camera = MockWorldCamera();
      commands = MockEventSink();
      translate = TranslateInput(
        events: events,
        camera: camera,
        contexts: InputContexts(
          menu: menu,
          playing: playing,
          halts: {HaltCause.map: map},
        ),
      );
    });

    test('translates through the menu context before a run starts', () {
      drainAndExpect(menu, _aDown);

      verifyNever(() => playing.translate(any(), any(), commands));
    });

    test('translates through the playing context once a run has started', () {
      startRun();

      drainAndExpect(playing, _aDown);
    });

    test('a run ended or a quit to the title returns to the menu', () {
      startRun();
      events.publish(_runEnded);
      events.deliver();
      drainAndExpect(menu, _aDown);

      startRun();
      events.publish(const QuitToTitleRequested());
      events.deliver();
      drainAndExpect(menu, _dDown);
    });

    test('a halt translates through the context registered for its cause', () {
      startRun();
      events.publish(const MapOpened());
      events.deliver();
      drainAndExpect(map, _aDown);

      events.publish(const MapClosed());
      events.deliver();
      drainAndExpect(playing, _dDown);
    });

    test('inputs are translated in the order received, once each', () {
      startRun();
      translate.receive(_aDown);
      translate.receive(_dDown);
      translate.receive(_aUp);
      translate.drainInto(commands, Seconds.zero);

      final translated = verify(
        () => playing.translate(captureAny(), any(), commands),
      ).captured;
      expect(translated, [_aDown, _dDown, _aUp]);

      translate.drainInto(commands, Seconds.zero);

      verifyNever(() => playing.translate(any(), any(), commands));
    });

    test('a repeated key down reaches the context once', () {
      startRun();
      translate.receive(_aDown);
      translate.receive(_aDown);

      translate.drainInto(commands, Seconds.zero);

      verify(() => playing.translate(_aDown, any(), commands)).called(1);
    });

    test(
      'a switch releases every held key and button through the outgoing context',
      () {
        switchToMapWhileHoldingDAndPrimary();

        verify(() => playing.translate(_dUp, any(), commands)).called(1);
        verify(() => playing.translate(_primaryUp, any(), commands)).called(1);
        verifyNever(() => map.translate(_dUp, any(), commands));
        verifyNever(() => map.translate(_primaryUp, any(), commands));
      },
    );

    test('the physical release after a switch reaches no context', () {
      switchToMapWhileHoldingDAndPrimary();

      translate.receive(_dUp);
      translate.drainInto(commands, Seconds.zero);
      verifyNever(() => map.translate(_dUp, any(), commands));

      translate.receive(_dDown);
      translate.drainInto(commands, Seconds.zero);
      verify(() => map.translate(_dDown, any(), commands)).called(1);
    });

    test('the reading holds a key from its press to its release', () {
      startRun();
      final heldOnPress = snapshotOn(_wDown, _isWHeld);
      final heldOnRelease = snapshotOn(_wUp, _isWHeld);
      final pressedOnDown = snapshotOn(_secondaryDown, _isSecondaryPressed);
      final pressedOnUp = snapshotOn(_secondaryUp, _isSecondaryPressed);

      translate.receive(_wDown);
      translate.receive(_wUp);
      translate.receive(_secondaryDown);
      translate.receive(_secondaryUp);
      translate.drainInto(commands, Seconds.zero);

      expect(heldOnPress[0], isTrue);
      expect(heldOnRelease[0], isFalse);
      expect(pressedOnDown[0], isTrue);
      expect(pressedOnUp[0], isFalse);
    });

    test('the pointer has been still forever before it first moves', () {
      startRun();
      final stillFor = snapshotOn(_primaryDown, (r) => r.pointerStillFor);

      translate.receive(_primaryDown);
      translate.drainInto(commands, const Seconds(1));

      expect(stillFor[0]?.value, double.infinity);
    });

    test(
      "pointer stillness grows by each drain's dt and a move resets it",
      () {
        startRun();
        final atClick = snapshotOn(_primaryDown, (r) => r.pointerStillFor);
        final atRelease = snapshotOn(_primaryUp, (r) => r.pointerStillFor);

        translate.receive(_movedTo(640, 360));
        translate.receive(_primaryDown);
        translate.drainInto(commands, const Seconds(1));
        expect(atClick[0]?.value, closeTo(0, 1e-9));

        translate.receive(_primaryUp);
        translate.drainInto(commands, const Seconds(0.5));
        expect(atRelease[0]?.value, closeTo(0.5, 1e-9));
      },
    );

    test("the aim is the camera's world point under the pointer", () {
      startRun();
      const screenPoint = ScreenVec2(Vec2(640, 360));
      const worldPoint = Vec2(900, 1200);
      when(() => camera.toWorld(screenPoint)).thenReturn(worldPoint);
      final captured = snapshotOn(
        _primaryDown,
        (r) => (pointer: r.pointer, aim: r.aim),
      );

      translate.receive(
        const PointerMoved(position: screenPoint, delta: ScreenVec2.zero),
      );
      translate.receive(_primaryDown);
      translate.drainInto(commands, Seconds.zero);

      expect(captured[0]?.pointer, screenPoint);
      expect(captured[0]?.aim, worldPoint);
    });
  });
}
