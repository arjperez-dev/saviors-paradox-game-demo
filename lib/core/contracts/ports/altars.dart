import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/state/altar_item.dart';

abstract interface class Altars {
  void returnTo(EntityId altar, AltarItem item);
}
