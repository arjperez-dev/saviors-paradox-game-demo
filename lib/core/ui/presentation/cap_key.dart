import 'package:saviors_paradox/core/input/domain/input_key.dart';

/// A key a button carries: the key it presses, and the name its cap shows
/// (`Esc` for [InputKey.escape]), which is the key, not a text
/// (06-ui/dialogue/dialogue.md §6).
final class CapKey {
  const CapKey(this.key, {required this.label})
    : assert(label.length > 0, 'a cap names its key');

  final InputKey key;
  final String label;

  @override
  bool operator ==(Object other) =>
      other is CapKey && other.key == key && other.label == label;

  @override
  int get hashCode => Object.hash(key, label);
}
