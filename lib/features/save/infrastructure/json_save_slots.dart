// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/kernel/result.dart';
import 'package:saviors_paradox/core/contracts/ports/save_slot_failure.dart';
import 'package:saviors_paradox/core/contracts/ports/save_slots.dart';
import 'package:saviors_paradox/core/contracts/state/save_slot_summary.dart';

final class JsonSaveSlots implements SaveSlots {
  @override
  Future<List<SaveSlotSummary>> summaries() async => const [];

  @override
  Future<Result<void, SaveSlotFailure>> load(int slot) async =>
      const Failure(SaveSlotFailure.missing);
}
