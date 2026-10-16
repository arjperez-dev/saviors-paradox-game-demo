---
factory_version: 4.3.0
---

# Held input is released on a context switch

- **Date:** 2026-10-15
- **Outcome:** at the first drain after the active context changes, each key and button still held is released through the outgoing context; its later physical release reaches no context (T048).
- **Decisions:** opening the map while D is held publishes StopMoving, so Akeris stands when the map closes until D is pressed again; nothing is ever stuck (operator, 2026-10-15).
- **Deviations:** none
- **Evidence:** rejected: carry-over, where the release goes to the new context (StopPanning on the map) and Akeris keeps walking after it closes.
