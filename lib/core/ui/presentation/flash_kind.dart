/// Why a box's frame flashes, and for how long (06-ui/pause-menu/
/// pause-menu.md §7, 06-ui/title/title.md §7).
enum FlashKind {
  // pause-menu.md §7: denied, 0.35 s.
  denied(Duration(milliseconds: 350)),
  // pause-menu.md §7: action done, 0.4 s.
  done(Duration(milliseconds: 400));

  const FlashKind(this.duration);

  final Duration duration;
}
