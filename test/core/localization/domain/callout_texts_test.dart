import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/localization/domain/callout_texts.dart';

void main() {
  final keys = [
    CalloutKeys.slash,
    CalloutKeys.thud,
    CalloutKeys.chain,
    CalloutKeys.clack,
    CalloutKeys.clang,
    CalloutKeys.crish,
    CalloutKeys.fwoom,
    CalloutKeys.crack,
    CalloutKeys.burn,
    CalloutKeys.frost,
    CalloutKeys.counter,
    CalloutKeys.reflect,
  ];

  group('calloutTexts', () {
    test('holds exactly the twelve callouts of the closed list', () {
      expect(
        Map.fromEntries(calloutTexts.entries).keys,
        containsAll(keys),
      );
      expect(calloutTexts.entries.length, 12);
    });

    // 02-art-direction/fx/callouts/callouts.md §1
    test("holds each callout's English text", () {
      final english = {
        for (final entry in calloutTexts.entries) entry.key: entry.value.english,
      };

      expect(english, {
        CalloutKeys.slash: 'SLASH!',
        CalloutKeys.thud: 'THUD!',
        CalloutKeys.chain: 'CHAIN!',
        CalloutKeys.clack: 'CLACK!',
        CalloutKeys.clang: 'CLANG!',
        CalloutKeys.crish: 'CRISH!',
        CalloutKeys.fwoom: 'FWOOM!',
        CalloutKeys.crack: 'CRACK!',
        CalloutKeys.burn: 'FWAAH!',
        CalloutKeys.frost: 'BRRR!',
        CalloutKeys.counter: 'COUNTER!',
        CalloutKeys.reflect: 'WHOOSH!',
      });
    });

    // 02-art-direction/fx/callouts/callouts.md §1
    test("holds each callout's Spanish text", () {
      final spanish = {
        for (final entry in calloutTexts.entries) entry.key: entry.value.spanish,
      };

      expect(spanish, {
        CalloutKeys.slash: '¡ZAS!',
        CalloutKeys.thud: '¡PUM!',
        CalloutKeys.chain: '¡CADENA!',
        CalloutKeys.clack: '¡CLAC!',
        CalloutKeys.clang: '¡CLANG!',
        CalloutKeys.crish: '¡CRIS!',
        CalloutKeys.fwoom: '¡FUUM!',
        CalloutKeys.crack: '¡CRAC!',
        CalloutKeys.burn: '¡FUAAH!',
        CalloutKeys.frost: '¡BRRR!',
        CalloutKeys.counter: '¡CONTRA!',
        CalloutKeys.reflect: '¡FIUU!',
      });
    });

    test('names each callout by the key of its constant', () {
      expect(CalloutKeys.slash.value, 'callout.slash');
      expect(CalloutKeys.thud.value, 'callout.thud');
      expect(CalloutKeys.chain.value, 'callout.chain');
      expect(CalloutKeys.clack.value, 'callout.clack');
      expect(CalloutKeys.clang.value, 'callout.clang');
      expect(CalloutKeys.crish.value, 'callout.crish');
      expect(CalloutKeys.fwoom.value, 'callout.fwoom');
      expect(CalloutKeys.crack.value, 'callout.crack');
      expect(CalloutKeys.burn.value, 'callout.burn');
      expect(CalloutKeys.frost.value, 'callout.frost');
      expect(CalloutKeys.counter.value, 'callout.counter');
      expect(CalloutKeys.reflect.value, 'callout.reflect');
    });
  });
}
