import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/world_box.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_side.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/affliction.dart';
import 'package:saviors_paradox/features/combat/domain/damage.dart';
import 'package:saviors_paradox/features/combat/domain/defender.dart';
import 'package:saviors_paradox/features/combat/domain/flight_event.dart';
import 'package:saviors_paradox/features/combat/domain/flight_id.dart';
import 'package:saviors_paradox/features/combat/domain/flight_track.dart';
import 'package:saviors_paradox/features/combat/domain/flights.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/missile.dart';

Missile _aMissile({
  EntityId thrower = const EntityId(1),
  CombatantSide side = CombatantSide.foe,
  Vec2 velocity = const Vec2(400, 0),
  bool isReflectable = true,
}) => Missile(
  thrower: thrower,
  side: side,
  element: Element.plain,
  position: Vec2.zero,
  velocity: velocity,
  radius: 10,
  damage: const Damage(8),
  isReflectable: isReflectable,
);

Defender _akeris({Guard? guard, bool isInvulnerable = false}) => Defender(
  id: const EntityId(2),
  side: CombatantSide.akeris,
  hurtbox: const WorldBox(centre: Vec2(200, 0), halfWidth: 20, halfHeight: 40),
  guard: guard,
  isInvulnerable: isInvulnerable,
);

Defender _bodyAt(EntityId id, CombatantSide side, Vec2 at, {Guard? guard}) =>
    Defender(
      id: id,
      side: side,
      hurtbox: WorldBox(centre: at, halfWidth: 20, halfHeight: 20),
      guard: guard,
      isInvulnerable: false,
    );

void main() {
  group('Flights', () {
    late Flights flights;

    setUp(() => flights = Flights());

    FlightId aTurnedFlight({ShieldId shield = ShieldId.sacred}) {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));
      flights.meet(
        id,
        _akeris(
          guard: Guard(shield: shield, raisedFor: const Seconds(0.1)),
        ),
        throwerAt: Vec2.zero,
      );
      return id;
    }

    test('a launched flight is in the air', () {
      final id = flights.launch(_aMissile());

      expect(flights.flyingCount, equals(1));
      expect(flights.flyingAt(0), equals(id));
    });

    test('a flight moves by its velocity', () {
      final id = flights.launch(_aMissile());

      flights.advance(const Seconds(0.5));

      expect(
        flights.trackOf(id),
        equals(
          FlightTrack(
            id: id,
            thrower: const EntityId(1),
            from: Vec2.zero,
            to: const Vec2(200, 0),
            radius: 10,
          ),
        ),
      );
    });

    test('a flight is spent after four seconds', () {
      final id = flights.launch(_aMissile());

      flights.advance(const Seconds(4));

      expect(flights.flyingCount, equals(0));
      expect(() => flights.trackOf(id), throwsArgumentError);
    });

    test('a launch into a full pool reuses the oldest flight', () {
      FlightId? first;
      FlightId? last;
      for (var i = 0; i < 65; i++) {
        final id = flights.launch(_aMissile());
        first ??= id;
        last = id;
      }

      expect(flights.flyingCount, equals(64));
      expect(() => flights.trackOf(first!), throwsArgumentError);
      expect(() => flights.trackOf(last!), returnsNormally);
    });

    test('an unguarded body takes the flight', () {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));

      final event = flights.meet(id, _akeris());

      expect(
        event,
        equals(
          const FlightStruck(
            striker: EntityId(1),
            target: EntityId(2),
            element: Element.plain,
            damage: Damage(8),
            at: Vec2(180, 0),
            hitstop: Seconds(0.06),
            affliction: null,
          ),
        ),
      );
      expect(flights.flyingCount, equals(0));
    });

    test('a flight on another body holds the default hitstop', () {
      final id = flights.launch(_aMissile(side: CombatantSide.akeris));
      flights.advance(const Seconds(0.45));
      final foeInAkerisPlace = _bodyAt(
        const EntityId(2),
        CombatantSide.foe,
        const Vec2(180, 0),
      );

      final event = flights.meet(id, foeInAkerisPlace) as FlightStruck;

      expect(event.hitstop, equals(const Seconds(0.05)));
    });

    test('a raised shield blocks the flight', () {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));
      final akeris = _akeris(
        guard: Guard(shield: ShieldId.sacred, raisedFor: const Seconds(1)),
      );

      final event = flights.meet(id, akeris);

      expect(
        event,
        equals(
          const FlightBlocked(
            thrower: EntityId(1),
            defender: EntityId(2),
            element: Element.plain,
            shield: ShieldId.sacred,
            isPerfect: false,
            at: Vec2(180, 0),
            hitstop: Seconds(0.05),
          ),
        ),
      );
      expect(flights.flyingCount, equals(0));
    });

    test('a perfect block turns the flight back to its thrower', () {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));
      final akeris = _akeris(
        guard: Guard(shield: ShieldId.sacred, raisedFor: const Seconds(0.1)),
      );

      final event = flights.meet(id, akeris, throwerAt: Vec2.zero);

      expect(
        event,
        equals(
          const FlightTurned(
            reflector: EntityId(2),
            thrower: EntityId(1),
            shield: ShieldId.sacred,
            at: Vec2(180, 0),
            hitstop: Seconds(0.07),
          ),
        ),
      );

      flights.advance(const Seconds(0.25));

      expect(flights.trackOf(id).to, equals(const Vec2(20, 0)));
    });

    test('a turned flight flies level at 1.6 times its speed', () {
      final id = flights.launch(_aMissile(velocity: const Vec2(300, 400)));
      flights.advance(const Seconds(0.45));
      final p = flights.trackOf(id).to;
      final reflector = Defender(
        id: const EntityId(2),
        side: CombatantSide.akeris,
        hurtbox: WorldBox(centre: p, halfWidth: 1, halfHeight: 1),
        guard: Guard(shield: ShieldId.sacred, raisedFor: const Seconds(0.1)),
        isInvulnerable: false,
      );

      flights.meet(id, reflector, throwerAt: const Vec2(-1000, 0));
      flights.advance(const Seconds(1));

      expect(flights.trackOf(id).to, equals(p + const Vec2(-800, 0)));
    });

    test('a turned flight passes by every body but its thrower', () {
      final id = aTurnedFlight();
      final foe = _bodyAt(
        const EntityId(5),
        CombatantSide.foe,
        const Vec2(180, 0),
      );

      final event = flights.meet(id, foe);

      expect(event, isNull);
      expect(flights.flyingCount, equals(1));
    });

    test('a turned flight damages its thrower', () {
      final id = aTurnedFlight();
      final thrower = _bodyAt(
        const EntityId(1),
        CombatantSide.foe,
        const Vec2(180, 0),
      );

      final event = flights.meet(id, thrower);

      expect(
        event,
        equals(
          const FlightStruck(
            striker: EntityId(2),
            target: EntityId(1),
            element: Element.plain,
            damage: Damage(8),
            at: Vec2(180, 0),
            hitstop: Seconds(0.05),
            affliction: null,
          ),
        ),
      );
    });

    test('a flight turned by the ice shield freezes its thrower', () {
      final id = aTurnedFlight(shield: ShieldId.ice);
      final thrower = _bodyAt(
        const EntityId(1),
        CombatantSide.foe,
        const Vec2(180, 0),
      );

      final event = flights.meet(id, thrower) as FlightStruck;

      expect(
        event.affliction,
        equals(
          Affliction(
            target: const EntityId(1),
            kind: StatusEffectKind.frozen,
            duration: const Seconds(0.5),
          ),
        ),
      );
    });

    test('a flight turned by the fire shield burns its thrower', () {
      final id = aTurnedFlight(shield: ShieldId.fire);
      final thrower = _bodyAt(
        const EntityId(1),
        CombatantSide.foe,
        const Vec2(180, 0),
      );

      final event = flights.meet(id, thrower) as FlightStruck;

      expect(
        event.affliction,
        equals(
          Affliction(
            target: const EntityId(1),
            kind: StatusEffectKind.burning,
            duration: const Seconds(0.5),
          ),
        ),
      );
    });

    test('a flight turns only once', () {
      final id = aTurnedFlight();
      final thrower = _bodyAt(
        const EntityId(1),
        CombatantSide.foe,
        const Vec2(180, 0),
        guard: Guard(shield: ShieldId.sacred, raisedFor: const Seconds(0.1)),
      );

      final event = flights.meet(id, thrower);

      expect(event, isA<FlightBlocked>());
      expect((event as FlightBlocked).isPerfect, isTrue);
      expect(flights.flyingCount, equals(0));
    });

    test('an unreflectable flight is only blocked', () {
      final id = flights.launch(_aMissile(isReflectable: false));
      flights.advance(const Seconds(0.45));
      final akeris = _akeris(
        guard: Guard(shield: ShieldId.sacred, raisedFor: const Seconds(0.1)),
      );

      final event = flights.meet(id, akeris);

      expect(event, isA<FlightBlocked>());
      expect((event as FlightBlocked).isPerfect, isTrue);
    });

    test('a spent flight meets nothing', () {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));
      flights.crash(id);

      expect(flights.meet(id, _akeris()), isNull);
      expect(flights.crash(id), isNull);
    });

    test('crashing a flight spends it where it is', () {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));

      final event = flights.crash(id);

      expect(
        event,
        equals(const FlightCrashed(element: Element.plain, at: Vec2(180, 0))),
      );
      expect(flights.flyingCount, equals(0));
    });

    test('a flight never meets its own side', () {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));
      final foe = _bodyAt(
        const EntityId(5),
        CombatantSide.foe,
        const Vec2(180, 0),
      );

      final event = flights.meet(id, foe);

      expect(event, isNull);
      expect(flights.flyingCount, equals(1));
    });

    test('a flight passes an invulnerable body', () {
      final id = flights.launch(_aMissile());
      flights.advance(const Seconds(0.45));

      final event = flights.meet(id, _akeris(isInvulnerable: true));

      expect(event, isNull);
    });

    test('a flight meets only a body it reaches', () {
      final id = flights.launch(_aMissile());

      final event = flights.meet(id, _akeris());

      expect(event, isNull);
    });
  });
}
