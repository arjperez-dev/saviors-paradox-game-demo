import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/button_content.dart';

void main() {
  group('ButtonContent', () {
    test('contents are equal by value', () {
      const content = ButtonContent(label: 'Resume', keyLabel: 'Esc');
      const same = ButtonContent(label: 'Resume', keyLabel: 'Esc');
      const noKeyLabel = ButtonContent(label: 'Resume');

      expect(content, same);
      expect(content.hashCode, same.hashCode);
      expect(content, isNot(noKeyLabel));
    });

    test('an empty label is refused', () {
      expect(() => ButtonContent(label: ''), throwsA(isA<AssertionError>()));
      expect(
        () => ButtonContent(label: 'Back', keyLabel: ''),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
