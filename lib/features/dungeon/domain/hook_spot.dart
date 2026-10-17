import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

/// A ring the chain or the free hand can take, where it hangs.
final class HookSpot {
  const HookSpot({required this.id, required this.position});

  final EntityId id;
  final Vec2 position;

  @override
  bool operator ==(Object other) =>
      other is HookSpot && other.id == id && other.position == position;

  @override
  int get hashCode => Object.hash(id, position);
}
