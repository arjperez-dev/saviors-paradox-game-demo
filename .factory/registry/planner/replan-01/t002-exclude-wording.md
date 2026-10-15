---
factory_version: 4.3.0
---

# T002's exclude constraint names its folders

- **Date:** 2026-10-14
- **Outcome:** the constraint reads: `exclude` holds `build/**` and `windows/**`, and nothing else.
- **Decisions:** "what `flutter pub get` writes there on its own" was not checkable — `pub get` never
  writes `analysis_options.yaml`. The two folders are the ones the Flutter tools generate: the build
  output and T004's runner.
- **Deviations:** none; the YAML itself is unchanged.
- **Evidence:** rejected: dropping the constraint, which leaves an implementer free to add excludes.
