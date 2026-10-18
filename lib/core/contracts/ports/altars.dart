import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';

abstract interface class Altars {
  void returnTo(EntityId altar, AltarItem item);

  /// Takes the item from the altar within reach of [point]; null when none
  /// is. The item returned only tells the caller it took something: whoever
  /// receives it learns of it from `ItemTaken`, never from the caller.
  AltarItem? takeWithin(Vec2 point);
}
