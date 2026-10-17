import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/ports/attack.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';
import 'package:saviors_paradox/core/contracts/ports/projectile.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';
import 'package:saviors_paradox/features/combat/domain/missile.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

// Combat's anti-corruption layer (architecture.md §2.2): the contracts'
// types become combat's own model here, and nowhere else.

Strike readStrike(Attack attack) => Strike(
  attacker: attack.attacker,
  side: attack.side,
  kind: attack.kind,
  element: attack.element,
  area: attack.area,
  damage: Damage(attack.damage),
  knockback: attack.knockback,
  isBlockable: attack.isBlockable,
  isLethal: attack.isLethal,
);

Defender readDefender(Combatant combatant) {
  final shield = combatant.raisedShield;
  return Defender(
    id: combatant.id,
    side: combatant.side,
    hurtbox: combatant.hurtbox,
    guard: shield == null
        ? null
        : Guard(shield: shield.shield, raisedFor: shield.raisedFor),
    isInvulnerable: combatant.isInvulnerable,
    immunities: readImmunities(combatant),
  );
}

Immunities readImmunities(Combatant? combatant) => combatant == null
    ? Immunities.none
    : Immunities(
        toFire: combatant.isImmuneTo(Element.fire),
        toIce: combatant.isImmuneTo(Element.ice),
      );

Missile readMissile(Projectile projectile) => Missile(
  thrower: projectile.thrower,
  side: projectile.side,
  element: projectile.element,
  position: projectile.position,
  velocity: projectile.velocity,
  radius: projectile.radius,
  damage: Damage(projectile.damage),
  isReflectable: projectile.isReflectable,
);
