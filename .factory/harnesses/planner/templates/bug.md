---
id: <B###>
type: bug
task_type: implementation
origin: <T###>
feature: <feature-slug>
module: <module>
status: pending
priority: high
wave: <n>
depends_on_contract: [<folder/Name>]
depends_on_task: []
files:
  - <path>
shared_file_notes: []
factory_version: <x.y.z>
created: <YYYY-MM-DD>
---

# <B###> — <title>

## Reproduction

1. <step, as the manual test that found it recorded it>

## Expected / Observed

- **Expected:** <what should have happened>
- **Observed:** <what did>

## Constraints

- <a boundary on the fix>

## Interfaces

| File | Symbol | Role | Building block | Signature |
|---|---|---|---|---|
| `<path>` | `<symbol>` | uses | — | `<signature>` |

## Implementation

```<language>
// <path> — edited
<code>
```

## Acceptance criteria

| Test file | Test name | Assertion |
|---|---|---|
| `<path>` | <test name, verbatim> | <what would have failed against the rejected code> |

## Manual check

<what a person must see to confirm the failure gone>
