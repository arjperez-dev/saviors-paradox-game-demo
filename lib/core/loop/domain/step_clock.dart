import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/domain/world_halts.dart';

/// Turns the time a frame took into the step the systems receive.
final class StepClock {
  StepClock({this._maxStep = defaultMaxStep, WorldHalts? halts})
    : halts = halts ?? WorldHalts();

  /// The longest step a system ever receives, so that a stall never
  /// tunnels a body through a wall (architecture.md §5).
  static const Seconds defaultMaxStep = Seconds(1 / 30);

  final Seconds _maxStep;

  /// The causes holding the world step; the clock only asks them.
  final WorldHalts halts;

  Seconds _hitstopLeft = Seconds.zero;

  bool get isHeld => halts.isHalted || _hitstopLeft > Seconds.zero;

  /// Holds the step for [duration]; a shorter hitstop never shortens a
  /// longer one already running.
  void holdFor(Seconds duration) {
    if (duration > _hitstopLeft) {
      _hitstopLeft = duration;
    }
  }

  /// The step the interface systems receive for a frame of [frame]
  /// seconds: the frame, never more than the maximum step. Neither a halt
  /// nor a hitstop changes it.
  Seconds clamp(Seconds frame) => frame.atMost(_maxStep);

  /// The world step for a frame of [frame] seconds: zero while the world
  /// is halted or while a hitstop lasts, what is left of the frame when the
  /// hitstop ends inside it, and never more than the maximum step.
  Seconds advance(Seconds frame) {
    if (halts.isHalted) {
      return Seconds.zero;
    }
    final clamped = clamp(frame);
    if (clamped <= _hitstopLeft) {
      _hitstopLeft = _hitstopLeft - clamped;
      return Seconds.zero;
    }
    final left = clamped - _hitstopLeft;
    _hitstopLeft = Seconds.zero;
    return left;
  }
}
