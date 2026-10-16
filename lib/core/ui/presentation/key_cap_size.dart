/// How tall a key cap is, in hu: 32 by default (the 06-ui sandbox's
/// `keyCap`); the dialogue's Enter is 36 (06-ui/dialogue/dialogue.md §3).
final class KeyCapSize {
  const KeyCapSize({this.height = 32})
    : assert(height > 0, 'a cap has a height');

  final double height;

  @override
  bool operator ==(Object other) =>
      other is KeyCapSize && other.height == height;

  @override
  int get hashCode => height.hashCode;
}
