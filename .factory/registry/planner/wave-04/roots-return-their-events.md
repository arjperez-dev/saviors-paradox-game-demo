---
factory_version: 4.3.0
---

# A root's method returns the event of its call

- **Date:** 2026-10-16
- **Outcome:** every root method returns its domain event, or null when it refused; `StatusEffects.advance` adds its expiries to a list the caller owns; `ReportExchange` alone turns combat's domain events into integration events.
- **Decisions:** architecture §4's own `DrinkPotion` example has the root return its event; the domain never publishes, and the per-frame path allocates only on an event.
- **Deviations:** none
- **Evidence:** rejected: a pending-events list inside each root, drained by `pullEvents()`, which allocates on every drain and repeats the same code in four roots.
