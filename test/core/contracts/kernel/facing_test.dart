import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';

void main() {
  group('Facing', () {
    test('left signs -1 and right signs 1', () {
      expect(Facing.left.sign, -1);
      expect(Facing.right.sign, 1);
    });

    test('the opposite of each facing is the other', () {
      expect(Facing.left.opposite, Facing.right);
      expect(Facing.right.opposite, Facing.left);
    });
  });
}
