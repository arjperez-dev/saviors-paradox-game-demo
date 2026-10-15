import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/rendering/domain/smoothstep.dart';

void main() {
  group('smoothstep', () {
    test('is 0 before the start and 1 after the end', () {
      expect(smoothstep(-1), 0);
      expect(smoothstep(2), 1);
    });

    test('is a half at the middle', () {
      expect(smoothstep(0.5), 0.5);
      expect(smoothstep(0.25), closeTo(0.15625, 1e-9));
    });
  });
}
