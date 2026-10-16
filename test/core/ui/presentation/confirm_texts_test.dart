import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/confirm_texts.dart';

void main() {
  group('ConfirmTexts', () {
    test('texts are equal by value', () {
      const texts = ConfirmTexts(
        ask: 'Quit?',
        note: 'Saved.',
        yes: 'Quit',
        no: 'Stay',
      );
      const same = ConfirmTexts(
        ask: 'Quit?',
        note: 'Saved.',
        yes: 'Quit',
        no: 'Stay',
      );
      const otherAsk = ConfirmTexts(
        ask: 'Leave?',
        note: 'Saved.',
        yes: 'Quit',
        no: 'Stay',
      );
      const otherNote = ConfirmTexts(
        ask: 'Quit?',
        note: 'Gone.',
        yes: 'Quit',
        no: 'Stay',
      );
      const otherYes = ConfirmTexts(
        ask: 'Quit?',
        note: 'Saved.',
        yes: 'Leave',
        no: 'Stay',
      );
      const otherNo = ConfirmTexts(
        ask: 'Quit?',
        note: 'Saved.',
        yes: 'Quit',
        no: 'Back',
      );

      expect(texts, same);
      expect(texts.hashCode, same.hashCode);
      expect(texts, isNot(otherAsk));
      expect(texts, isNot(otherNote));
      expect(texts, isNot(otherYes));
      expect(texts, isNot(otherNo));
    });

    test('a question with no words is refused', () {
      expect(
        () => ConfirmTexts(ask: '', note: 'Saved.', yes: 'Quit', no: 'Stay'),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => ConfirmTexts(ask: 'Quit?', note: 'Saved.', yes: '', no: 'Stay'),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => ConfirmTexts(ask: 'Quit?', note: 'Saved.', yes: 'Quit', no: ''),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
