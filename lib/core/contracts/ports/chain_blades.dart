import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/chain_pull.dart';
import 'package:saviors_paradox/core/contracts/ports/chain_throw.dart';

abstract interface class ChainBlades {
  void startThrow(ChainThrow request);

  void endThrow(Vec2 aim);

  void letGo();

  ChainPull get pull;
}
