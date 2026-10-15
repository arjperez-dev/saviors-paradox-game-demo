import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';

/// Turns the time a frame took into the step the systems receive.
final class StepClock {
  StepClock({this._maxStep = defaultMaxStep});

  /// The longest step a system ever receives, so that a stall never
  /// tunnels a body through a wall (architecture.md §5).
  static const Seconds defaultMaxStep = Seconds(1 / 30);

  final Seconds _maxStep;
  Seconds _hitstopLeft = Seconds.zero;
  bool _isPaused = false;

  bool get isHeld => _isPaused || _hitstopLeft > Seconds.zero;

  void pause() => _isPaused = true;

  void resume() => _isPaused = false;

  /// Holds the step for [duration]; a shorter hitstop never shortens a
  /// longer one already running.
  void holdFor(Seconds duration) {
    if (duration > _hitstopLeft) {
      _hitstopLeft = duration;
    }
  }

  /// The step for a frame of [frame] seconds: zero while paused or while a
  /// hitstop lasts, what is left of the frame when the hitstop ends inside
  /// it, and never more than the maximum step.
  Seconds advance(Seconds frame) {
    if (_isPaused) {
      return Seconds.zero;
    }
    final clamped = frame.atMost(_maxStep);
    if (clamped <= _hitstopLeft) {
      _hitstopLeft = _hitstopLeft - clamped;
      return Seconds.zero;
    }
    final left = clamped - _hitstopLeft;
    _hitstopLeft = Seconds.zero;
    return left;
  }
}
