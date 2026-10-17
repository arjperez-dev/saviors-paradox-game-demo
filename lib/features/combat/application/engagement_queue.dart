import 'dart:math' as math;

import 'package:saviors_paradox/core/contracts/ports/attack.dart';
import 'package:saviors_paradox/core/contracts/ports/attack_resolver.dart';
import 'package:saviors_paradox/core/contracts/ports/projectile.dart';
import 'package:saviors_paradox/features/combat/application/combatant_roster.dart';
import 'package:saviors_paradox/features/combat/application/contract_reading.dart';
import 'package:saviors_paradox/features/combat/application/ports/engagement_repository.dart';
import 'package:saviors_paradox/features/combat/application/ports/flights_repository.dart';
import 'package:saviors_paradox/features/combat/domain/engagement.dart';

/// Takes the attacks bodies strike and throw; they resolve when combat
/// steps.
final class EngagementQueue implements AttackResolver {
  EngagementQueue({
    required CombatantRoster roster,
    required EngagementRepository engagements,
    required FlightsRepository flights,
  }) : _roster = roster, // ignore: prefer_initializing_formals — private field
       _engagements = engagements, // ignore: prefer_initializing_formals
       _flights = flights; // ignore: prefer_initializing_formals — ditto

  final CombatantRoster _roster;
  final EngagementRepository _engagements;
  final FlightsRepository _flights;

  @override
  void strike(Attack attack) {
    final strike = readStrike(attack);
    final attacker = readImmunities(_roster.byId(attack.attacker));
    final area = attack.area;
    final reach = math.sqrt(
      area.halfWidth * area.halfWidth + area.halfHeight * area.halfHeight,
    );
    for (final body in _roster.near(area.centre, reach)) {
      _engagements.add(
        Engagement(
          strike: strike,
          defender: readDefender(body),
          attacker: attacker,
        ),
      );
    }
  }

  @override
  void launch(Projectile projectile) {
    final flights = _flights.load();
    flights.launch(readMissile(projectile));
    _flights.save(flights);
  }
}
