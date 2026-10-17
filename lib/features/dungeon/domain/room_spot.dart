import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/features/dungeon/domain/spot_kind.dart';

/// A marked spot of a template, in su from its room's top left.
final class RoomSpot {
  const RoomSpot({required this.kind, required this.position});

  final SpotKind kind;
  final Vec2 position;

  RoomSpot mirrored(double roomWidth) =>
      RoomSpot(kind: kind, position: Vec2(roomWidth - position.x, position.y));

  @override
  bool operator ==(Object other) =>
      other is RoomSpot && other.kind == kind && other.position == position;

  @override
  int get hashCode => Object.hash(kind, position);
}
