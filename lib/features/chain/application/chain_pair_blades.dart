// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/chain_blades.dart';
import 'package:saviors_paradox/core/contracts/ports/chain_pull.dart';
import 'package:saviors_paradox/core/contracts/ports/chain_throw.dart';

final class ChainPairBlades implements ChainBlades {
  @override
  void startThrow(ChainThrow request) {}

  @override
  void endThrow(Vec2 aim) {}

  @override
  void letGo() {}

  @override
  ChainPull get pull => const NoPull();
}
