/// The health an exchange takes from a body; what the body absorbs is its
/// own loadout's (design-patterns.md §1).
final class Damage {
  const Damage(this.amount) : assert(amount >= 0, 'damage is never negative');

  static const Damage none = Damage(0);

  final double amount;

  bool get isNone => amount == 0;

  @override
  bool operator ==(Object other) => other is Damage && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;
}
