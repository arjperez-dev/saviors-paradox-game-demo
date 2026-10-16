---
factory_version: 4.3.0
---

# The kit takes already-translated text

- **Date:** 2026-10-16
- **Outcome:** screens translate by key and pass Strings; core/ui imports no core/localization.
- **Decisions:** operator, 2026-10-16. For the architect's next change-NN: lib/core/ui/CLAUDE.md says the kit is "lettered through core/localization"; it should say the kit takes already-translated text.
- **Deviations:** none
- **Evidence:** rejected: widgets taking a TextKey and a Translator from a scope.
