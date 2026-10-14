import 'package:saviors_paradox/core/contracts/events/game_event.dart';
import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class ProjectileReflected implements GameEvent {
  const ProjectileReflected({
    required this.reflector,
    required this.thrower,
    required this.shield,
    required this.at,
  });

  final EntityId reflector;
  final EntityId thrower;
  final ShieldId shield;
  final Vec2 at;
}
