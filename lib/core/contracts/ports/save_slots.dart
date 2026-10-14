import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/ports/save_slot_failure.dart';
import 'package:saviors_paradox/core/contracts/state/save_slot_summary.dart';

abstract interface class SaveSlots {
  Future<List<SaveSlotSummary>> summaries();

  Future<Result<void, SaveSlotFailure>> load(int slot);
}
