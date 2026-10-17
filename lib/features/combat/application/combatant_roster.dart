import 'dart:collection';

import 'package:saviors_paradox/core/contracts/kernel/entity_id.dart';
import 'package:saviors_paradox/core/contracts/kernel/vec2.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant.dart';
import 'package:saviors_paradox/core/contracts/ports/combatant_registry.dart';
import 'package:saviors_paradox/features/combat/domain/reach.dart';

/// Every body an attack can reach, as its own feature registered it.
final class CombatantRoster implements CombatantRegistry {
  CombatantRoster() : this._(<Combatant>[]);

  CombatantRoster._(List<Combatant> near)
    : _near = near,
      _nearView = UnmodifiableListView(near);

  final List<Combatant> _combatants = [];
  final List<Combatant> _near;
  final UnmodifiableListView<Combatant> _nearView;

  @override
  void register(Combatant combatant) {
    if (_indexOf(combatant.id) >= 0) {
      throw StateError('combatant ${combatant.id} is registered already');
    }
    _combatants.add(combatant);
  }

  @override
  void unregister(EntityId combatant) {
    final index = _indexOf(combatant);
    if (index >= 0) {
      _combatants.removeAt(index);
    }
  }

  /// The bodies whose hurtbox [radius] reaches from [point], in the order
  /// they registered. The same view is refilled by the next call.
  @override
  Iterable<Combatant> near(Vec2 point, double radius) {
    _near.clear();
    for (var i = 0; i < _combatants.length; i++) {
      final combatant = _combatants[i];
      if (const Reach().reaches(combatant.hurtbox, point, radius)) {
        _near.add(combatant);
      }
    }
    return _nearView;
  }

  @override
  Vec2? positionOf(EntityId combatant) => byId(combatant)?.hurtbox.centre;

  Combatant? byId(EntityId combatant) {
    final index = _indexOf(combatant);
    return index < 0 ? null : _combatants[index];
  }

  int _indexOf(EntityId combatant) {
    for (var i = 0; i < _combatants.length; i++) {
      if (_combatants[i].id == combatant) {
        return i;
      }
    }
    return -1;
  }
}
