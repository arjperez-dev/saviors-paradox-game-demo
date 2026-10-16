import 'package:saviors_paradox/core/ui/presentation/flash_kind.dart';

/// One flash of a box's frame: a new [serial] flashes it again, so a screen
/// asks for a flash by giving the next one.
final class InkFlash {
  const InkFlash(this.kind, {required this.serial})
    : assert(serial >= 0, 'a serial counts flashes');

  final FlashKind kind;
  final int serial;

  @override
  bool operator ==(Object other) =>
      other is InkFlash && other.kind == kind && other.serial == serial;

  @override
  int get hashCode => Object.hash(kind, serial);
}
