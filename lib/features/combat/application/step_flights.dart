import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/collision_world.dart';
import 'package:saviors_paradox/features/combat/application/combatant_roster.dart';
import 'package:saviors_paradox/features/combat/application/contract_reading.dart';
import 'package:saviors_paradox/features/combat/application/ports/flights_repository.dart';
import 'package:saviors_paradox/features/combat/application/report_exchange.dart';
import 'package:saviors_paradox/features/combat/domain/flight_track.dart';
import 'package:saviors_paradox/features/combat/domain/flights.dart';

/// Moves the projectiles in the air and settles what each one met.
final class StepFlights {
  StepFlights({
    required FlightsRepository flights,
    required CombatantRoster roster,
    required CollisionWorld world,
    required ReportExchange report,
  }) : _flights = flights, // ignore: prefer_initializing_formals — private
       _roster = roster, // ignore: prefer_initializing_formals — ditto
       _world = world, // ignore: prefer_initializing_formals — ditto
       _report = report; // ignore: prefer_initializing_formals — ditto

  final FlightsRepository _flights;
  final CombatantRoster _roster;
  final CollisionWorld _world;
  final ReportExchange _report;

  void step(Seconds dt) {
    final flights = _flights.load();
    flights.advance(dt);
    for (var slot = 0; slot < Flights.capacity; slot++) {
      final id = flights.flyingAt(slot);
      if (id != null) {
        _settle(flights, flights.trackOf(id));
      }
    }
    _flights.save(flights);
  }

  void _settle(Flights flights, FlightTrack track) {
    if (_world.cast(track.from, track.to) != null) {
      final crashed = flights.crash(track.id);
      if (crashed != null) {
        _report.flight(crashed);
      }
      return;
    }
    final bodies = _roster.near(track.to, track.radius);
    final throwerAt = _roster.positionOf(track.thrower);
    for (var i = 0; i < bodies.length; i++) {
      final met = flights.meet(
        track.id,
        readDefender(bodies.elementAt(i)),
        throwerAt: throwerAt,
      );
      if (met != null) {
        _report.flight(met);
        return;
      }
    }
  }
}
