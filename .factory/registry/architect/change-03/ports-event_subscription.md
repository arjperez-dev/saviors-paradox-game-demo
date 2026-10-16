---
factory_version: 4.3.0
---

# Contract ports/event_subscription

- **Date:** 2026-10-16
- **Outcome:** `EventSubscription` (`cancel`), implemented by loop in `event_queue.dart`'s `_Subscription`, which so far only returns itself; `cancel` releases nothing yet.
- **Decisions:** Note for the planner's wave-04, one loop task: `subscribe` returns the subscription; `cancel` is idempotent; a cancel during `deliver` skips no other handler and stops the cancelled one; no allocation in `deliver`; a test for each. `translate_input.dart` and `game_loop.dart:36-38` keep their subscriptions for the app's lifetime and need no change.
- **Deviations:** The architect revised `event_queue.dart` to a stub-level `cancel` so `main` compiles (operator's choice (a)).
- **Evidence:** rejected: changing only the contract and leaving `main` failing analysis until the task lands.
