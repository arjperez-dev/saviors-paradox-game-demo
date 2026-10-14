enum Facing {
  left,
  right;

  int get sign => switch (this) {
    Facing.left => -1,
    Facing.right => 1,
  };

  Facing get opposite => switch (this) {
    Facing.left => Facing.right,
    Facing.right => Facing.left,
  };
}
