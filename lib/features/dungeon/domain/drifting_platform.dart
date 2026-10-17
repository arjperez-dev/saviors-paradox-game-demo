part of 'zone.dart';

/// One drifting platform of a zone (hazards.md): an entity of [Zone],
/// moved only by its root's time.
final class DriftingPlatform {
  DriftingPlatform._({
    required this._id,
    required Vec2 origin,
    required DriftPath path,
    required double phase,
  }) : _origin = origin,
       _path = path,
       _phase = phase,
       _box = path.boxAt(origin: origin, phase: phase, time: Seconds.zero);

  final EntityId _id;
  final Vec2 _origin;
  final DriftPath _path;
  final double _phase;
  Seconds _time = Seconds.zero;
  WorldBox _box;

  void _advance(Seconds dt) {
    _time = _time + dt;
    _box = _path.boxAt(origin: _origin, phase: _phase, time: _time);
  }

  @override
  bool operator ==(Object other) =>
      other is DriftingPlatform && other._id == _id;

  @override
  int get hashCode => _id.hashCode;
}
