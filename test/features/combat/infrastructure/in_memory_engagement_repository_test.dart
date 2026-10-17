import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/engagement.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';
import 'package:saviors_paradox/features/combat/infrastructure/in_memory_engagement_repository.dart';

Engagement _anEngagement() => Engagement(
  strike: Strike(
    attacker: const EntityId(1),
    side: CombatantSide.foe,
    kind: AttackKind.melee,
    element: Element.plain,
    area: const WorldBox(centre: Vec2(0, 0), halfWidth: 20, halfHeight: 20),
    damage: const Damage(10),
    knockback: const Vec2(5, 0),
    isBlockable: true,
    isLethal: false,
  ),
  defender: Defender(
    id: const EntityId(2),
    side: CombatantSide.akeris,
    hurtbox: const WorldBox(
      centre: Vec2(30, 0),
      halfWidth: 20,
      halfHeight: 40,
    ),
    guard: null,
    isInvulnerable: false,
  ),
);

void main() {
  group('InMemoryEngagementRepository', () {
    test('gives the engagements back oldest first', () {
      final a = _anEngagement();
      final b = _anEngagement();
      final c = _anEngagement();
      final repository = InMemoryEngagementRepository();
      repository.add(a);
      repository.add(b);
      repository.add(c);

      final first = repository.next();
      final second = repository.next();
      final third = repository.next();

      expect(first, same(a));
      expect(second, same(b));
      expect(third, same(c));
    });

    test('gives nothing when none waits', () {
      final repository = InMemoryEngagementRepository();

      expect(repository.next(), isNull);
    });

    test('gives each engagement once', () {
      final repository = InMemoryEngagementRepository();
      repository.add(_anEngagement());
      repository.next();

      expect(repository.next(), isNull);
    });
  });
}
