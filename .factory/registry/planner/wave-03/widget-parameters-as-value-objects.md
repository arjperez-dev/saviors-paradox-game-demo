---
factory_version: 4.3.0
---

# Widget parameters grouped into value objects

- **Date:** 2026-10-16
- **Outcome:** every kit constructor takes at most 4 parameters besides key, through ButtonContent, ButtonShape, ButtonState, FrameStyle, KeyCapSize, InkFlash, CapKey, ConfirmTexts.
- **Decisions:** coding-standards §3 / C4 held literally; each is a DDD value object (architecture §4): immutable, equal by value, validating itself, const (operator, 2026-10-16). For the next waves: from wave 4 each feature's domain/ uses the tactical patterns explicitly — aggregates with one root, entities equal by EntityId, value objects, domain events recorded by aggregates and published only by application/, factories from a Seed, repositories as ports — and each task names the pattern of each type.
- **Deviations:** none
- **Evidence:** rejected: exempting widget constructors' named fields from C4.
