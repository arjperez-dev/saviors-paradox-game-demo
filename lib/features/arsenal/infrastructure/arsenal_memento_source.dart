// Stub: not implemented.

import 'package:saviors_paradox/core/contracts/ports/run_memento_part.dart';
import 'package:saviors_paradox/core/contracts/ports/run_memento_source.dart';

final class ArsenalMementoSource implements RunMementoSource {
  @override
  String get key => '';

  @override
  RunMementoPart capture() => const RunMementoPart(key: '', payload: '');

  @override
  void restore(RunMementoPart part) {}
}
