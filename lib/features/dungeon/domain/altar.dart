part of 'zone.dart';

/// One altar of a zone: an entity of [Zone], reached only through it.
final class Altar {
  Altar._({required this._id, required this._room, required this._position});

  final EntityId _id;
  final EntityId _room;
  final Vec2 _position;
  AltarGift? _gift;

  AltarView _view() =>
      AltarView(altar: _id, room: _room, position: _position, gift: _gift);

  @override
  bool operator ==(Object other) => other is Altar && other._id == _id;

  @override
  int get hashCode => _id.hashCode;
}
