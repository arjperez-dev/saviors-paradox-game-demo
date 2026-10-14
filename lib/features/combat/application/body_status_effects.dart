// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_control.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';

final class BodyStatusEffects implements StatusEffectControl {
  @override
  void apply(EntityId target, StatusEffectKind effect, Seconds duration) {}

  @override
  void clear(EntityId target, StatusEffectKind effect) {}

  @override
  bool has(EntityId target, StatusEffectKind effect) => false;
}
