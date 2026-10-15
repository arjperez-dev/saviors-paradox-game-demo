import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';

void main() {
  group('Seconds', () {
    test('adds two durations', () {
      final sum = const Seconds(0.25) + const Seconds(0.5);

      expect(sum.value, closeTo(0.75, 1e-9));
    });

    test('subtracts one duration from another', () {
      final difference = const Seconds(0.5) - const Seconds(0.25);

      expect(difference.value, closeTo(0.25, 1e-9));
    });

    test('scales a duration by a factor', () {
      final scaled = const Seconds(0.5) * 3;

      expect(scaled.value, closeTo(1.5, 1e-9));
    });

    test('compares durations by value', () {
      expect(const Seconds(0.25) < const Seconds(0.5), isTrue);
      expect(const Seconds(0.5) >= const Seconds(0.5), isTrue);
      expect(const Seconds(0.5) > const Seconds(0.5), isFalse);
    });

    test('clamps a duration to a maximum', () {
      expect(
        const Seconds(0.5).atMost(const Seconds(0.25)),
        const Seconds(0.25),
      );
      expect(
        const Seconds(0.1).atMost(const Seconds(0.25)),
        const Seconds(0.1),
      );
    });

    test('clamps a duration to a minimum', () {
      expect(
        const Seconds(0.1).atLeast(const Seconds(0.25)),
        const Seconds(0.25),
      );
      expect(
        const Seconds(0.5).atLeast(const Seconds(0.25)),
        const Seconds(0.5),
      );
    });
  });
}
