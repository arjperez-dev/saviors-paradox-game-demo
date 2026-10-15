---
factory_version: 4.3.0
---

# T002 formats Dart only, T001's seconds test included

- **Date:** 2026-10-14
- **Outcome:** the format criterion is `dart format --output=none --set-exit-if-changed
  test/core/contracts`; T002 owns `seconds_test.dart`.
- **Decisions:** `dart format` given `analysis_options.yaml` parses it as Dart and fails; and
  `seconds_test.dart` holds four `expect` lines over 80 columns, which T001 never checked. T002 runs
  `dart format` on that file, which wraps only those four calls.
- **Deviations:** none beyond the extra file.
- **Evidence:** probed in the scratchpad on a `subst` drive: with both fixes, `Formatted 11 files
  (0 changed)`. Rejected: formatting `lib/` too — five architect files are not format-clean
  (`wave-01/environment-findings`).
