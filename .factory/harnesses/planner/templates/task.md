---
id: <T###>
type: task
task_type: <implementation | scaffolding>
feature: <feature-slug>
module: <module | tooling>
status: pending
priority: normal
wave: <n>
depends_on_contract: [<folder/Name>]
depends_on_task: [<T###>]
files:
  - <path>
  - <path>
shared_file_notes:
  - file: <shared file>
    instruction: <one change, stated so that applying it decides nothing>
references:
  - .factory/project/reference/<exact path of an approved piece>
factory_version: <x.y.z>
created: <YYYY-MM-DD>
---

# <T###> — <title>

## Description

<what is built and why, in one paragraph>

## Preconditions

- <what an earlier task produced that this one builds on>

## Constraints

- <a boundary on the solution>

## Interfaces

| File | Symbol | Role | Building block | Signature |
|---|---|---|---|---|
| `<path>` | `<symbol>` | <exports \| uses> | <the building block the engineering references name \| —> | `<signature>` |

## Implementation

```<language>
// <path> — <new | replaced whole | edited>
<code>
```

## Acceptance criteria

| Test file | Test name | Assertion |
|---|---|---|
| `<path>` | <test name, verbatim> | <what must be true> (`<reference path>` §<section>, when a reference fixes it) |

## Manual check

<what only a person can judge, in one line>
