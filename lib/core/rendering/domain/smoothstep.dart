/// The smooth ease the sandboxes use (`smooth`): 0 up to [u] = 0, 1 from
/// [u] = 1, and 3u² − 2u³ between.
double smoothstep(double u) {
  final t = u.clamp(0.0, 1.0);
  return t * t * (3 - 2 * t);
}
