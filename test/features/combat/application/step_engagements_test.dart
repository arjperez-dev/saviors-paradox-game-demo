import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/events/hit_landed.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/features/combat/application/report_exchange.dart';
import 'package:saviors_paradox/features/combat/application/step_engagements.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/engagement.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

import '../mocks.dart';

class _FakeGameEvent extends Fake implements GameEvent {}

Strike _aStrike({
  EntityId attacker = const EntityId(1),
  CombatantSide side = CombatantSide.foe,
}) => Strike(
  attacker: attacker,
  side: side,
  kind: AttackKind.melee,
  element: Element.plain,
  area: const WorldBox(centre: Vec2(0, 0), halfWidth: 20, halfHeight: 20),
  damage: const Damage(10),
  knockback: const Vec2(5, 0),
  isBlockable: true,
  isLethal: false,
);

Defender _aDefender({
  EntityId id = const EntityId(2),
  CombatantSide side = CombatantSide.akeris,
}) => Defender(
  id: id,
  side: side,
  hurtbox: const WorldBox(centre: Vec2(10, 0), halfWidth: 20, halfHeight: 40),
  guard: null,
  isInvulnerable: false,
);

void main() {
  setUpAll(() => registerFallbackValue(_FakeGameEvent()));

  group('StepEngagements', () {
    late MockEngagementRepository engagements;
    late MockEventSink events;
    late MockStatusEffectControl statuses;
    late StepEngagements system;

    setUp(() {
      engagements = MockEngagementRepository();
      events = MockEventSink();
      statuses = MockStatusEffectControl();
      system = StepEngagements(engagements, ReportExchange(events, statuses));
    });

    test('resolves every pending engagement in one step', () {
      final first = Engagement(
        strike: _aStrike(attacker: const EntityId(1)),
        defender: _aDefender(id: const EntityId(2)),
      );
      final second = Engagement(
        strike: _aStrike(attacker: const EntityId(3)),
        defender: _aDefender(id: const EntityId(4)),
      );
      final pending = [first, second];
      when(() => engagements.next()).thenAnswer(
        (_) => pending.isEmpty ? null : pending.removeAt(0),
      );

      system.step(const Seconds(1 / 60));

      final captured = verify(() => events.publish(captureAny())).captured;
      expect(
        captured.whereType<HitLanded>().map((event) => event.target),
        [const EntityId(2), const EntityId(4)],
      );
    });

    test('publishes nothing for an engagement that lands nothing', () {
      final engagement = Engagement(
        strike: _aStrike(side: CombatantSide.foe),
        defender: _aDefender(side: CombatantSide.foe),
      );
      final pending = [engagement];
      when(() => engagements.next()).thenAnswer(
        (_) => pending.isEmpty ? null : pending.removeAt(0),
      );

      system.step(const Seconds(1 / 60));

      verifyNever(() => events.publish(any()));
    });

    test('resolves what follows an engagement that lands nothing', () {
      final nonLanding = Engagement(
        strike: _aStrike(side: CombatantSide.foe),
        defender: _aDefender(id: const EntityId(2), side: CombatantSide.foe),
      );
      final landing = Engagement(
        strike: _aStrike(attacker: const EntityId(3)),
        defender: _aDefender(id: const EntityId(4)),
      );
      final pending = [nonLanding, landing];
      when(() => engagements.next()).thenAnswer(
        (_) => pending.isEmpty ? null : pending.removeAt(0),
      );

      system.step(const Seconds(1 / 60));

      final captured = verify(() => events.publish(captureAny())).captured;
      expect(
        captured.whereType<HitLanded>().map((event) => event.target),
        [const EntityId(4)],
      );
    });

    test('leaves nothing pending after a step', () {
      final engagement = Engagement(strike: _aStrike(), defender: _aDefender());
      final pending = [engagement];
      when(() => engagements.next()).thenAnswer(
        (_) => pending.isEmpty ? null : pending.removeAt(0),
      );

      system.step(const Seconds(1 / 60));

      verify(() => engagements.next()).called(2);
    });
  });
}
