import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/engagement.dart';
import 'package:saviors_paradox/features/combat/domain/engagement_event.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

Strike _aStrike({
  CombatantSide side = CombatantSide.foe,
  AttackKind kind = AttackKind.melee,
  Element element = Element.plain,
}) => Strike(
  attacker: const EntityId(1),
  side: side,
  kind: kind,
  element: element,
  area: const WorldBox(centre: Vec2(0, 0), halfWidth: 20, halfHeight: 20),
  damage: const Damage(10),
  knockback: const Vec2(5, 0),
  isBlockable: true,
  isLethal: false,
);

Defender _aDefender({
  CombatantSide side = CombatantSide.akeris,
  WorldBox hurtbox = const WorldBox(
    centre: Vec2(30, 0),
    halfWidth: 20,
    halfHeight: 40,
  ),
  Guard? guard,
  bool isInvulnerable = false,
}) => Defender(
  id: const EntityId(2),
  side: side,
  hurtbox: hurtbox,
  guard: guard,
  isInvulnerable: isInvulnerable,
);

void main() {
  group('Engagement', () {
    test('an unguarded defender takes the strike', () {
      final strike = _aStrike();
      final engagement = Engagement(strike: strike, defender: _aDefender());

      final event = engagement.resolve();

      expect(
        event,
        StrikeLanded(
          strike: strike,
          target: const EntityId(2),
          at: const Vec2(15, 0),
          hitstop: const Seconds(0.06), // hit-feedback.md §2: Akeris is hit
        ),
      );
    });

    test('a chain strike on a foe holds 0.05 s', () {
      final strike = _aStrike(
        side: CombatantSide.akeris,
        kind: AttackKind.chain,
      );
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(side: CombatantSide.foe),
      );

      final event = engagement.resolve() as StrikeLanded;

      expect(event.hitstop, const Seconds(0.05)); // hit-feedback.md §2
    });

    test('a raised shield blocks the strike', () {
      final strike = _aStrike();
      final guard = Guard(
        shield: ShieldId.sacred,
        raisedFor: const Seconds(0.5),
      );
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(guard: guard),
      );

      final event = engagement.resolve();

      expect(
        event,
        StrikeBlocked(
          strike: strike,
          defender: const EntityId(2),
          shield: ShieldId.sacred,
          isPerfect: false,
          opensCounter: false,
          affliction: null,
          at: const Vec2(15, 0),
          hitstop: const Seconds(0.05), // hit-feedback.md §2
        ),
      );
    });

    test('a sacred perfect block opens the counter', () {
      final strike = _aStrike();
      final guard = Guard(
        shield: ShieldId.sacred,
        raisedFor: const Seconds(0.1),
      );
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(guard: guard),
      );

      final event = engagement.resolve() as StrikeBlocked;

      expect(event.isPerfect, isTrue);
      expect(event.opensCounter, isTrue);
      expect(event.affliction, isNull);
      expect(event.hitstop, const Seconds(0.09)); // counter.md §1
    });

    test('an ice perfect block freezes the attacker', () {
      final strike = _aStrike();
      final guard = Guard(shield: ShieldId.ice, raisedFor: const Seconds(0.1));
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(guard: guard),
      );

      final event = engagement.resolve() as StrikeBlocked;

      expect(event.opensCounter, isFalse);
      expect(
        event.affliction,
        Affliction(
          target: const EntityId(1),
          kind: StatusEffectKind.frozen,
          duration: const Seconds(1.5), // controls.md G16
        ),
      );
      expect(event.hitstop, const Seconds(0.05));
    });

    test('an ice perfect block slows an ice-immune attacker', () {
      final strike = _aStrike();
      final guard = Guard(shield: ShieldId.ice, raisedFor: const Seconds(0.1));
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(guard: guard),
        attacker: const Immunities(toIce: true),
      );

      final event = engagement.resolve() as StrikeBlocked;

      expect(
        event.affliction,
        Affliction(
          target: const EntityId(1),
          kind: StatusEffectKind.slowed,
          duration: const Seconds(1.5), // controls.md G16
        ),
      );
    });

    test('a fire perfect block burns the attacker', () {
      final strike = _aStrike();
      final guard = Guard(shield: ShieldId.fire, raisedFor: const Seconds(0.1));
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(guard: guard),
      );

      final event = engagement.resolve() as StrikeBlocked;

      expect(
        event.affliction,
        Affliction(
          target: const EntityId(1),
          kind: StatusEffectKind.burning,
          duration: const Seconds(1.5), // controls.md G16
        ),
      );
    });

    test('a perfect block against another kind inflicts nothing', () {
      final strike = _aStrike(kind: AttackKind.projectile);
      final guard = Guard(shield: ShieldId.ice, raisedFor: const Seconds(0.1));
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(guard: guard),
      );

      final event = engagement.resolve() as StrikeBlocked;

      expect(event.isPerfect, isTrue);
      expect(event.opensCounter, isFalse);
      expect(event.affliction, isNull);
      expect(event.hitstop, const Seconds(0.05)); // hit-feedback.md §2
    });

    test('a fire strike passes the sacred shield', () {
      final strike = _aStrike(element: Element.fire);
      final guard = Guard(
        shield: ShieldId.sacred,
        raisedFor: const Seconds(0.1),
      );
      final engagement = Engagement(
        strike: strike,
        defender: _aDefender(guard: guard),
      );

      final event = engagement.resolve();

      expect(event, isA<StrikeLanded>());
    });

    test('an engagement resolves only once', () {
      final engagement = Engagement(strike: _aStrike(), defender: _aDefender());

      final first = engagement.resolve();
      final second = engagement.resolve();

      expect(first, isA<StrikeLanded>());
      expect(second, isNull);
      expect(engagement.isResolved, isTrue);
    });

    test('a strike never lands on its own side', () {
      final engagement = Engagement(
        strike: _aStrike(),
        defender: _aDefender(side: CombatantSide.foe),
      );

      final event = engagement.resolve();

      expect(event, isNull);
      expect(engagement.isResolved, isTrue);
    });

    test('an invulnerable defender takes nothing', () {
      final engagement = Engagement(
        strike: _aStrike(),
        defender: _aDefender(isInvulnerable: true),
      );

      expect(engagement.resolve(), isNull);
    });

    test('a defender out of the area takes nothing', () {
      final engagement = Engagement(
        strike: _aStrike(),
        defender: _aDefender(
          hurtbox: const WorldBox(
            centre: Vec2(100, 0),
            halfWidth: 20,
            halfHeight: 40,
          ),
        ),
      );

      expect(engagement.resolve(), isNull);
    });
  });
}
