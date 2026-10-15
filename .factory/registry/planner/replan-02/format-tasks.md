---
factory_version: 4.3.0
---

# One formatting task per module

- **Date:** 2026-10-15
- **Outcome:** T038 (localization) and T039 (rendering), `scaffolding`, run `dart format` on the three test files that fail it.
- **Decisions:** the architect's change-02 found `callout_texts_test.dart`, `ink_puff_test.dart` and `stroke_paths_test.dart` breaking checklist C10; the operator asked for one task per module, touching only those files. The formatter decides every line; no behaviour changes (rule 38).
- **Deviations:** `dart format --set-exit-if-changed lib test` on `main` lists exactly those three.
- **Evidence:** rejected: one task across both modules (§3.1, one module's roots per task).
