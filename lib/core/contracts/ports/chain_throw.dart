import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';

final class ChainThrow {
  const ChainThrow({
    required this.from,
    required this.aim,
    required this.pointerStillFor,
    required this.isUpHeld,
    required this.isDownHeld,
    required this.isFromFreeHand,
    required this.isAirborne,
  });

  final Vec2 from;
  final Vec2 aim;
  final Seconds pointerStillFor;
  final bool isUpHeld;
  final bool isDownHeld;
  final bool isFromFreeHand;
  final bool isAirborne;
}
