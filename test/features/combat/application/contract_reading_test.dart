import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/projectile.dart';
import 'package:saviors_paradox/core/contracts/ports/raised_shield.dart';
import 'package:saviors_paradox/features/combat/application/contract_reading.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';
import 'package:saviors_paradox/features/combat/domain/missile.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

import '../mocks.dart';

void main() {
  group('readStrike', () {
    test('reads an attack into a strike', () {
      final attack = Attack(
        attacker: const EntityId(1),
        side: CombatantSide.foe,
        kind: AttackKind.melee,
        element: Element.fire,
        area: const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
        damage: 12,
        knockback: const Vec2(3, 0),
        isBlockable: true,
        isLethal: false,
      );

      final strike = readStrike(attack);

      expect(
        strike,
        equals(
          Strike(
            attacker: attack.attacker,
            side: attack.side,
            kind: attack.kind,
            element: attack.element,
            area: attack.area,
            damage: const Damage(12),
            knockback: attack.knockback,
            isBlockable: attack.isBlockable,
            isLethal: attack.isLethal,
          ),
        ),
      );
    });
  });

  group('readDefender', () {
    late MockCombatant combatant;

    setUp(() => combatant = MockCombatant());

    test('reads a combatant with its raised shield into a defender', () {
      final hurtbox = const WorldBox(
        centre: Vec2.zero,
        halfWidth: 1,
        halfHeight: 1,
      );
      when(() => combatant.id).thenReturn(const EntityId(2));
      when(() => combatant.side).thenReturn(CombatantSide.akeris);
      when(() => combatant.hurtbox).thenReturn(hurtbox);
      when(() => combatant.raisedShield).thenReturn(
        RaisedShield(shield: ShieldId.ice, raisedFor: const Seconds(0.1)),
      );
      when(() => combatant.isInvulnerable).thenReturn(false);
      when(() => combatant.isImmuneTo(Element.fire)).thenReturn(false);
      when(() => combatant.isImmuneTo(Element.ice)).thenReturn(false);

      final defender = readDefender(combatant);

      expect(
        defender,
        equals(
          Defender(
            id: const EntityId(2),
            side: CombatantSide.akeris,
            hurtbox: hurtbox,
            guard: Guard(shield: ShieldId.ice, raisedFor: const Seconds(0.1)),
            isInvulnerable: false,
            immunities: Immunities.none,
          ),
        ),
      );
    });

    test('reads a combatant with no shield as unguarded', () {
      when(() => combatant.id).thenReturn(const EntityId(2));
      when(() => combatant.side).thenReturn(CombatantSide.akeris);
      when(() => combatant.hurtbox).thenReturn(
        const WorldBox(centre: Vec2.zero, halfWidth: 1, halfHeight: 1),
      );
      when(() => combatant.raisedShield).thenReturn(null);
      when(() => combatant.isInvulnerable).thenReturn(false);
      when(() => combatant.isImmuneTo(Element.fire)).thenReturn(false);
      when(() => combatant.isImmuneTo(Element.ice)).thenReturn(false);

      final defender = readDefender(combatant);

      expect(defender.guard, isNull);
    });
  });

  group('readImmunities', () {
    late MockCombatant combatant;

    setUp(() => combatant = MockCombatant());

    test('reads each immunity of a combatant', () {
      when(() => combatant.isImmuneTo(Element.ice)).thenReturn(true);
      when(() => combatant.isImmuneTo(Element.fire)).thenReturn(false);

      expect(readImmunities(combatant), equals(const Immunities(toIce: true)));

      when(() => combatant.isImmuneTo(Element.ice)).thenReturn(false);
      when(() => combatant.isImmuneTo(Element.fire)).thenReturn(true);

      expect(
        readImmunities(combatant),
        equals(const Immunities(toFire: true)),
      );
    });

    test('reads nobody as immune to nothing', () {
      expect(readImmunities(null), equals(Immunities.none));
    });
  });

  group('readMissile', () {
    test('reads a projectile into a missile', () {
      final projectile = Projectile(
        thrower: const EntityId(3),
        side: CombatantSide.foe,
        element: Element.ice,
        position: const Vec2(4, 5),
        velocity: const Vec2(1, 0),
        radius: 6,
        damage: 8,
        isReflectable: true,
      );

      final missile = readMissile(projectile);

      expect(
        missile,
        equals(
          Missile(
            thrower: projectile.thrower,
            side: projectile.side,
            element: projectile.element,
            position: projectile.position,
            velocity: projectile.velocity,
            radius: projectile.radius,
            damage: Damage(projectile.damage),
            isReflectable: projectile.isReflectable,
          ),
        ),
      );
    });
  });
}
