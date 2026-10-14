import 'package:saviors_paradox/core/contracts/ports/stage_change.dart';

abstract interface class BossRoomStage {
  void apply(StageChange change);
}
