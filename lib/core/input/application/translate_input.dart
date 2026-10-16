import 'package:saviors_paradox/core/contracts/events/quit_to_title_requested.dart';
import 'package:saviors_paradox/core/contracts/events/run_ended.dart';
import 'package:saviors_paradox/core/contracts/events/run_started.dart';
import 'package:saviors_paradox/core/contracts/events/world_halted.dart';
import 'package:saviors_paradox/core/contracts/events/world_resumed.dart';
import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/contracts/ports/event_source.dart';
import 'package:saviors_paradox/core/contracts/ports/world_camera.dart';
import 'package:saviors_paradox/core/input/application/input_context.dart';
import 'package:saviors_paradox/core/input/application/input_contexts.dart';
import 'package:saviors_paradox/core/input/application/input_reading.dart';
import 'package:saviors_paradox/core/input/domain/input_key.dart';
import 'package:saviors_paradox/core/input/domain/pointer_button.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

/// Turns the window's keys and pointer into player commands through the
/// active input context (design-patterns.md §5). The loop drains it once
/// per frame, before both steps, whatever halts the world (architecture.md
/// §5).
final class TranslateInput {
  TranslateInput({
    required EventSource events,
    required WorldCamera camera,
    required InputContexts contexts,
  }) : _contexts = contexts,
       _reading = _Reading(camera),
       _current = contexts.active {
    events
      ..subscribe<RunStarted>((_) => contexts.startRun())
      ..subscribe<RunEnded>((_) => contexts.endRun())
      ..subscribe<QuitToTitleRequested>((_) => contexts.endRun())
      ..subscribe<WorldHalted>((event) => contexts.halt(event.cause))
      ..subscribe<WorldResumed>((event) => contexts.resume(event.cause));
  }

  final InputContexts _contexts;
  final _Reading _reading;
  final List<RawInput> _received = [];
  InputContext _current;

  /// Keeps [input] for the next drain. The window's listener and
  /// core/ui's key-cap buttons hand their inputs here.
  void receive(RawInput input) => _received.add(input);

  /// Publishes into [events] what the inputs received since the last drain
  /// mean, in the order received, after [dt] more of pointer stillness.
  void drainInto(EventSink events, Seconds dt) {
    _reading.wait(dt);
    _switchTo(_contexts.active, events);
    for (var i = 0; i < _received.length; i++) {
      final input = _received[i];
      if (_reading.apply(input)) {
        _current.translate(input, _reading, events);
      }
    }
    _received.clear();
  }

  // What is still held is released where it was pressed.
  void _switchTo(InputContext active, EventSink events) {
    if (identical(active, _current)) {
      return;
    }
    _reading.releaseAll(
      (release) => _current.translate(release, _reading, events),
    );
    _current = active;
  }
}

final class _Reading implements InputReading {
  _Reading(this._camera);

  final WorldCamera _camera;
  final Set<InputKey> _keys = {};
  final Set<InputKey> _releasedKeys = {};
  final Set<PointerButton> _buttons = {};
  final Set<PointerButton> _releasedButtons = {};
  ScreenVec2 _pointer = ScreenVec2.zero;
  Seconds _stillFor = const Seconds(double.infinity);

  @override
  bool isHeld(InputKey key) => _keys.contains(key);

  @override
  bool isPressed(PointerButton button) => _buttons.contains(button);

  @override
  ScreenVec2 get pointer => _pointer;

  @override
  Vec2 get aim => _camera.toWorld(_pointer);

  @override
  Seconds get pointerStillFor => _stillFor;

  void wait(Seconds dt) => _stillFor = _stillFor + dt;

  /// Records [input]; false when no context is to hear it: a repeated
  /// press, or the release of what a switch already released.
  bool apply(RawInput input) => switch (input) {
    KeyDown(:final key) => _press(_keys, _releasedKeys, key),
    KeyUp(:final key) => _release(_keys, _releasedKeys, key),
    ButtonDown(:final button) => _press(_buttons, _releasedButtons, button),
    ButtonUp(:final button) => _release(_buttons, _releasedButtons, button),
    PointerMoved(:final position) => _move(position),
    Scrolled() => true,
  };

  /// Releases every held key and button, telling [release] each one.
  void releaseAll(void Function(RawInput release) release) {
    for (final key in List.of(_keys)) {
      _keys.remove(key);
      _releasedKeys.add(key);
      release(KeyUp(key));
    }
    for (final button in List.of(_buttons)) {
      _buttons.remove(button);
      _releasedButtons.add(button);
      release(ButtonUp(button));
    }
  }

  static bool _press<T>(Set<T> held, Set<T> released, T item) {
    released.remove(item);
    return held.add(item);
  }

  static bool _release<T>(Set<T> held, Set<T> released, T item) =>
      !released.remove(item) && held.remove(item);

  bool _move(ScreenVec2 position) {
    _pointer = position;
    _stillFor = Seconds.zero;
    return true;
  }
}
