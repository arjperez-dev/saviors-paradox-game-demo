import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/input/application/input_context.dart';

/// The stack of input contexts (design-patterns.md §5): the menu at the
/// bottom, playing while a run lasts, and on top one context per standing
/// halt.
final class InputContexts {
  InputContexts({
    required InputContext menu,
    required InputContext playing,
    Map<HaltCause, InputContext> halts = const {},
  }) : _menu = menu, // ignore: prefer_initializing_formals — field is private
       _playing = playing, // ignore: prefer_initializing_formals — ditto
       _halts = Map.unmodifiable(halts);

  final InputContext _menu;
  final InputContext _playing;
  final Map<HaltCause, InputContext> _halts;
  final List<HaltCause> _standing = [];
  bool _isRunning = false;

  /// The context that translates input now: the latest standing halt's,
  /// or the menu's when its cause registered none; else playing during a
  /// run; else the menu.
  InputContext get active {
    if (_standing.isNotEmpty) {
      return _halts[_standing.last] ?? _menu;
    }
    return _isRunning ? _playing : _menu;
  }

  void startRun() => _isRunning = true;

  void endRun() => _isRunning = false;

  /// Stacks [cause]; one already standing keeps its place.
  void halt(HaltCause cause) {
    if (!_standing.contains(cause)) {
      _standing.add(cause);
    }
  }

  /// Removes [cause] wherever it stands; nothing when it does not.
  void resume(HaltCause cause) => _standing.remove(cause);
}
