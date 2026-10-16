# Registry Specification

> A [task file](GLOSSARY.md#task-file) says what to build. A [registry](GLOSSARY.md#registry) entry
> records why an [agent](GLOSSARY.md#agent) did what it did.

Several [artefacts](GLOSSARY.md#artefact) already record most of what happens in the factory. The
task files record what to do and each task's [status](GLOSSARY.md#status); the
[contracts](GLOSSARY.md#contract) record what the modules agree on; git records what changed; the
code records how it ended up. What none of them records is **why** — the decisions taken, the
deviations from the task file, and the evidence behind them.

That is the registry's job, and its only job. **A registry that grows into a second, worse task file
is a failure of this specification**, so almost everything below is a limit: what an entry may
contain, how long it may be, who reads it, and what it must never say.

Vocabulary is fixed by [`GLOSSARY.md`](GLOSSARY.md); paths by
[`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md); the task file this document draws its boundary
against by [`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md); the architect's other output by
[`CONTRACT_SPEC.md`](CONTRACT_SPEC.md); the gates by [`APPROVAL_PROTOCOL.md`](APPROVAL_PROTOCOL.md).

---

## 1. What each agent records

| Agent | Records |
|---|---|
| [`translator`](GLOSSARY.md#translator) | one entry per iteration round: what changed in the [vision](GLOSSARY.md#vision-visionmd), and why |
| [`architect`](GLOSSARY.md#architect) | one entry per decision: the stack, the modules, and each contract — why it has its shape and what was rejected |
| [`planner`](GLOSSARY.md#planner) | one entry per decision of each [wave](GLOSSARY.md#wave) and each [replanning](GLOSSARY.md#replanning): how the work was cut, what was dropped and why |
| [`implementer`](GLOSSARY.md#implementer) | one entry per [task](GLOSSARY.md#task): decisions, deviations from the task file, the files actually touched |
| [`tester`](GLOSSARY.md#tester) | one entry per task: what the automated tests cover and what they do not, and whether a manual test was written |
| [`integrator`](GLOSSARY.md#integrator) | one entry per task: the suite as run and the shared-file notes applied; and one per [feature](GLOSSARY.md#feature), holding the [PR body](GLOSSARY.md#pr-body-artefact) |

**The integrator's feature entry holds an artefact, not a note about one.** Every other entry records
something *about* the work. The integrator runs unattended, and the
[human operator](GLOSSARY.md#human-operator) needs the pull request text on disk to open the pull
request, so the entry is where that text lands. §4.2 exists for it. The commit messages need no such
entry: the integrator writes each one into the merge commit it makes, and git keeps it.

---

## 2. Files and paths

### 2.1 One file is one entry

Until `4.0.0` an agent appended entries to one file per feature. Under parallel execution that file
has N writers — N implementers finishing tasks of the same feature at once — and the factory's third
principle, one file, one writer, cannot hold for it. So **each entry is its own file**, and the
directory is the accumulation.

### 2.2 The path grammar

```text
.factory/registry/<agent>/<scope>/<entry>.md
```

| Segment | Form |
|---|---|
| `<agent>` | the agent that **writes** the entry. Nobody writes under another agent's segment |
| `<scope>` | the feature, for the three agents that work per task; the session, for the three with gates |
| `<entry>` | the task id, for the three that work per task; a decision, for the three with gates |

The agent segment separates the three agents that write about the same task — implementer, tester,
integrator. The scope and entry segments separate the N tasks, or the N decisions, that one agent
records at the same time. Together they give every entry a path no other writer can reach.

### 2.3 Scopes and entries, agent by agent

| Agent | `<scope>` | `<entry>` | Example |
|---|---|---|---|
| `translator` | `project` | `round-NN` | `registry/translator/project/round-02.md` |
| `architect` | `project` for the first session; `change-NN` for each later one | `stack`, `modules`, or a contract id with its `/` replaced by `-` | `registry/architect/project/events-PlayerJumped.md` |
| `planner` | `wave-NN`, or `replan-NN` | a kebab-case slug naming the decision | `registry/planner/wave-01/player-control-cut.md` |
| `implementer` | the feature slug | the task id | `registry/implementer/player-control/T012.md` |
| `tester` | the feature slug | the task id | `registry/tester/player-control/T012.md` |
| `integrator` | the feature slug | the task id, or `pr` for the feature entry — `pr-02` for a second one | `registry/integrator/player-control/pr.md` |

- **Counters are two zero-padded digits** — `round-02`, `change-01`, `wave-03`, `replan-01` — so a
  directory listing sorts in the order the sessions happened. `wave-NN` is the `wave` of the task
  files the session wrote; the first session, which writes waves 0 and 1 together, is `wave-01`.
- **The gated agents write one entry per decision, not one per session.** One architect session
  decides the stack, the modules and every contract of the game, and that does not fit in fifteen
  lines (§4.1) — nor should it, because a later reader looks for the reasoning behind *one* contract,
  and one file per contract is where it is found.
- **The feature slug and the task id are the same strings everywhere**: the task file's `feature`
  and `id`, its path, the `feat/<feature>` and `task/<id>` branches.

### 2.4 Frontmatter

Every entry opens with a frontmatter block carrying one field:

```markdown
---
factory_version: 4.0.0
---
```

The value is the one in `.factory/FACTORY_VERSION` when the entry was written. It is the stamp every
factory artefact carries ([`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md) §4), and it is for a person
to see which factory contract an entry was written under. No agent acts on it, because no agent acts
on a registry entry as an instruction (§5). **The frontmatter does not count toward the fifteen
lines** (§4.1): the cap exists to stop the agent re-narrating its work, and the stamp is not
narration.

Nothing else goes in the frontmatter. The agent, the scope and the entry are fixed by the path, and
repeating them would be a second place to disagree.

### 2.5 Where and when a file exists

**Entries are written in the main checkout**, like task files, never inside a worktree: an entry
written into `../wt-<id>` would exist only on that task's branch, where the integrator and the
planner reading from the main checkout would never see it.

An entry file is created when it is written, and never pre-created empty. Registry files are tracked
in git without exception: a decision that does not survive the [session](GLOSSARY.md#session) that
made it is not a record of anything.

---

## 3. The entry

### 3.1 The template

One template for all six agents. Only `Evidence` differs by agent (§3.4).

```markdown
---
factory_version: 4.0.0
---

# T012 — Apply an upward impulse on jump input

- **Date:** 2026-09-21
- **Outcome:** <one line>
- **Decisions:** <what was chosen and why, or "none">
- **Deviations:** <how reality differed from the task file, or "none">
- **Evidence:** <agent-specific>
```

The five fields are never renamed, never reordered and never omitted. **`Decisions` and `Deviations`
are written out as `none` when there were none**, rather than dropped: an absent field and a field
saying `none` read differently to a person — one says nothing was decided, the other that nobody
considered the question.

`Date` is `YYYY-MM-DD` with no time component, like `created` on a task file.

One optional sixth field exists: **`Corrects`**, on a correction entry only (§4.6).

### 3.2 The heading

| Entry | Heading |
|---|---|
| a task entry, of any of the three per-task agents | `# T012 — Apply an upward impulse on jump input` — the id and the title, verbatim from the task file |
| the integrator's feature entry | `# PR — player-control` |
| a translator round | `# Round 02 — Scope reduced to one biome` |
| an architect or planner decision | `# <the decision, in a few words>` — `# Stack`, `# Contract events/PlayerJumped`, `# Cut player-control into five tasks` |

A heading is one line and is never edited after it is written.

### 3.3 One entry per unit of work

| Agent | One entry per |
|---|---|
| `translator` | iteration round |
| `architect` | decision, in each session |
| `planner` | decision, in each wave or replanning session |
| `implementer` | task it brought to `implemented` |
| `tester` | run — once per implementer attempt, so a task that took two attempts has two |
| `integrator` | task it integrated, plus one per feature for the PR body |

**A task rewritten by replanning and built a second time gets a new entry**, not an amendment to the
first: the first entry described what was true when it was written, and it still is. The second one
is named for the replanning that caused it — `T012-replan-02.md` — and its heading carries the same
suffix, so the pair reads in order.

**The tester runs once per attempt**, inside each implementer session, and an attempt that failed has
already written its entry. A later run writes `T012-02.md` beside it, never over it, as a second
blocked file sits beside the first.

### 3.4 What `Evidence` holds

| Agent | `Evidence` |
|---|---|
| `translator` | what changed in `VISION.md` this round, and the question or answer that forced the change |
| `architect` | the alternative that was rejected, and for each version in the stack the source it was checked against |
| `planner` | the alternative that was rejected |
| `implementer` | what it adapted from `Implementation` and why, and the files it actually touched |
| `tester` | what the automated tests cover and what they do not, and whether it wrote a manual test |
| `integrator` | the suite command and its summary line, which `shared_file_notes` it applied, and the check of its merge commit — `git status --porcelain` empty, the note files `git show --stat HEAD` lists — or, in `pr.md`, the PR body verbatim (§4.2) |

**The implementer's `Deviations` and `Evidence` are what the rest of the factory reads.** The
integrator takes the commit's *why* from them, and the planner writes the next wave against them: the
record of every adaptation an implementer made is how the tree actually came to be what it is. A
tester finding the implementer could fix only outside its task's bounds is a `Deviations` line
opening `Open finding:`; the integrator lists it in the feature's pull request, and the planner's
next session plans it or declines it in a registry decision, so none is lost.

### 3.5 When an entry is written

| Agent | Writes its entry |
|---|---|
| translator, architect, planner | after gate 2, in the same write set as everything else the session produces, as its own row in the gate-2 report |
| tester | at the end of its run, inside the implementer's session, before `verify-task` |
| implementer | after `verify-task` passes and it has committed the task, before its session ends, because the integration that follows reads it |
| integrator | after the merge, the suite and the check of the merge commit pass, before it removes the task's worktree; `pr.md` in the session that closes the feature |

**A [blocked](GLOSSARY.md#blocked) agent writes no entry.** A stopped agent has no decision, deviation
or evidence to record. Why it stopped goes in its [blocked file](GLOSSARY.md#blocked-file), which is
the artefact addressed to the person who has to act on it.

---

## 4. Hard limits

### 4.1 An entry is at most 15 lines

Counted from the `#` heading to the last content line inclusive, blank lines and wrapped lines
included. The frontmatter is not counted (§2.4), and there is one exclusion more, in §4.2.

**The limit is what keeps the registry from becoming a second task file.** Fifteen lines is not room
to narrate a session, and that is the point: the budget forces the agent to record the decision
instead of re-telling the work. An entry that will not fit has almost always started describing
something already written down somewhere better:

| Content that will not fit | Where it belongs |
|---|---|
| what the task was and its acceptance criteria | the task file |
| which lines of which files changed | git |
| how the code is shaped now | the code |
| why a stopped agent stopped | its blocked file |
| the approval conversation of a gated agent | nowhere — reports are chat only |

**Overflow is never solved by writing a second entry for the same unit of work.** Two half-records
where the reader expected one defeat the cap rather than satisfy it. A gated agent whose session
produced two decisions writes two entries because there were two decisions, not because one did not
fit.

### 4.2 The one exclusion: the PR body

A bug integrated after `pr.md` was written makes the feature close again, and the integrator never
edits the first body: it writes `pr-02.md` beside it, as a second blocked file sits beside the first.

The integrator's `pr.md` carries the pull request body in `Evidence`, as a fenced block, exactly as
produced. **That block, and the blank line introducing it, are excluded from the count**; the five
fields around it still count.

For every other entry the registry records something about the work, and capping the description
costs nothing but concision. The PR body *is* the work product, and cutting it at fifteen lines would
destroy a deliverable, not compress a narration. It is copied verbatim and never summarised; what it
must contain is fixed by [`GIT_CONVENTIONS.md`](GIT_CONVENTIONS.md).

**No other entry has this exclusion.** In particular, a test log is not fenced into an entry to get
around the cap — §4.3.

### 4.3 Evidence is a reference, not a transcript

The full output of a test run is hundreds of lines, and anyone can get it back by re-running the
command against the commit. So an entry records the command and its summary line, not the log:

```markdown
- **Evidence:** `npm test` → 88 passed, 0 failed. Applied the one note on `src/game/systems.ts`.
```

There are no sidecar log files. A registry holds entries and nothing else.

### 4.4 An entry never records status

Status lives in the task file and nowhere else ([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §5). No
entry carries a `status` field, and no entry states a status value in prose. Status changes several
times after an entry is written, so a copy of it here would be correct for an afternoon and wrong
for good, in the one place a future reader has no reason to distrust.

Describing the outcome is not recording status. *Outcome: jump landed behind the existing stub
signature* describes what this agent did. *Outcome: T012 is now `implemented`* is a claim about the
plan, and the plan is not this file's to make claims about.

### 4.5 An entry never duplicates the task file

The task file says what must be done. The entry says why this agent did what it did. A sentence that
would be equally at home in both belongs in the task file, and the copy here should not exist: two
files carrying the same instruction can disagree, and this is the one nobody is watching.

### 4.6 Never edited, and corrections

- **An entry is never edited after it is written** — not to sharpen the reasoning, not to reflect
  what was learned later, not to fix a heading.
- **Nothing is ever deleted**, including entries about tasks that replanning later dropped.
- **A correction is a new entry that references the old one**, in a file named for it —
  `T012-correction-01.md` — through the optional `Corrects` field, naming the superseded entry's
  path:

```markdown
---
factory_version: 4.0.0
---

# T012 — correction 1

- **Corrects:** registry/implementer/player-control/T012.md
- **Date:** 2026-09-22
- **Outcome:** the earlier entry named the wrong file as the deviation.
- **Decisions:** none.
- **Deviations:** the unplanned file was `src/mechanics/player/ground.ts`, not `state.ts`.
- **Evidence:** the merge commit for T012 touches `ground.ts`; `state.ts` was never changed.
```

**A correction is not a rebuild.** A task rebuilt after replanning is new work, and gets an ordinary
entry (§3.3). A correction says that what was *recorded* was wrong.

---

## 5. Who reads registries

| Reader | May read | When |
|---|---|---|
| any agent | its own entries | freely |
| `integrator` | the implementer's entry for the task it is integrating | at every integration |
| `planner` | every entry of every agent | when it plans a wave, and when it replans |
| any agent | another agent's entries, otherwise | never |
| human operator | everything | always |

**The integrator reads the implementer's entry, and nothing more of anyone's.** That entry is the
*why* the commit message needs, already written by the agent that knew it. Until `4.0.0` a
prohibition kept agents out of each other's registries to protect the tester's independence; between
implementer and integrator there is no independence to protect, and the tester — now a subagent
inside the implementer's session — has none left to lose.

**The planner reads them all, and is their primary consumer.** A wave is written against the tree as
it stands, and the implementers' deviations are the record of how the tree came to differ from what
the planner predicted. A replanning is a judgement about a plan that has gone wrong, and what informs
it lives in the same place.

**Historical entries are context, not instructions.** An entry records what was true when it was
written. It cannot direct work now: the live instruction is the task file, and nothing else. An agent
that finds a decision in an entry from four tasks ago has found a fact about the past, not an order.

What an agent may load beyond this is [`CONTEXT_POLICY.md`](CONTEXT_POLICY.md)'s business; this
section states the registry-specific rules, and that document is authoritative where the two touch.

---

## 6. Worked examples

**Implementer**, in `.factory/registry/implementer/player-control/T012.md`:

```markdown
---
factory_version: 4.0.0
---

# T012 — Apply an upward impulse on jump input

- **Date:** 2026-09-21
- **Outcome:** jump landed behind the stub's signature; verify-task passed first time.
- **Decisions:** none — the task file decided everything the code needed.
- **Deviations:** touched `src/mechanics/player/ground.ts`, not in `files`: its landing check reset
  `onGround` before `jump` could read it on the same frame. Inside `mechanics`, so recorded here.
- **Evidence:** `Implementation` used as written. Files: `jump.ts`, `ground.ts`, `jump.test.ts`.
```

Eight lines. The deviation is there because the integrator turns it into the commit's *why*, and
the planner will write the next wave of `mechanics` against a `ground.ts` it did not predict.

**Integrator**, the same task, in `.factory/registry/integrator/player-control/T012.md`:

```markdown
---
factory_version: 4.0.0
---

# T012 — Apply an upward impulse on jump input

- **Date:** 2026-09-21
- **Outcome:** merged into feat/player-control; suite green.
- **Decisions:** none.
- **Deviations:** none.
- **Evidence:** `npm test` → 88 passed, 0 failed. Applied the one note on `src/game/systems.ts`.
```

**Architect**, a contract decision, in
`.factory/registry/architect/project/events-PlayerJumped.md`:

```markdown
---
factory_version: 4.0.0
---

# Contract events/PlayerJumped

- **Date:** 2026-09-19
- **Outcome:** an event carrying the time and the take-off position, emitted by `mechanics`.
- **Decisions:** the position is where the jump started, not where the player is — `audio` and
  `visuals` both need the take-off point, and nobody needs a position they can read from state.
- **Deviations:** none.
- **Evidence:** rejected carrying the velocity too: no consumer needs it, and every field of an
  event is a promise to every consumer.
```

**Integrator**, the feature entry, showing the §4.2 exclusion, in
`.factory/registry/integrator/player-control/pr.md`:

````markdown
---
factory_version: 4.0.0
---

# PR — player-control

- **Date:** 2026-09-23
- **Outcome:** `player-control: The player runs, jumps and lands`
- **Decisions:** none.
- **Deviations:** none.
- **Evidence:**

```text
## Summary
The player runs, jumps and lands. Five tasks, one bug fixed from the manual batch.
...
```
````

Seven counted lines, plus an excluded block. `Outcome` holds the pull request's title and the block
its body, and the operator copies both, once the feature's manual batch has passed.

---

## 7. What a registry is not

| Not this | Because |
|---|---|
| a status record | the task file owns status (§4.4) |
| a second task file | an instruction belongs to its one reader's task file (§4.5) |
| a log of the session | fifteen lines is not room for one, deliberately (§4.1) |
| a blocked file | a stopped agent writes no entry; why it stopped goes where a person will act on it (§3.5) |
| a copy of a report | approval traffic is chat only, and worthless once answered |
| a scratchpad | an entry is written once, when the work is done, and never edited (§3.5, §4.6) |
