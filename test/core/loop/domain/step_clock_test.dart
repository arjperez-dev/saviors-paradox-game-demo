import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/events/halt_cause.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/loop/domain/step_clock.dart';
import 'package:saviors_paradox/core/loop/domain/world_halts.dart';

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

    test('holds every step while the world is halted', () {
      final halts = WorldHalts();
      final clock = StepClock(halts: halts);

      halts.halt(HaltCause.dialogue);
      final step = clock.advance(const Seconds(1 / 60));

      expect(step, Seconds.zero);
      expect(clock.isHeld, isTrue);
    });

    test('steps again once the world resumes', () {
      final halts = WorldHalts();
      final clock = StepClock(halts: halts);

      halts.halt(HaltCause.dialogue);
      halts.resume(HaltCause.dialogue);
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

    test('a hitstop waits while the world is halted', () {
      final halts = WorldHalts();
      final clock = StepClock(halts: halts);

      clock.holdFor(const Seconds(0.05));
      halts.halt(HaltCause.map);
      final whileHalted = clock.advance(const Seconds(1 / 30));
      halts.resume(HaltCause.map);
      final firstAfterResume = clock.advance(const Seconds(1 / 30));
      final secondAfterResume = clock.advance(const Seconds(1 / 30));

      expect(whileHalted, Seconds.zero);
      expect(firstAfterResume, Seconds.zero);
      expect(secondAfterResume.value, closeTo(1 / 60, 1e-9));
    });

    test('keeps halts of its own when given none', () {
      final clock = StepClock();

      clock.halts.halt(HaltCause.cinematic);
      final step = clock.advance(const Seconds(1 / 60));

      expect(step, Seconds.zero);
    });

    test(
      'clamps a frame for the interface without spending the hitstop',
      () {
        // StepClock.clamp never spends the hitstop StepClock.advance does.
        final clock = StepClock();

        clock.holdFor(const Seconds(0.05));
        final clamped = clock.clamp(const Seconds(0.5));
        final first = clock.advance(const Seconds(1 / 30));
        final second = clock.advance(const Seconds(1 / 30));

        expect(clamped.value, closeTo(1 / 30, 1e-9));
        expect(first, Seconds.zero);
        expect(second.value, closeTo(1 / 60, 1e-9));
      },
    );

    test(
      'clamps a frame for the interface while the world is halted',
      () {
        final halts = WorldHalts();
        final clock = StepClock(halts: halts);

        halts.halt(HaltCause.map);
        final clamped = clock.clamp(const Seconds(1 / 60));

        expect(clamped.value, closeTo(1 / 60, 1e-9));
      },
    );
  });
}
