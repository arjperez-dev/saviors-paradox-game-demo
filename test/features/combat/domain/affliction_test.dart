import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';

void main() {
  group('Affliction', () {
    test('the ice shield freezes the body', () {
      // 00-game/controls.md G16: a perfect block with the ice shield freezes
      // the attacker for 1.5 s.
      final afflicted = Affliction.byShield(
        shield: ShieldId.ice,
        target: const EntityId(7),
        immunities: Immunities.none,
        duration: Affliction.afterPerfectBlock,
      );

      expect(
        afflicted,
        equals(
          Affliction(
            target: const EntityId(7),
            kind: StatusEffectKind.frozen,
            duration: const Seconds(1.5),
          ),
        ),
      );
    });

    test('the ice shield slows an ice-immune body', () {
      final afflicted = Affliction.byShield(
        shield: ShieldId.ice,
        target: const EntityId(7),
        immunities: const Immunities(toIce: true),
        duration: Affliction.afterPerfectBlock,
      );

      expect(afflicted?.kind, equals(StatusEffectKind.slowed));
      expect(afflicted?.duration, equals(Affliction.afterPerfectBlock));
    });

    test('the fire shield burns the body', () {
      // 00-game/controls.md G16: a perfect block with the fire shield burns
      // the attacker for 1.5 s.
      final afflicted = Affliction.byShield(
        shield: ShieldId.fire,
        target: const EntityId(7),
        immunities: Immunities.none,
        duration: const Seconds(1.5),
      );

      expect(afflicted?.kind, equals(StatusEffectKind.burning));
      expect(afflicted?.duration, equals(const Seconds(1.5)));
    });

    test('the fire shield spares a fire-immune body', () {
      final afflicted = Affliction.byShield(
        shield: ShieldId.fire,
        target: const EntityId(7),
        immunities: const Immunities(toFire: true),
        duration: const Seconds(1.5),
      );

      expect(afflicted, isNull);
    });

    test('the sacred shield inflicts nothing', () {
      final withNoImmunities = Affliction.byShield(
        shield: ShieldId.sacred,
        target: const EntityId(7),
        immunities: Immunities.none,
        duration: const Seconds(1.5),
      );
      final withImmunities = Affliction.byShield(
        shield: ShieldId.sacred,
        target: const EntityId(7),
        immunities: const Immunities(toFire: true, toIce: true),
        duration: const Seconds(1.5),
      );

      expect(withNoImmunities, isNull);
      expect(withImmunities, isNull);
    });

    test('an affliction after a reflect lasts half a second', () {
      // 02-art-direction/fx/reflect/reflect.md: a reflected projectile
      // afflicts its thrower for 0.5 s.
      expect(Affliction.afterReflect, equals(const Seconds(0.5)));
      // 00-game/controls.md G16: a perfect block afflicts the attacker for
      // 1.5 s.
      expect(Affliction.afterPerfectBlock, equals(const Seconds(1.5)));
    });

    test('an affliction always lasts some time', () {
      expect(
        () => Affliction(
          target: const EntityId(1),
          kind: StatusEffectKind.frozen,
          duration: Seconds.zero,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
