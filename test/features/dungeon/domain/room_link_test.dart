import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_link.dart';

void main() {
  group('RoomLink', () {
    test('links are equal by value', () {
      const a = RoomLink(from: 0, to: 1, side: Facing.right, row: 2);
      const b = RoomLink(from: 0, to: 1, side: Facing.right, row: 2);
      const differentRow = RoomLink(
        from: 0,
        to: 1,
        side: Facing.right,
        row: 3,
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(differentRow));
    });
  });
}
