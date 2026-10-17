import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/seconds.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';
import 'package:saviors_paradox/features/combat/domain/block_judge.dart';
import 'package:saviors_paradox/features/combat/domain/block_verdict.dart';
import 'package:saviors_paradox/features/combat/domain/guard.dart';

void main() {
  group('BlockJudge', () {
    const judge = BlockJudge();

    test('no shield leaves the defender unguarded', () {
      final verdict = judge.judge(
        element: Element.plain,
        isBlockable: true,
        guard: null,
      );

      expect(verdict, BlockVerdict.unguarded);
    });

    test('an unblockable attack passes the shield', () {
      final guard = Guard(
        shield: ShieldId.sacred,
        raisedFor: const Seconds(0.1),
      );

      final verdict = judge.judge(
        element: Element.plain,
        isBlockable: false,
        guard: guard,
      );

      expect(verdict, BlockVerdict.unguarded);
    });

    test('a shield that does not stop the element passes it', () {
      final guard = Guard(shield: ShieldId.sacred, raisedFor: const Seconds(1));

      final verdict = judge.judge(
        element: Element.fire,
        isBlockable: true,
        guard: guard,
      );

      expect(verdict, BlockVerdict.unguarded);
    });

    test('the matching special shield stops its own element', () {
      final fireGuard = Guard(
        shield: ShieldId.fire,
        raisedFor: const Seconds(1),
      );
      final iceGuard = Guard(shield: ShieldId.ice, raisedFor: const Seconds(1));

      final fireVerdict = judge.judge(
        element: Element.fire,
        isBlockable: true,
        guard: fireGuard,
      );
      final iceVerdict = judge.judge(
        element: Element.ice,
        isBlockable: true,
        guard: iceGuard,
      );

      expect(fireVerdict, BlockVerdict.blocked);
      expect(iceVerdict, BlockVerdict.blocked);
    });

    test('a shield raised within the window blocks perfectly', () {
      final atZero = Guard(shield: ShieldId.sacred, raisedFor: Seconds.zero);
      final atWindow = Guard(
        shield: ShieldId.sacred,
        raisedFor: const Seconds(0.2),
      );

      final verdictAtZero = judge.judge(
        element: Element.plain,
        isBlockable: true,
        guard: atZero,
      );
      final verdictAtWindow = judge.judge(
        element: Element.plain,
        isBlockable: true,
        guard: atWindow,
      );

      expect(verdictAtZero, BlockVerdict.perfect);
      expect(verdictAtWindow, BlockVerdict.perfect);
    });

    test('a shield raised longer only blocks', () {
      final guard = Guard(
        shield: ShieldId.sacred,
        raisedFor: const Seconds(0.21),
      );

      final verdict = judge.judge(
        element: Element.plain,
        isBlockable: true,
        guard: guard,
      );

      expect(verdict, BlockVerdict.blocked);
    });

    test('the perfect window is a fifth of a second', () {
      // operator, 2026-10-16
      expect(BlockJudge.perfectWindow, const Seconds(0.2));
    });
  });
}
