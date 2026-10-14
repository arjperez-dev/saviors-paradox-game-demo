import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';

final class ShieldSnapshot {
  const ShieldSnapshot({
    required this.shield,
    required this.level,
    required this.usesLeft,
    required this.isBroken,
    required this.isUnderRepair,
  });

  final ShieldId shield;
  final int level;
  final int? usesLeft;
  final bool isBroken;
  final bool isUnderRepair;
}
