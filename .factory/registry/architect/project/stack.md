---
factory_version: 4.3.0
---

# Stack

- **Date:** 2026-10-14
- **Outcome:** Flutter 3.47.7 and Dart 3.13.5 on Windows, Flame 1.38.2, flutter_soloud 5.2.1, window_manager 0.5.2, path_provider 2.1.6; mocktail 1.0.5, flame_test 2.3.1, flutter_lints 6.0.0.
- **Decisions:** the client constraint (Flutter with Flame) kept; flutter_soloud for a native mixer with echo and reverb filters (`sfx.md` §3); localization, saves and the seed in-house; `contracts_root` `lib/core/contracts` per `architecture.md` §1 (operator, 2026-10-14).
- **Deviations:** `docs/CONTRACT_SPEC.md` §2 gives `lib/contracts/` as the Dart example; `architecture.md` §1 followed (operator).
- **Evidence:** checked 2026-10-14 — Flutter and Dart: storage.googleapis.com/flutter_infra_release/releases/releases_windows.json (stable 3.47.7, Dart 3.13.5, 2026-10-08); the rest: pub.dev/api/packages/<name> (flame 2026-08-27, flutter_soloud 2026-10-13, window_manager 2026-07-04, path_provider 2026-06-15, mocktail 2026-04-10, flame_test 2026-08-26, flutter_lints 2025-05-27). Rejected: flame_audio 2.12.2 / audioplayers 6.8.1 (one platform player per sound); very_good_analysis 11.0.0; gen-l10n/ARB (code generation, `BuildContext`-bound).
