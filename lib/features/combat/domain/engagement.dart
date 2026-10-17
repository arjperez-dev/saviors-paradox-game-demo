import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_kind.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/block_judge.dart';
import 'package:saviors_paradox/features/combat/domain/block_verdict.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/engagement_event.dart';
import 'package:saviors_paradox/features/combat/domain/hitstop_rule.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';
import 'package:saviors_paradox/features/combat/domain/strike.dart';

/// One exchange: a strike meeting one defender (glossary §4). It resolves
/// once, into what landed or what stopped it.
final class Engagement {
  Engagement({
    required Strike strike,
    required Defender defender,
    Immunities attacker = Immunities.none,
  }) : _strike = strike, // ignore: prefer_initializing_formals — private field
       _defender = defender, // ignore: prefer_initializing_formals — ditto
       _attacker = attacker; // ignore: prefer_initializing_formals — ditto

  final Strike _strike;
  final Defender _defender;
  final Immunities _attacker;
  bool _isResolved = false;

  bool get isResolved => _isResolved;

  /// Resolves the exchange: null when it was resolved already, or when the
  /// defender is on the strike's side, invulnerable or out of its area.
  EngagementEvent? resolve() {
    if (_isResolved) {
      return null;
    }
    _isResolved = true;
    if (!_reaches) {
      return null;
    }
    final guard = _defender.guard;
    final verdict = const BlockJudge().judge(
      element: _strike.element,
      isBlockable: _strike.isBlockable,
      guard: guard,
    );
    if (guard == null || verdict == BlockVerdict.unguarded) {
      return _landed();
    }
    return _blocked(guard.shield, isPerfect: verdict == BlockVerdict.perfect);
  }

  bool get _reaches =>
      _strike.side != _defender.side &&
      !_defender.isInvulnerable &&
      _strike.area.overlaps(_defender.hurtbox);

  StrikeLanded _landed() => StrikeLanded(
    strike: _strike,
    target: _defender.id,
    at: _contact,
    hitstop: const HitstopRule().onHit(
      target: _defender.side,
      kind: _strike.kind,
    ),
  );

  StrikeBlocked _blocked(ShieldId shield, {required bool isPerfect}) {
    final isPerfectMelee = isPerfect && _strike.kind == AttackKind.melee;
    final opensCounter = isPerfectMelee && shield == ShieldId.sacred;
    return StrikeBlocked(
      strike: _strike,
      defender: _defender.id,
      shield: shield,
      isPerfect: isPerfect,
      opensCounter: opensCounter,
      affliction: isPerfectMelee
          ? Affliction.byShield(
              shield: shield,
              target: _strike.attacker,
              immunities: _attacker,
              duration: Affliction.afterPerfectBlock,
            )
          : null,
      at: _contact,
      hitstop: opensCounter ? HitstopRule.onCounter : HitstopRule.onBlock,
    );
  }

  // The centre of where the strike's area and the hurtbox overlap.
  Vec2 get _contact {
    final area = _strike.area;
    final body = _defender.hurtbox;
    return Vec2(
      (math.max(area.left, body.left) + math.min(area.right, body.right)) / 2,
      (math.max(area.top, body.top) + math.min(area.bottom, body.bottom)) / 2,
    );
  }
}
