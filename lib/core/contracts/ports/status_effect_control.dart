import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';

abstract interface class StatusEffectControl {
  void apply(EntityId target, StatusEffectKind effect, Seconds duration);

  void clear(EntityId target, StatusEffectKind effect);

  bool has(EntityId target, StatusEffectKind effect);
}
