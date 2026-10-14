import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/hook_point_kind.dart';

final class HookPoint {
  const HookPoint({
    required this.id,
    required this.kind,
    required this.position,
  });

  final EntityId id;
  final HookPointKind kind;
  final Vec2 position;
}
