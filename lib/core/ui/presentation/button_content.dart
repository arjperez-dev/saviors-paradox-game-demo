/// What a button says: its label, already translated by the screen, and the
/// name of the key cap it carries, if any (06-ui/ui.md §3).
final class ButtonContent {
  const ButtonContent({required this.label, this.keyLabel})
    : assert(label.length > 0, 'a button says something'),
      assert(keyLabel == null || keyLabel.length > 0, 'a cap names a key');

  final String label;
  final String? keyLabel;

  @override
  bool operator ==(Object other) =>
      other is ButtonContent &&
      other.label == label &&
      other.keyLabel == keyLabel;

  @override
  int get hashCode => Object.hash(label, keyLabel);
}
