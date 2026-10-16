---
factory_version: 4.3.0
---

# Input contexts hold no state

- **Date:** 2026-10-15
- **Outcome:** InputContext.translate(RawInput, InputReading, EventSink); PlayingContext and MenuContext are const (T045–T047).
- **Decisions:** InputReading carries what is held, the pointer, its aim through WorldCamera and its stillness, so A/D "latest wins" and W/S with a click need no fields; an unregistered HaltCause gets the menu context until map and narrative register theirs.
- **Deviations:** none
- **Evidence:** rejected: each context tracking its own held keys, mutable state outside an aggregate (coding-standards §5.1).
