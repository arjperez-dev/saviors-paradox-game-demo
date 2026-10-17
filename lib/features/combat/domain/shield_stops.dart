import 'package:saviors_paradox/core/contracts/kernel/element.dart';
import 'package:saviors_paradox/core/contracts/kernel/shield_id.dart';

/// Whether a shield stops an attack of [element] (elements.md §1): any
/// shield stops a plain one, only the fire shield fire, only the ice
/// shield ice.
final class ShieldStops {
  const ShieldStops(this.element);

  final Element element;

  bool isSatisfiedBy(ShieldId shield) => switch (element) {
    Element.plain => true,
    Element.fire => shield == ShieldId.fire,
    Element.ice => shield == ShieldId.ice,
  };
}
