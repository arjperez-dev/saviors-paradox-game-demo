---
factory_version: 4.3.0
---

# Type-only files get no test file of their own

- **Date:** 2026-10-16
- **Outcome:** pure interfaces, plain enums, event families and `part` files have no test file; their behaviour is tested through the type that uses them. Value objects keep `==` written in the `Implementation`, as wave-03's testers asked.
- **Decisions:** input's precedent (`input_context.dart`, `input_reading.dart` have none); a test of an interface or an enum asserts nothing. Every test asserting a reference's value names it in a comment (`Constraints`), the testers' repeated wave-03 finding.
- **Deviations:** testing.md §2's "one test file per production file" is read as "per file with behaviour".
- **Evidence:** rejected: empty test files to satisfy the count.
