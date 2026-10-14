# chain

## What it is

The chain blades: the `ChainResolver` of actions, throw, bite, pull, overhead arc, area spin, hook, climb, swing and anchor.

## Contracts

| Contract | Role | Stub |
|---|---|---|
| `events/chain_thrown` | emits | `lib/features/chain/application/step_chain_pair.dart` |
| `events/chain_hooked` | emits | `lib/features/chain/application/step_chain_pair.dart` |
| `events/chain_anchored` | emits | `lib/features/chain/application/step_chain_pair.dart` |
| `events/sound_effect_cued` | emits | `lib/features/chain/application/step_chain_pair.dart` |
| `ports/chain_blades` | implements | `lib/features/chain/application/chain_pair_blades.dart` |
| `ports/collision_world` | consumes | — |
| `ports/attack_resolver` | consumes | — |
| `ports/combatant_registry` | consumes | — |
| `events/hit_landed` | consumes | — |
| `ports/event_sink` | consumes | — |

## Roots

`lib/features/chain/`, `test/features/chain/`

## References

- `.factory/project/reference/03-characters/akeris/weapons/hook-blades.md`
- `.factory/project/reference/03-characters/akeris/weapons/hook-blade.png`
- `.factory/project/reference/03-characters/akeris/weapons/hook-blades-sheet.png`
- `.factory/project/reference/03-characters/akeris/weapons/hook-blades-balance.md`
- `.factory/project/reference/05-items/weapons/chain-blades/`
- `.factory/project/reference/03-characters/akeris/sandbox/sandbox.html`

## Not here

- Akeris's hanging and climbing postures: `akeris`, which reads `ChainPull`.
- What an enemy does when the chain hits it: `enemies` and `bosses`.
