---
factory_version: 4.3.0
---

# The font is proven after integration

- **Date:** 2026-10-15
- **Outcome:** T041 names Lettering.family 'Patrick Hand' and asks pubspec.yaml for the font and for OFL.txt as an asset; T043 loads both through rootBundle.
- **Decisions:** verify-task runs before shared_file_notes are applied (replan-02's factory gap), so T041 cannot load the font; shipping OFL.txt with the font is the planner's call for the license. The callout outline stays combat's.
- **Deviations:** none
- **Evidence:** rejected: loading the font from disk at runtime; testing the bundle inside T041.
