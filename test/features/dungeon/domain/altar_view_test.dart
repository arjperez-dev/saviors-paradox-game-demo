import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/scroll_kind.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_gift.dart';
import 'package:saviors_paradox/features/dungeon/domain/altar_view.dart';

AltarView _aView({AltarGift? gift}) => AltarView(
  altar: const EntityId(1002000),
  room: const EntityId(1000005),
  position: const Vec2(760, 700),
  gift: gift,
);

void main() {
  group('AltarView', () {
    test('altar views are equal by value', () {
      final a = _aView(gift: const ScrollGift(ScrollKind.health));
      final b = _aView(gift: const ScrollGift(ScrollKind.health));
      final differentGift = _aView(
        gift: const ScrollGift(ScrollKind.attackAndAbility),
      );

      expect(a, b);
      expect(a == differentGift, isFalse);
    });
  });
}
