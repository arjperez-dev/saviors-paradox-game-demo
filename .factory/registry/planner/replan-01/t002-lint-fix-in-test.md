---
factory_version: 4.3.0
---

# T002 fixes the kernel test the lints reject

- **Date:** 2026-10-14
- **Outcome:** T002 rewritten in place and returned to `pending`; it now owns `result_test.dart`.
- **Decisions:** the plan was wrong: `flutter_lints` brings `unrelated_type_equality_checks` through
  `package:lints/core.yaml`, which flags T001's `Success<int, int>(1) == Failure<int, int>(1)` under
  `--fatal-infos`. The two locals are typed `Result<int, int>`, so the test still asserts `==` and
  the lint stays on for game code. T002 may list T001's file: `tooling` has no roots (§3.3) and T001
  is integrated, so no live task shares it (§6.5).
- **Deviations:** T002 touches two test files of T001; no task dropped.
- **Evidence:** rejected: turning the rule off (weakens every feature), `isNot(equals(...))` (stops
  asserting the operator), a bug task (§8.2 is for a manual `FAIL`). `task/T002` is discarded: it
  holds no commit, only the verbatim `analysis_options.yaml`; the operator removes `../wt-T002` and
  `task/T002`.
