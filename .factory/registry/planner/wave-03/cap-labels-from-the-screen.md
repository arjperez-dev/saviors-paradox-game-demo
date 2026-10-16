---
factory_version: 4.3.0
---

# A key cap's name comes from the screen

- **Date:** 2026-10-16
- **Outcome:** CapKey(InputKey, label:) carries the printed name; KeyCap takes a String; KeyCapButton is always 56 tall (T059, T062).
- **Decisions:** key names are keys, not texts (dialogue.md §6), and no reference names most keys (Space, Shift, Ctrl, nor their Spanish caps), so the screen passes the name its reference draws. Every reference's key-cap button is 56 tall (pmFooter, ttSlots, ttSettings, map.md §3).
- **Deviations:** none
- **Evidence:** rejected: an exhaustive InputKey → name table in core/ui, which would invent names for keys no reference draws.
