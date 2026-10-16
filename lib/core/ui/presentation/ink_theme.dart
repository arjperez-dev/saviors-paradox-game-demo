import 'package:flutter/widgets.dart';
import 'package:saviors_paradox/core/ui/presentation/ink_theme_data.dart';
import 'package:saviors_paradox/core/ui/presentation/screen_ui_scale.dart';

/// Gives every widget under it the look of the screens at the screen's
/// size: the one place the kit reads the screen's height
/// (06-ui/ui.md §3; coding-standards.md §11.6, §11.7).
final class InkTheme extends StatefulWidget {
  const InkTheme({required this.child, super.key});

  final Widget child;

  /// The look of the nearest [InkTheme] above [context].
  static InkThemeData of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_InkThemeScope>();
    if (scope == null) {
      throw StateError('No InkTheme above this widget.');
    }
    return scope.data;
  }

  @override
  State<InkTheme> createState() => _InkThemeState();
}

final class _InkThemeState extends State<InkTheme> {
  InkThemeData? _data;
  double? _screenHeight;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => _InkThemeScope(
      data: _dataFor(constraints.maxHeight),
      child: widget.child,
    ),
  );

  // A frame without a resize keeps the same data, so nothing allocates.
  InkThemeData _dataFor(double screenHeight) {
    final current = _data;
    if (current != null && _screenHeight == screenHeight) {
      return current;
    }
    _screenHeight = screenHeight;
    return _data = InkThemeData(ScreenUiScale(screenHeight: screenHeight));
  }
}

final class _InkThemeScope extends InheritedWidget {
  const _InkThemeScope({required this.data, required super.child});

  final InkThemeData data;

  @override
  bool updateShouldNotify(_InkThemeScope oldWidget) =>
      oldWidget.data.scale != data.scale;
}
