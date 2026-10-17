import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';

void main() {
  group('Passage', () {
    test('a mirrored passage opens on the other side of its row', () {
      const passage = Passage(side: Facing.left, row: 1);

      final mirrored = passage.mirrored();

      expect(mirrored, const Passage(side: Facing.right, row: 1));
    });
  });
}
