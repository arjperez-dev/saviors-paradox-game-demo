import 'package:saviors_paradox/core/contracts/kernel/screen_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/ui_vec2.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/ui_scale.dart';

/// The UI frame at the screen's size: a point in hu scaled by screen height
/// ÷ 1080, with no offset; centring a sheet is layout (06-ui/ui.md §3).
final class ScreenUiScale implements UiScale {
  const ScreenUiScale({required this.screenHeight})
    : assert(screenHeight > 0, 'a screen has a height');

  /// The screen's height, in logical pixels.
  final double screenHeight;

  /// Logical pixels per hu.
  double get pixelsPerHu => screenHeight / UiVec2.referenceHeight;

  @override
  UiVec2 toUi(ScreenVec2 point) =>
      UiVec2(Vec2(point.x / pixelsPerHu, point.y / pixelsPerHu));

  @override
  ScreenVec2 toScreen(UiVec2 point) =>
      ScreenVec2(Vec2(point.x * pixelsPerHu, point.y * pixelsPerHu));

  @override
  bool operator ==(Object other) =>
      other is ScreenUiScale && other.screenHeight == screenHeight;

  @override
  int get hashCode => screenHeight.hashCode;
}
