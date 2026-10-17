import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/hook_spot.dart';

void main() {
  group('HookSpot', () {
    test('hook spots are equal by value', () {
      const a = HookSpot(id: EntityId(1001000), position: Vec2(2680, 2408));
      const b = HookSpot(id: EntityId(1001000), position: Vec2(2680, 2408));
      const differentId = HookSpot(
        id: EntityId(1001001),
        position: Vec2(2680, 2408),
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(differentId));
    });
  });
}
