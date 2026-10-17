part of 'flights.dart';

/// One projectile in the air: an entity of [Flights], reused from its
/// pool and reached only through the root.
final class Flight {
  Flight._();

  FlightId _id = const FlightId(0);
  bool _isFlying = false;
  EntityId _thrower = const EntityId(0);
  EntityId _striker = const EntityId(0);
  CombatantSide _side = CombatantSide.neutral;
  Element _element = Element.plain;
  Vec2 _from = Vec2.zero;
  Vec2 _at = Vec2.zero;
  Vec2 _velocity = Vec2.zero;
  double _radius = 1;
  Damage _damage = Damage.none;
  bool _isReflectable = false;
  ShieldId? _turnedBy;
  Seconds _age = Seconds.zero;

  void _launch(FlightId id, Missile missile) {
    _id = id;
    _isFlying = true;
    _thrower = missile.thrower;
    _striker = missile.thrower;
    _side = missile.side;
    _element = missile.element;
    _from = missile.position;
    _at = missile.position;
    _velocity = missile.velocity;
    _radius = missile.radius;
    _damage = missile.damage;
    _isReflectable = missile.isReflectable;
    _turnedBy = null;
    _age = Seconds.zero;
  }

  void _move(Seconds dt) {
    _from = _at;
    _at = _at + _velocity.scaled(dt.value);
    _age = _age + dt;
    if (_age >= Flights.lifetime) {
      _isFlying = false;
    }
  }

  // reflect.md §2: straight back toward its thrower, level, faster.
  void _turn(Defender reflector, ShieldId shield, Vec2? throwerAt) {
    final towards = throwerAt == null ? -_velocity.x : throwerAt.x - _at.x;
    final speed = _velocity.length * Flights.reflectSpeedFactor;
    _velocity = Vec2(towards < 0 ? -speed : speed, 0);
    _striker = reflector.id;
    _side = reflector.side;
    _turnedBy = shield;
    _age = Seconds.zero;
  }

  void _spend() => _isFlying = false;

  @override
  bool operator ==(Object other) => other is Flight && other._id == _id;

  @override
  int get hashCode => _id.hashCode;
}
