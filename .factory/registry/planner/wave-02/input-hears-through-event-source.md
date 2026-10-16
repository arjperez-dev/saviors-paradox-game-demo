---
factory_version: 4.3.0
---

# Input subscribes through EventSource

- **Date:** 2026-10-15
- **Outcome:** TranslateInput takes the contract EventSource and subscribes to RunStarted, RunEnded, QuitToTitleRequested, WorldHalted and WorldResumed, as GameLoop does (T048).
- **Decisions:** for the architect's next change-NN: lib/core/input/CLAUDE.md lacks the row `ports/event_source | consumes | —`. No contract changes now (operator, 2026-10-15).
- **Deviations:** none
- **Evidence:** rejected: core/app forwarding each event to plain methods, which moves the stack's rules into an untested shared file; blocking input for the architect.
