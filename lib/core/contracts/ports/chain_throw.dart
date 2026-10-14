import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class ChainThrow {
  const ChainThrow({
    required this.from,
    required this.aim,
    required this.isUpHeld,
    required this.isDownHeld,
    required this.isFromFreeHand,
  });

  final Vec2 from;
  final Vec2 aim;
  final bool isUpHeld;
  final bool isDownHeld;
  final bool isFromFreeHand;
}
