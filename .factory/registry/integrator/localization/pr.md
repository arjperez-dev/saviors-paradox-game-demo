---
factory_version: 4.3.0
---

# PR — localization

- **Date:** 2026-10-14
- **Outcome:** `localization: Translate player-visible text by key into English or Spanish`
- **Decisions:** named the one risk this feature's history does not show for itself in
  Scrutinise — `CalloutKeys`/`calloutTexts` exist but nothing under `lib/features/combat/` names
  them yet, and `Translator` re-reads the settings snapshot on every call with no cache or change
  event.
- **Deviations:** none — every task merged with no `shared_file_notes`, no manifest change, and no
  replan.
- **Evidence:**

```text
localization: Translate player-visible text by key into English or Spanish

## Summary

This feature stands up the translation layer every player-visible string goes through:
`LocalizedText` pairs one piece of text in English and Spanish, `TextCatalog` holds a closed set of
them by `TextKey`, and `Translator` merges every catalog it is given and reads the active language
from the settings snapshot on each call, filling `{name}` placeholders as it goes. `calloutTexts` is
the first catalog built this way — the twelve combat callouts, by their `CalloutKeys` constant. It
deliberately wires no other feature's texts yet, and renders nothing: combat does not reference
`CalloutKeys` in this feature.

## Tasks

| id | title | type |
|---|---|---|
| T010 | Hold one text in each of the game's languages | feat |
| T011 | Gather one part of the game's texts by key | feat |
| T012 | Translate a key into the language of the settings | feat |
| T013 | List the callouts' texts by key | feat |
| T014 | Test the callouts in both languages through the translator | test |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- `flutter test`: All tests passed! (55 tests)
- Manual tests: none

## Scrutinise

- `calloutTexts`/`CalloutKeys` exist only in `lib/core/localization/` — nothing under
  `lib/features/combat/` names a `CalloutKeys` constant yet, so the callouts this feature lists are
  not wired into the game. Confirm that adoption is tracked as combat's own task rather than
  forgotten.
- `Translator` reads the settings snapshot fresh on every call rather than caching the language or
  reacting to a change event; worth checking that none of its callers sit in a per-frame hot path,
  where a repeated snapshot read and placeholder fill would allocate.
```
