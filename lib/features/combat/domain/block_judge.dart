import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/features/combat/domain/block_verdict.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';
import 'package:saviors_paradox/features/combat/domain/shield_stops.dart';

/// Decides whether a shield stopped an attack, and whether perfectly.
final class BlockJudge {
  const BlockJudge();

  /// VISION.md §Assumptions leaves it to the game; operator, 2026-10-16.
  static const Seconds perfectWindow = Seconds(0.2);

  BlockVerdict judge({
    required Element element,
    required bool isBlockable,
    required Guard? guard,
  }) {
    if (guard == null ||
        !isBlockable ||
        !ShieldStops(element).isSatisfiedBy(guard.shield)) {
      return BlockVerdict.unguarded;
    }
    return guard.raisedFor <= perfectWindow
        ? BlockVerdict.perfect
        : BlockVerdict.blocked;
  }
}
