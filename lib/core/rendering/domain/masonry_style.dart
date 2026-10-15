/// How a block of masonry is finished: which edges are outlined, and where
/// its darkness gathers (the sandbox's `masonry` options).
final class MasonryStyle {
  const MasonryStyle({
    this.isOneRow = false,
    this.hangs = false,
    this.hasTopEdge = true,
    this.hasBottomEdge = false,
    this.hasSideEdges = true,
  });

  /// A thin block laid as a single row of its full height.
  final bool isOneRow;

  /// A block hanging from the ceiling, darkened toward its top.
  final bool hangs;
  final bool hasTopEdge;
  final bool hasBottomEdge;
  final bool hasSideEdges;
}
