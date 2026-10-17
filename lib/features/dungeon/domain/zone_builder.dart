import 'dart:math';

import 'package:saviors_paradox/core/contracts/kernel/facing.dart';
import 'package:saviors_paradox/core/contracts/kernel/seed.dart';
import 'package:saviors_paradox/features/dungeon/domain/biome_kit.dart';
import 'package:saviors_paradox/features/dungeon/domain/dead_end_role.dart';
import 'package:saviors_paradox/features/dungeon/domain/passage.dart';
import 'package:saviors_paradox/features/dungeon/domain/placed_room.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_kind.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_link.dart';
import 'package:saviors_paradox/features/dungeon/domain/room_template.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_grid.dart';
import 'package:saviors_paradox/features/dungeon/domain/zone_layout.dart';

/// One attempt at laying a zone out on its kit's grid (layout.md §B.2
/// steps 1–3 and 5; the sandbox's `zoneTry`). Null when the main path
/// does not fit; whether the layout is playable is ZoneValidator's.
final class ZoneBuilder {
  const ZoneBuilder();

  /// The sandbox's `zoneTry`: at most 400 tries to grow a branch.
  static const int branchTries = 400;

  /// layout.md §B.2 step 3: a branch of up to 4 rooms before its end.
  static const int longestBranch = 4;

  ZoneLayout? build(BiomeKit kit, Seed seed) => _Attempt(kit, seed).run();
}

/// Whether a room attached to a doorway must still leave a passage onward.
enum _Onward { required, optional }

final class _Draft {
  _Draft({
    required this.index,
    required this.template,
    required this.column,
    required this.row,
    required this.depth,
    required this.from,
  });

  final int index;
  final RoomTemplate template;
  final int column;
  final int row;
  final int depth;
  final int? from;
  final List<Passage> linked = [];
  bool isOnMainPath = false;
  DeadEndRole? role;

  RoomKind get kind => template.kind;

  PlacedRoom toPlaced() => PlacedRoom(
    index: index,
    template: template,
    column: column,
    row: row,
    depth: depth,
    from: from,
    isOnMainPath: isOnMainPath,
    role: role,
    linked: linked,
  );
}

final class _Doorway {
  const _Doorway(this.room, this.passage);

  final _Draft room;
  final Passage passage;
}

final class _Option {
  const _Option(this.template, this.column, this.row, this.entry, this.rest);

  final RoomTemplate template;
  final int column;
  final int row;
  final Passage entry;
  final List<Passage> rest;
}

final class _Attached {
  const _Attached(this.room, this.entry, this.rest);

  final _Draft room;
  final Passage entry;
  final List<Passage> rest;
}

/// Where rooms stand on the grid: which cells are taken, and whether a
/// template fits the cells it would cover.
final class _Placement {
  _Placement(this.grid);

  final ZoneGrid grid;
  final Map<int, int> _occupied = {};
  final List<_Draft> rooms = [];

  _Draft place(
    RoomTemplate template, {
    required int column,
    required int row,
    required _Draft? from,
  }) {
    final room = _Draft(
      index: rooms.length,
      template: template,
      column: column,
      row: row,
      depth: from == null ? 0 : from.depth + 1,
      from: from?.index,
    );
    final cells = template.cellsWide * template.cellsHigh;
    for (var k = 0; k < cells; k++) {
      final cell = _cell(
        column + k % template.cellsWide,
        row + k ~/ template.cellsWide,
      );
      _occupied[cell] = room.index;
    }
    rooms.add(room);
    return room;
  }

  bool fits(RoomTemplate template, int column, int row) {
    final cells = template.cellsWide * template.cellsHigh;
    for (var k = 0; k < cells; k++) {
      final c = column + k % template.cellsWide;
      final r = row + k ~/ template.cellsWide;
      if (!_isFree(c, r)) {
        return false;
      }
    }
    return true;
  }

  bool _isFree(int column, int row) =>
      column >= 0 &&
      row >= 0 &&
      column < grid.columns &&
      row < grid.rows &&
      !_occupied.containsKey(_cell(column, row));

  int _cell(int column, int row) => column + row * grid.columns;
}

/// Attaches the next room to a free doorway: the templates of its kind,
/// tried plain or mirrored in a seeded order (layout.md §B.2 step 2).
final class _Attacher {
  _Attacher(this._kit, this._placement, this._random);

  final BiomeKit _kit;
  final _Placement _placement;
  final Random _random;
  final List<RoomLink> links = [];

  _Attached? attach(_Doorway door, RoomKind kind, _Onward onward) {
    final options = <_Option>[];
    for (final template in _shuffled(_kit.templatesOf(kind))) {
      for (final isMirrored in _shuffled(const [false, true])) {
        final placed = isMirrored
            ? template.mirrored(_placement.grid)
            : template;
        _addOptions(options, placed, door, onward);
      }
    }
    if (options.isEmpty) {
      return null;
    }
    return _join(door, _choose(options, kind, door.passage.side));
  }

  void _addOptions(
    List<_Option> options,
    RoomTemplate template,
    _Doorway door,
    _Onward onward,
  ) {
    final side = door.passage.side;
    final anchor = (
      side: side,
      gridRow: door.room.row + door.passage.row,
      column: side == Facing.right
          ? door.room.column + door.room.template.cellsWide
          : door.room.column - template.cellsWide,
    );
    for (final entry in template.passages) {
      final option = _optionFor(template, entry, anchor, onward);
      if (option != null) {
        options.add(option);
      }
    }
  }

  _Option? _optionFor(
    RoomTemplate template,
    Passage entry,
    ({Facing side, int gridRow, int column}) anchor,
    _Onward onward,
  ) {
    final row = anchor.gridRow - entry.row;
    if (entry.side != anchor.side.opposite ||
        !_placement.fits(template, anchor.column, row)) {
      return null;
    }
    final rest = [
      for (final passage in template.passages)
        if (passage != entry) passage,
    ];
    if (onward == _Onward.required &&
        !rest.any((passage) => passage.side == anchor.side)) {
      return null;
    }
    return _Option(template, anchor.column, row, entry, rest);
  }

  _Option _choose(List<_Option> options, RoomKind kind, Facing side) {
    if (kind != RoomKind.shaft) {
      return options.first;
    }
    for (final option in options) {
      final leavesByOtherRow = option.rest.any(
        (passage) => passage.side == side && passage.row != option.entry.row,
      );
      if (leavesByOtherRow) {
        return option;
      }
    }
    return options.first;
  }

  _Attached _join(_Doorway door, _Option option) {
    final room = _placement.place(
      option.template,
      column: option.column,
      row: option.row,
      from: door.room,
    );
    door.room.linked.add(door.passage);
    room.linked.add(option.entry);
    links.add(
      RoomLink(
        from: door.room.index,
        to: room.index,
        side: door.passage.side,
        row: door.room.row + door.passage.row,
      ),
    );
    return _Attached(room, option.entry, option.rest);
  }

  List<T> _shuffled<T>(List<T> items) {
    final list = List<T>.of(items);
    for (var i = list.length - 1; i > 0; i--) {
      final j = _random.nextInt(i + 1);
      final held = list[i];
      list[i] = list[j];
      list[j] = held;
    }
    return list;
  }
}

final class _Attempt {
  factory _Attempt(BiomeKit kit, Seed seed) {
    final random = Random(seed.value);
    final placement = _Placement(kit.grid);
    return _Attempt._(
      kit,
      random,
      placement,
      _Attacher(kit, placement, random),
    );
  }

  _Attempt._(this._kit, this._random, this._placement, this._attacher);

  final BiomeKit _kit;
  final Random _random;
  final _Placement _placement;
  final _Attacher _attacher;

  ZoneLayout? run() {
    if (!_layMainPath()) {
      return null;
    }
    _growBranches();
    _assignRoles();
    return ZoneLayout(
      grid: _placement.grid,
      rooms: [for (final room in _placement.rooms) room.toPlaced()],
      links: _attacher.links,
    );
  }

  // layout.md §B.2 step 2: from column 0, rows 2–5, always to the right.
  bool _layMainPath() {
    var door = _placeStart();
    for (final kind in _kit.mainPath) {
      final onward = kind == RoomKind.wayDown
          ? _Onward.optional
          : _Onward.required;
      final attached = _attacher.attach(door, kind, onward);
      if (attached == null) {
        return false;
      }
      attached.room.isOnMainPath = true;
      if (kind == RoomKind.wayDown) {
        return true;
      }
      door = _Doorway(attached.room, _onward(attached, kind));
    }
    return true;
  }

  _Doorway _placeStart() {
    final template = _kit.templatesOf(RoomKind.start).first;
    final start = _placement.place(
      template,
      column: 0,
      row: 2 + _random.nextInt(4),
      from: null,
    );
    start.isOnMainPath = true;
    return _Doorway(start, template.passages.first);
  }

  // A shaft leaves by its other row, so the path climbs or drops.
  Passage _onward(_Attached attached, RoomKind kind) {
    final forward = [
      for (final passage in attached.rest)
        if (passage.side == Facing.right) passage,
    ];
    if (kind != RoomKind.shaft) {
      return forward.first;
    }
    for (final passage in forward) {
      if (passage.row != attached.entry.row) {
        return passage;
      }
    }
    return forward.first;
  }

  // layout.md §B.2 step 3: branches from free passages, ending in dead ends.
  void _growBranches() {
    final target =
        _kit.fewestRooms +
        _random.nextInt(_kit.mostRooms - _kit.fewestRooms + 1);
    for (
      var tries = 0;
      tries < ZoneBuilder.branchTries && _placement.rooms.length < target;
      tries++
    ) {
      final free = _freeDoorways();
      if (free.isEmpty) {
        return;
      }
      _growBranch(free[_random.nextInt(free.length)], target);
    }
  }

  List<_Doorway> _freeDoorways() => [
    for (final room in _placement.rooms)
      if (_canBranchFrom(room.kind))
        for (final passage in room.template.passages)
          if (!room.linked.contains(passage)) _Doorway(room, passage),
  ];

  static bool _canBranchFrom(RoomKind kind) => switch (kind) {
    RoomKind.corridor || RoomKind.combat || RoomKind.shaft => true,
    RoomKind.start ||
    RoomKind.deadEnd ||
    RoomKind.antechamber ||
    RoomKind.boss ||
    RoomKind.wayDown => false,
  };

  void _growBranch(_Doorway first, int target) {
    final length = 1 + _random.nextInt(ZoneBuilder.longestBranch);
    var door = first;
    for (var k = 0; k <= length && _placement.rooms.length < target; k++) {
      final isLast = k == length || _placement.rooms.length >= target - 1;
      final onward = isLast ? _Onward.optional : _Onward.required;
      final attached =
          _attacher.attach(door, _branchKind(onward), onward) ??
          _attacher.attach(door, RoomKind.deadEnd, _Onward.optional);
      if (attached == null || attached.room.kind == RoomKind.deadEnd) {
        return;
      }
      final next = _onwardFree(attached, door.passage.side);
      if (next == null) {
        return;
      }
      door = next;
    }
  }

  RoomKind _branchKind(_Onward onward) => onward == _Onward.optional
      ? RoomKind.deadEnd
      : _kit.branchKinds[_random.nextInt(_kit.branchKinds.length)];

  _Doorway? _onwardFree(_Attached attached, Facing side) {
    final forward = [
      for (final passage in attached.rest)
        if (passage.side == side && !attached.room.linked.contains(passage))
          passage,
    ];
    return forward.isEmpty
        ? null
        : _Doorway(attached.room, forward[_random.nextInt(forward.length)]);
  }

  // layout.md §B.2 step 5: the deepest dead end holds the lore spirit, the
  // next ones the altars, the rest are lookouts.
  void _assignRoles() {
    final ends = [
      for (final room in _placement.rooms)
        if (room.kind == RoomKind.deadEnd) room,
    ]..sort(_deepestFirst);
    for (var n = 0; n < ends.length; n++) {
      ends[n].role = n == 0
          ? DeadEndRole.lore
          : (n <= _kit.altarCount ? DeadEndRole.altar : DeadEndRole.lookout);
    }
  }

  static int _deepestFirst(_Draft a, _Draft b) {
    final byDepth = b.depth.compareTo(a.depth);
    return byDepth != 0 ? byDepth : a.index.compareTo(b.index);
  }
}
