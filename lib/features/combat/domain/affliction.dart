import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/core/contracts/ports/status_effect_kind.dart';
import 'package:saviors_paradox/features/combat/domain/immunities.dart';

/// A status effect an exchange inflicts on one body.
final class Affliction {
  Affliction({required this.target, required this.kind, required this.duration})
    : assert(duration.value > 0, 'an affliction lasts some time');

  /// controls.md G16: a perfect block against a melee hit.
  static const Seconds afterPerfectBlock = Seconds(1.5);

  /// reflect.md: a reflected projectile on its thrower.
  static const Seconds afterReflect = Seconds(0.5);

  final EntityId target;
  final StatusEffectKind kind;
  final Seconds duration;

  /// What [shield] inflicts on [target] for [duration]: the ice shield
  /// freezes (slows an ice-immune body), the fire shield burns (nothing on
  /// a fire-immune body), the sacred shield nothing.
  static Affliction? byShield({
    required ShieldId shield,
    required EntityId target,
    required Immunities immunities,
    required Seconds duration,
  }) => switch (shield) {
    ShieldId.sacred => null,
    ShieldId.ice => Affliction(
      target: target,
      kind: immunities.toIce
          ? StatusEffectKind.slowed
          : StatusEffectKind.frozen,
      duration: duration,
    ),
    ShieldId.fire =>
      immunities.toFire
          ? null
          : Affliction(
              target: target,
              kind: StatusEffectKind.burning,
              duration: duration,
            ),
  };

  @override
  bool operator ==(Object other) =>
      other is Affliction &&
      other.target == target &&
      other.kind == kind &&
      other.duration == duration;

  @override
  int get hashCode => Object.hash(target, kind, duration);
}
