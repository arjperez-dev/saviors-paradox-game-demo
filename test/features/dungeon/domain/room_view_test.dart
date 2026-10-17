import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_view.dart';

RoomView _aView() => RoomView(
  room: const EntityId(1000000),
  bounds: const WorldBox(centre: Vec2(100, 200), halfWidth: 50, halfHeight: 60),
  neighbours: const [EntityId(1000001), EntityId(1000002)],
  isOnMainPath: true,
  isBossRoom: false,
);

void main() {
  group('RoomView', () {
    test('room views are equal by value', () {
      final a = _aView();
      final b = _aView();

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(() => a.neighbours.add(const EntityId(9)), throwsUnsupportedError);
    });
  });
}
