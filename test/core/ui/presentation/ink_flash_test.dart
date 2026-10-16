import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/flash_kind.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_flash.dart';

void main() {
  group('InkFlash', () {
    test('flashes are equal by kind and serial', () {
      const flash = InkFlash(FlashKind.denied, serial: 1);
      const same = InkFlash(FlashKind.denied, serial: 1);
      const otherSerial = InkFlash(FlashKind.denied, serial: 2);
      const otherKind = InkFlash(FlashKind.done, serial: 1);

      expect(flash, same);
      expect(flash.hashCode, same.hashCode);
      expect(flash, isNot(otherSerial));
      expect(flash, isNot(otherKind));
    });

    test('a negative serial is refused', () {
      expect(
        () => InkFlash(FlashKind.done, serial: -1),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
