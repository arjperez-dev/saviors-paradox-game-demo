import 'package:saviors_paradox/core/ui/presentation/label_placement.dart';

/// A button's size in hu and where its label sits; with no [width] the
/// button is as wide as its label and key cap need.
final class ButtonShape {
  const ButtonShape({
    required this.height,
    this.width,
    this.placement = LabelPlacement.start,
  }) : assert(height > 0, 'a button has a height'),
       assert(width == null || width > 0, 'a button has a width');

  final double height;
  final double? width;
  final LabelPlacement placement;

  @override
  bool operator ==(Object other) =>
      other is ButtonShape &&
      other.height == height &&
      other.width == width &&
      other.placement == placement;

  @override
  int get hashCode => Object.hash(height, width, placement);
}
