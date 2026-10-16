import 'package:flutter_test/flutter_test.dart';
import 'package:saviors_paradox/core/ui/presentation/button_shape.dart';
import 'package:saviors_paradox/core/ui/presentation/label_placement.dart';

void main() {
  group('ButtonShape', () {
    test('shapes are equal by value', () {
      const shape = ButtonShape(
        height: 64,
        width: 300,
        placement: LabelPlacement.centre,
      );
      const same = ButtonShape(
        height: 64,
        width: 300,
        placement: LabelPlacement.centre,
      );
      const otherHeight = ButtonShape(
        height: 56,
        width: 300,
        placement: LabelPlacement.centre,
      );
      const otherWidth = ButtonShape(
        height: 64,
        width: 470,
        placement: LabelPlacement.centre,
      );
      const otherPlacement = ButtonShape(
        height: 64,
        width: 300,
        placement: LabelPlacement.start,
      );

      expect(shape, same);
      expect(shape.hashCode, same.hashCode);
      expect(shape, isNot(otherHeight));
      expect(shape, isNot(otherWidth));
      expect(shape, isNot(otherPlacement));
    });

    test('a shape with no height or width is refused', () {
      expect(
        () => ButtonShape(height: 0),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => ButtonShape(height: 56, width: 0),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
