import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme.dart';

void main() {
  group('InkTheme', () {
    testWidgets("a widget under the theme reads the screen's scale", (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(2560, 1440);
      addTearDown(tester.view.reset);

      double? pixels;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InkTheme(
            child: Builder(
              builder: (context) {
                pixels = InkTheme.of(context).pixels(100);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      // 06-ui/ui.md §3: 100 hu at 1440 ÷ 1080.
      expect(pixels, closeTo(133.333333, 1e-6));
    });

    testWidgets(
      'a frame without a resize keeps the theme and rebuilds nothing',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(2560, 1440);
        addTearDown(tester.view.reset);

        var builds = 0;
        // The same reader instance both pumps: InheritedWidget propagation,
        // not widget-identity reuse, is what must keep it from rebuilding.
        final reader = Builder(
          builder: (context) {
            builds++;
            InkTheme.of(context);
            return const SizedBox.shrink();
          },
        );
        Widget treeOf(Widget child) =>
            Directionality(textDirection: TextDirection.ltr, child: child);

        // A fresh InkTheme wrapper forces _InkThemeState to rebuild even
        // without a resize, so this exercises InkThemeData's caching.
        await tester.pumpWidget(treeOf(InkTheme(child: reader)));
        final first = InkTheme.of(tester.element(find.byType(Builder)));

        await tester.pumpWidget(treeOf(InkTheme(child: reader)));
        final second = InkTheme.of(tester.element(find.byType(Builder)));

        expect(builds, 1);
        expect(second, same(first));
      },
    );

    testWidgets('a resize rebuilds what reads the theme', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(2560, 1440);
      addTearDown(tester.view.reset);

      var builds = 0;
      double? pixels;
      final tree = Directionality(
        textDirection: TextDirection.ltr,
        child: InkTheme(
          child: Builder(
            builder: (context) {
              builds++;
              pixels = InkTheme.of(context).pixels(100);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpWidget(tree);
      tester.view.physicalSize = const Size(1920, 1080);
      await tester.pumpWidget(tree);

      expect(builds, 2);
      expect(pixels, closeTo(100, 1e-9));
    });

    testWidgets('asking for the theme with none above fails', (
      tester,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              InkTheme.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(tester.takeException(), isA<StateError>());
    });
  });
}
