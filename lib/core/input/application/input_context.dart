import 'package:saviors_paradox/core/contracts/ports/event_sink.dart';
import 'package:saviors_paradox/core/input/application/input_reading.dart';
import 'package:saviors_paradox/core/input/domain/raw_input.dart';

/// What the keys and the pointer mean on one screen (design-patterns.md
/// §5): the only place a feature sees keys.
abstract interface class InputContext {
  /// Publishes to [commands] what [input] means here, given [reading].
  void translate(RawInput input, InputReading reading, EventSink commands);
}
