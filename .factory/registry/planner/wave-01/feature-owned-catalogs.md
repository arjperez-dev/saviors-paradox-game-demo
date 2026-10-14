---
factory_version: 4.3.0
---

# Each feature brings its own catalog

- **Date:** 2026-10-14
- **Outcome:** `localization` holds the `Translator` and the callouts' texts; every other feature brings a `TextCatalog` copied from its reference's §6.
- **Decisions:** about 250 keys spread over twenty features; a central enum would put every text through a `localization` task (operator, 2026-10-14). The language is read from the `SettingsState` snapshot per lookup; a missing or repeated key is an `ArgumentError`. No `core/app` wiring until `settings` exists.
- **Deviations:** none
- **Evidence:** rejected: one central catalog with every key written in this wave.
