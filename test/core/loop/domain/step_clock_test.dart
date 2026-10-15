import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';

void main() {
  group('StepClock', () {
    test('passes a frame shorter than the maximum through unchanged', () {
      final clock = StepClock();

      final step = clock.advance(const Seconds(1 / 60));

      expect(step.value, closeTo(1 / 60, 1e-9));
    });

    test('clamps a long frame to the maximum step', () {
      final clock = StepClock();

      final step = clock.advance(const Seconds(0.5));

      expect(step.value, closeTo(1 / 30, 1e-9));
    });

    test('clamps a long frame to a maximum it is given', () {
      final clock = StepClock(maxStep: const Seconds(0.1));

      final step = clock.advance(const Seconds(0.5));

      expect(step.value, closeTo(0.1, 1e-9));
    });

    test('holds every step while paused', () {
      final clock = StepClock();

      clock.pause();
      final step = clock.advance(const Seconds(1 / 60));

      expect(step, Seconds.zero);
      expect(clock.isHeld, isTrue);
    });

    test('steps again after resuming', () {
      final clock = StepClock();

      clock.pause();
      clock.resume();
      final step = clock.advance(const Seconds(1 / 60));

      expect(step.value, closeTo(1 / 60, 1e-9));
      expect(clock.isHeld, isFalse);
    });

    test('holds the step for the length of a hitstop', () {
      final clock = StepClock();

      clock.holdFor(const Seconds(0.04));
      final first = clock.advance(const Seconds(1 / 60));
      final second = clock.advance(const Seconds(1 / 60));
      final third = clock.advance(const Seconds(1 / 60));

      expect(first, Seconds.zero);
      expect(second, Seconds.zero);
      expect(third.value, closeTo(0.01, 1e-9));
    });

    test('a shorter hitstop never shortens one already running', () {
      final clock = StepClock();

      clock.holdFor(const Seconds(0.1));
      clock.holdFor(const Seconds(0.02));
      final first = clock.advance(const Seconds(1 / 30));
      final second = clock.advance(const Seconds(1 / 30));

      expect(first, Seconds.zero);
      expect(second, Seconds.zero);
    });

    test('a hitstop waits while the game is paused', () {
      final clock = StepClock();

      clock.holdFor(const Seconds(0.05));
      clock.pause();
      final whilePaused = clock.advance(const Seconds(1 / 30));
      clock.resume();
      final firstAfterResume = clock.advance(const Seconds(1 / 30));
      final secondAfterResume = clock.advance(const Seconds(1 / 30));

      expect(whilePaused, Seconds.zero);
      expect(firstAfterResume, Seconds.zero);
      expect(secondAfterResume.value, closeTo(1 / 60, 1e-9));
    });
  });
}
