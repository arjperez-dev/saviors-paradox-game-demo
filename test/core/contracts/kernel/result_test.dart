import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/result.dart';

void main() {
  group('Result', () {
    test('successes holding equal values are equal', () {
      const a = Success<int, String>(3);
      const b = Success<int, String>(3);

      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });

    test('failures holding equal reasons are equal', () {
      const a = Failure<int, String>('x');
      const b = Failure<int, String>('x');

      expect(a, b);
    });

    test('a success never equals a failure', () {
      const Result<int, int> success = Success(1);
      const Result<int, int> failure = Failure(1);

      expect(success == failure, isFalse);
    });
  });
}
