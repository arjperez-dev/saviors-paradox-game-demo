import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/flash_kind.dart';

void main() {
  group('FlashKind', () {
    test('a denied flash lasts 0.35 s and a done one 0.4 s', () {
      // 06-ui/pause-menu/pause-menu.md §7.
      expect(FlashKind.denied.duration, const Duration(milliseconds: 350));
      expect(FlashKind.done.duration, const Duration(milliseconds: 400));
    });
  });
}
