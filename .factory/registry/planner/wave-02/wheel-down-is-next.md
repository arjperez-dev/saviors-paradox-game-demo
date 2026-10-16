---
factory_version: 4.3.0
---

# The wheel down is the next weapon

- **Date:** 2026-10-15
- **Outcome:** InputListener sends one Scrolled step per wheel event by the sign of dy, down positive; the playing context passes it to CycleWeapon(steps) (T046, T049).
- **Decisions:** the controls say the wheel cycles the slots, not which way; down = +1 is the planner's. The map's zoom direction (G21) is map's context.
- **Deviations:** none
- **Evidence:** rejected: steps from the size of dy, which varies by device.
