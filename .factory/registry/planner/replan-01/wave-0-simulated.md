---
factory_version: 4.3.0
---

# T003 and T004 stand as written

- **Date:** 2026-10-14
- **Outcome:** T003 and T004 kept unchanged after simulating all of wave 0; T001 integrated, untouched.
- **Decisions:** on a copy of `feat/tooling` with the rewritten T002, T003 verbatim gives analyze and
  format clean; T004 verbatim generates exactly its 18 `files`, both "before" strings match the
  template, and with the repository's `.gitattributes` a fresh clone runs `pub get
  --enforce-lockfile`, analyze, 35 tests and `build windows --release` green, `git status` clean.
- **Deviations:** none.
- **Evidence:** the built exe opened a window titled `Savior's Paradox`; ProductName and
  FileDescription the same. The native build fails only on long paths (MAX_PATH), as
  `wave-01/environment-findings` says.
