---
factory_version: 4.3.0
---

# Contract ports/event_source

- **Date:** 2026-10-16
- **Outcome:** `subscribe` returns an `EventSubscription`, the handle that releases the handler.
- **Decisions:** A screen must release its handlers on dispose (coding-standards §11.5, checklist F5); a handle matches by identity, so inline lambdas and duplicate subscriptions stay distinct; one allocation per subscribe, at wiring, never per frame.
- **Deviations:** none
- **Evidence:** rejected: a paired `unsubscribe<E>(handler)` — the caller must keep the exact closure, an inline lambda cannot be released, a duplicate is ambiguous and `E` must be repeated.
