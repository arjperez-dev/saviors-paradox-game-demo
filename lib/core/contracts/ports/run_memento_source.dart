import 'package:saviors_paradox/core/contracts/ports/run_memento_part.dart';

abstract interface class RunMementoSource {
  String get key;

  RunMementoPart capture();

  void restore(RunMementoPart part);
}
