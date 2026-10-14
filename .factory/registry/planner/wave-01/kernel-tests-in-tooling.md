---
factory_version: 4.3.0
---

# Kernel tests ship with the manifest

- **Date:** 2026-10-14
- **Outcome:** T001 declares the stack and brings the tests of the kernel's behaviour-bearing types.
- **Decisions:** `flutter test` exits 1 on a tree with no test file, and `verify-task` runs it on every task, scaffolding included; the test names sit in the `Assertion` column, as scaffolding allows no `Test file` (operator, 2026-10-14). Harness gap worth a factory change.
- **Deviations:** none
- **Evidence:** rejected: a separate kernel-tests task, which leaves T001 failing check 1. Probed: `flutter test` with no tests exits 1.
