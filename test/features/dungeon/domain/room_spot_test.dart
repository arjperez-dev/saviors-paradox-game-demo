import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_spot.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';

void main() {
  group('RoomSpot', () {
    test('a mirrored spot stands as far from the other edge', () {
      const spot = RoomSpot(kind: SpotKind.foe, position: Vec2(2350, 700));

      final mirrored = spot.mirrored(3200);

      expect(mirrored.position, const Vec2(850, 700));
    });
  });
}
