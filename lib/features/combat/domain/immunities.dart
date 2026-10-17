import 'package:saviors_paradox/core/contracts/kernel/element.dart';

/// The elements a body is immune to (VISION.md §Mechanics; operator,
/// 2026-10-16: they change only what a shield inflicts).
final class Immunities {
  const Immunities({this.toFire = false, this.toIce = false});

  static const Immunities none = Immunities();

  final bool toFire;
  final bool toIce;

  bool covers(Element element) => switch (element) {
    Element.plain => false,
    Element.fire => toFire,
    Element.ice => toIce,
  };

  @override
  bool operator ==(Object other) =>
      other is Immunities && other.toFire == toFire && other.toIce == toIce;

  @override
  int get hashCode => Object.hash(toFire, toIce);
}
