---
factory_version: 4.3.0
---

# Contract kernel/element

- **Date:** 2026-10-14
- **Outcome:** `Element` keeps its name and file.
- **Decisions:** `architecture.md` §2.4 and `VISION.md` name it `Element`; the clash with Flutter's `Element` is resolved per file with `hide Element` on the widgets import (operator, 2026-10-14).
- **Deviations:** none
- **Evidence:** rejected: renaming to `ElementKind`, which needs `architecture.md` §2.4 revised first.
