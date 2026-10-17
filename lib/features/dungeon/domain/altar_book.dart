part of 'zone.dart';

// What every altar of a zone holds, and the view of it the root shows
// (checklist C4: keeps Zone's own body under its line limit).
final class _AltarBook {
  _AltarBook(this._altars) : views = _viewsOf(_altars);

  final List<Altar> _altars;
  List<AltarView> views;

  AltarGift? giftOn(EntityId altar) => _find(altar)?._gift;

  EntityId? nearestWithin(Vec2 point, double reach) {
    Altar? nearest;
    var best = double.infinity;
    for (var i = 0; i < _altars.length; i++) {
      final distance = _altars[i]._position.distanceTo(point);
      if (distance <= reach && distance < best) {
        nearest = _altars[i];
        best = distance;
      }
    }
    return nearest?._id;
  }

  /// Takes the gift on [altar]; null when the altar is empty or unknown.
  ItemTakenFromAltar? take(EntityId altar) {
    final found = _find(altar);
    final gift = found?._gift;
    if (found == null || gift == null) {
      return null;
    }
    found._gift = null;
    views = _viewsOf(_altars);
    return ItemTakenFromAltar(altar: altar, gift: gift, at: found._position);
  }

  /// Lays [gift] on [altar]; null when the altar holds a gift or is
  /// unknown.
  ItemReturnedToAltar? give(EntityId altar, AltarGift gift) {
    final found = _find(altar);
    if (found == null || found._gift != null) {
      return null;
    }
    found._gift = gift;
    views = _viewsOf(_altars);
    return ItemReturnedToAltar(altar: altar, gift: gift);
  }

  Altar? _find(EntityId id) {
    for (var i = 0; i < _altars.length; i++) {
      if (_altars[i]._id == id) {
        return _altars[i];
      }
    }
    return null;
  }

  static List<AltarView> _viewsOf(List<Altar> altars) =>
      List.unmodifiable([for (final altar in altars) altar._view()]);
}
