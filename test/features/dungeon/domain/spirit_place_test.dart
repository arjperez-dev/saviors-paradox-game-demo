import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/state/spirit_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/spirit_place.dart';

SpiritPlace _aPlace({required SpiritRole role}) => SpiritPlace(
  spirit: const EntityId(1003000),
  role: role,
  room: const EntityId(1000009),
  position: const Vec2(760, 700),
);

void main() {
  group('SpiritPlace', () {
    test('spirit places are equal by value', () {
      final a = _aPlace(role: SpiritRole.lore);
      final b = _aPlace(role: SpiritRole.lore);
      final differentRole = _aPlace(role: SpiritRole.warning);

      expect(a, b);
      expect(a == differentRole, isFalse);
    });
  });
}
