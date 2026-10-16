# Git Conventions

This document defines how a game's work reaches version control: which branches exist and where each
one is checked out, who commits what and on which branch, what a commit message says, how a task is
integrated into its feature, and what a pull request contains.

It governs **game repositories**. The factory repository is governed by its own `CONTRIBUTING.md`,
which differs where the factory has consumers, releases, a tracker and CI, and a game has none of
them.

The whole of it rests on these units:

```text
1 project = main
1 feature = 1 feat/ branch  = 1 integration worktree = 1 pull request
1 task    = 1 task/ branch  = 1 worktree             = 1 commit + 1 merge commit
1 wave    = 1 planner session — not a git unit
```

> **No agent opens a pull request, merges into `main` or pushes.** Those three belong to the
> [human operator](GLOSSARY.md#human-operator). Every other git command is done by whoever the rules
> below give it to — an agent or a [factory script](GLOSSARY.md#factory-scripts).

Vocabulary is fixed by [`GLOSSARY.md`](GLOSSARY.md); paths by
[`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md); the task file, its status and its `files` by
[`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md); the commands and the module map by
[`CONTRACT_SPEC.md`](CONTRACT_SPEC.md); where the PR body is written by
[`REGISTRY_SPEC.md`](REGISTRY_SPEC.md); what each agent may read by
[`CONTEXT_POLICY.md`](CONTEXT_POLICY.md).

---

## 1. Branches and worktrees

### 1.1 Three kinds of branch

| Branch | Holds | Lives in |
|---|---|---|
| `main` | what has been merged by a pull request, plus everything under `.factory/` | the **main checkout** — the repository's own directory |
| `feat/<feature>` | one [feature](GLOSSARY.md#feature) while it is built | its **integration worktree**, `../wt-feat-<feature>` |
| `task/<id>` | one [task](GLOSSARY.md#task) while it is built | its **task worktree**, `../wt-<id>` |

`<feature>` is the feature slug and `<id>` the task id, verbatim from the
[task file](GLOSSARY.md#task-file) — kebab-case slug, `T` or `B` plus three digits. One slug and one id
name the task file's directory and file, the branches, the worktrees and the registry paths, with no
translation step between any two of them.

**A branch can be checked out in one worktree at a time**, which is why each kind has its own place.
The main checkout stays on `main` for the life of the project, because `.factory/` is written there
(§2); `feat/<feature>` needs a checkout of its own for the integrator to merge into; and each running
task needs one for its implementer.

Worktrees are **siblings of the repository, never inside it**, so nothing about them can be staged by
accident. They are not committed and not listed anywhere. A game's `.gitignore` needs no line for
them.

### 1.2 Who creates what, and when

| When | What | By |
|---|---|---|
| a task of a feature is launched and `feat/<feature>` does not exist | `git worktree add ../wt-feat-<feature> -b feat/<feature> main`, then `install_command` in it | the [launcher](GLOSSARY.md#factory-scripts) |
| every task launched | `git worktree add ../wt-<id> -b task/<id> feat/<feature>`, then `install_command` in it | the launcher |
| a task integrated | its worktree removed and `task/<id>` deleted | the [integrator](GLOSSARY.md#integrator) |
| a task blocked | nothing: its worktree and branch are kept | — |
| a feature's pull request merged | `feat/<feature>` deleted and `../wt-feat-<feature>` removed | the human |

**A blocked task's branch and worktree are kept, unmerged.** They are the only evidence of what was
tried, and [replanning](GLOSSARY.md#replanning) decides whether the work is reused or discarded;
removing them before that decision destroys it. When the planner discards the work, it says so in its
registry and the human removes both.

### 1.3 A task branch falls behind, and nothing happens

`task/<id>` is cut from `feat/<feature>` when the task starts. As other tasks of the feature integrate,
the feature branch moves on and the task branch does not. **It is never rebased, and the feature
branch is never merged back into it.**

That works because two tasks alive at the same time never touch the same file
([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §6.5): if nobody changed the lines a task changed, there is
nothing to reconcile, and the `--no-ff` merge brings the two together cleanly. That assumption holds
the whole branch model up. If a task merge ever conflicts, the thing to examine is the disjointness of
the plan, not the state of the branch — and the integrator stops with `needs: planner` (§3.3).

### 1.4 Dependencies stay inside a feature

**`depends_on_task` never names a task of another feature.** A task is `integrated` when it has been
merged into *its own* feature branch, and no other feature branch sees that code until the feature
reaches `main` by pull request. A task of feature B depending on a task of feature A would start from
a branch where A's code does not exist, however `integrated` A's task was.

Two rules follow, and the planner writes the plan under both:

- **Wave 0 is its own feature, `tooling`**, and it reaches `main` by pull request before any other
  feature branch is cut. The launcher cuts no `feat/` branch other than `feat/tooling` while a
  `tooling` task has not reached `main`. Every other feature is then cut from a `main` that has the
  manifest, the configuration and the stubs.
- **A feature that needs another feature's behaviour is planned once that feature is in `main`.** Its
  branch is cut after, from a `main` that has the code it depends on.

The second rule is also how a **shared module** reaches the features that import it
([`CONTRACT_SPEC.md`](CONTRACT_SPEC.md) §4.1): the feature that builds or extends it reaches `main`
first, and every feature that uses that code is cut after it.

What a feature consumes through a [contract](GLOSSARY.md#contract) needs neither rule: contracts and
their stubs are on `main` from the architect's first session, and every feature branch is cut with
them.

### 1.5 `main` returns to a feature branch once: after a contract change

A contract is changed on `main`, by the [architect](GLOSSARY.md#architect)
([`CONTRACT_SPEC.md`](CONTRACT_SPEC.md) §6). Feature branches already open were cut before it and do
not see it. So the architect's `change-NN` session ends by **merging `main` into every open feature
branch**, in each one's integration worktree — a merge, never a rebase, because task branches cut
from the old feature branch still have to merge into the new one.

It is the only time `main` goes back into a feature branch. A merge that conflicts stops the architect
in its session, in front of the operator, which is exactly where a conflict between a contract and the
code built on it should be met.

---

## 2. Where `.factory/` is committed

### 2.1 Only on `main`, only from the main checkout

**Feature and task branches never carry a change under `.factory/`.** Every factory artefact is
written in the main checkout — the task files, the registry entries, the blocked files, the manual
tests — and every one of them is committed on `main`.

The reason is that parallel work writes the factory's state from many places at once, and the state
has to be one thing. A status written in a task worktree would exist only on that task's branch; a
registry entry committed on a feature branch would reach `main` only when the feature did, and a
feature PR carrying factory state would conflict with every other PR carrying its own. With all of it
on `main`, a feature branch carries the game's code and nothing else, and its pull request cannot
collide with the factory.

A feature branch still has a copy of `.factory/` — the one `main` had when the branch was cut. Nobody
reads it and nobody writes it. When the feature merges, git keeps `main`'s version, because the
feature branch never changed the files.

### 2.2 Who commits it

| What | Committed by | When |
|---|---|---|
| a gated session's write set — the vision, the architect's contracts, stubs and `CLAUDE.md` files, the planner's task files, their registry entries | the agent of that session | at the end of the session, after gate 2 |
| the **state of execution** — every status line, registry entry, blocked file, manual test and `pr.md` that the unattended pipeline wrote | the human | before opening a feature's pull request, and after each manual batch |

**A gated agent commits exactly the paths its gate-2 report named, and nothing else.** It stages them
by path, never with `git add -A`: the main checkout may hold state the unattended pipeline wrote
meanwhile, and that state is not the session's to commit. The commit carries what the operator just
approved, and only that, which is why it needs no approval of its own.

Committing on `main` is not merging into `main`. A gated session's commit carries nothing a person has
not read at gate 2; a merge into `main` carries a feature nobody has read as one diff yet, which is
what the pull request is for.

The architect's write set is game code — contracts, stubs, `CLAUDE.md` files — and it lands on `main`
the same way. Feature branches must be cut from a `main` that has it.

**The state of execution is committed by the human, with one command:**

```bash
git add .factory && git commit -m "chore: record the factory state"
```

Run in the main checkout, on `main`. Twice a feature is the minimum — before its pull request, so the
record of how it was built is on `main` beside it, and after each manual batch, so the verdicts are.
More often is harmless. What it may include from a pipeline still running is simply recorded one
commit early.

### 2.3 The commits that are not tasks

Every commit on `main` that is not a merged pull request is one of these:

| Produced by | Contains | Message |
|---|---|---|
| [bootstrap](GLOSSARY.md#bootstrap) | `.factory/` and `docs/` | `chore: install the conectium game factory v<version>` |
| the translator | `VISION.md`, its registry entries | `docs: record the project vision` |
| the architect, first session | `contracts/`, the stubs, every `CLAUDE.md`, its registry entries | `feat: add the contracts and the project facts` |
| the architect, `change-NN` | the changed contracts, stubs and `CLAUDE.md` files, its registry entries | `feat: change the <contract-id> contract` — naming the one contract, or `feat: change <N> contracts` |
| the planner, `wave-NN` | the wave's task files, its registry entries | `docs: plan wave <N>` |
| the planner, `replan-NN` | the rewritten, new and deleted task files, its registry entries | `docs: replan <NN>` |
| the human | the state of execution (§2.2) | `chore: record the factory state` |

`<version>` in the bootstrap commit is read from `.factory/FACTORY_VERSION`, which fixes in the history
which factory version the game was built with. None of these commits carries a `Task:` footer: they
are what produces the tasks, not tasks.

---

## 3. Commits

A task produces two commits. The implementer commits the work on the task branch; the integrator
merges it into the feature branch, and the merge commit carries the message. They are different
commits with different jobs, which is how the implementer can own the commit and the integrator the
message.

### 3.1 The task commit

**Exactly one commit on `task/<id>`, made by the implementer after `verify-task` passes**, holding
everything the task changed:

```text
T012: Apply an upward impulse on jump input
```

| Part | Form |
|---|---|
| Subject | `<id>: <title>`, the title verbatim from the task file's heading |
| Body | none |
| Footer | none |

It carries no Conventional type because it is not the message anybody reads: the merge commit above it
is (§3.2). It exists so that the task's work is one object in the history, and its subject is copied
rather than written so that it costs no judgement.

**One commit, not a series.** Work in progress is never committed, so a task that took two attempts,
or an [escalation](GLOSSARY.md#escalation) to Opus 5.5, still produces one commit, made once the work
passed. `git add -A` inside the task worktree is correct: everything in it is the task's, and nothing
under `.factory/` there is ever written (§2.1).

### 3.2 The merge commit

The integrator merges `task/<id>` into `feat/<feature>` with `--no-ff`, and writes the message:

```text
<type>[(<scope>)]: <subject>

<body, wrapped at 72 columns>

Task: <id>
```

A complete example, for the task of [`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §9:

```text
feat(mechanics): apply an upward impulse on jump input

Clear onGround in the same step as the impulse, so that a second press
inside one physics tick cannot fire a second jump. The ground check now
leaves onGround alone on the frame a jump starts.

Task: T012
```

**Type.**

| Type | Applies when |
|---|---|
| `feat` | the game does something it did not do before — the ordinary `task_type: implementation` task |
| `fix` | a bug task file (`type: bug`): behaviour already integrated is wrong, and this corrects it |
| `refactor` | structure changes and behaviour does not — the tests are unchanged and still pass |
| `test` | tests are added and production code is untouched, as in a task of integration tests |
| `build` | build system, dependencies or tooling — the `tooling` tasks of wave 0 |
| `docs` | documentation only |
| `chore` | anything else, after checking the six above |

**Scope** is optional, a single lowercase noun, and is usually the task's
[module](GLOSSARY.md#module). It is never the feature slug: the feature is in the task file the footer
names, and a slug-scope would open every commit of a feature with the same word.

**Subject.** Imperative, lowercase after the colon unless the first word is an identifier, no final
full stop, no `and`, and **at most 72 characters for the whole line**, type and scope included. It is
derived from the task's title, which the planner already kept to 72 characters and one thing
([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §6.1); the integrator shortens it to fit the prefix and never
by dropping work the commit does.

**Body.** What changed and why, never how — the diff says how. **The *why* comes from the
implementer's registry entry for the task** ([`REGISTRY_SPEC.md`](REGISTRY_SPEC.md) §3.4): its
decisions and deviations are what the diff cannot say. The body never contains the journey — attempts,
escalation, what was tried first — because the history never held those states; never a
[status](GLOSSARY.md#status); and never the task file's instructions restated.

**Footer.** Exactly one line, `Task: <id>`, naming exactly one task. It is what makes the history
traceable both ways: from a commit to the task file that specified it, and from a task id to the merge
that delivered it.

### 3.3 Integrating a task

The integrator works in the feature's integration worktree, under the feature's lock (§4), and in this
order:

1. `git merge --no-ff --no-commit task/<id>`.
2. Apply the task's `shared_file_notes`, one by one, and stage each note's `file` by path —
   `git add -- <file>`. They become part of the same merge commit, so the task and the entries it
   needed in shared files land as one change. `git commit` takes what is staged, not what is on disk:
   a note applied and not staged is left out of the merge and stays behind in the worktree.
3. If the merge or a note changed the package manifest, run `install_command` in the integration
   worktree, and stage by path each file it rewrote.
4. Run `test_command` — the whole suite, not the task's tests.
5. Check that `git diff --name-only` prints nothing — nothing is left unstaged — then commit, with the
   message of §3.2.
6. Check the commit: `git status --porcelain` prints nothing, and `git show --stat HEAD` lists every
   `file` of the task's `shared_file_notes`.
7. Write its registry entry, remove `../wt-<id>` and delete `task/<id>`.

**The integration worktree is clean before step 1.** The integration script does not start the
integrator while `git status --porcelain` there prints anything, and leaves the task `implemented`:
what it found belongs to no task, and neither the script nor the integrator commits or discards it.
The operator does, and runs `integrate.py <id>` again.

The integrator does not set the task `integrated`. When its session ends, the integration script
looks for the merge commit carrying `Task: <id>` on `feat/<feature>`, repeats the check of step 6, and
writes the status itself ([`TASK_FILE_SPEC.md`](TASK_FILE_SPEC.md) §5.1); a session that ends with
neither that commit nor a blocked file, or with a commit that fails the check, is blocked by the
[launcher](GLOSSARY.md#factory-scripts).

**If anything in steps 1 to 5 fails, it undoes the merge** with `git merge --abort`, writes a
[blocked file](GLOSSARY.md#blocked-file) with `needs: planner`, and sets the task `blocked`. The feature
branch is left exactly as it was, and the task branch and worktree are kept (§1.2). A feature branch
never holds a merge whose suite failed.

**If step 6 fails, the merge commit stays as it is** — never amended, reset or followed by a commit of
the integrator's (§7). It writes no registry entry, writes a blocked file with `needs: planner` naming
what was left out, and sets the task `blocked`. The same two commands are the operator's check of any
integration: run in `../wt-feat-<feature>` after it, the first prints nothing and the second lists
every note's `file`.

### 3.4 Getting a message into git intact

A commit message is the one artefact whose defects are permanent. It reaches git **as a whole, with
its blank lines**:

```bash
git commit -F - <<'EOF'
feat(mechanics): apply an upward impulse on jump input

Clear onGround in the same step as the impulse, so that a second press
inside one physics tick cannot fire a second jump.

Task: T012
EOF
```

**Never repeated `-m` flags**: each adds a paragraph and shell quoting eats blank lines, which is how a
`Task:` footer ends up glued to the last sentence of the body. A message file written for `-F` goes
outside the repository, never into a worktree, where it could be staged.

---

## 4. The lock

**Integrations into one feature happen one at a time.** Several implementers of one feature can
finish within seconds of each other; the launcher starts each integration as soon as its implementer
session ends, and the merges into one
feature branch have to be serialised. The lock is per feature, at `.factory/locks/<feature>.lock`, so
**two features integrate in parallel without touching each other** — which is what makes it viable
for a wave to cross features.

The lock is held from step 1 of §3.3 to the end of step 7, and released whether the integration
succeeds or stops. A lock file is runtime state and says nothing worth recording: it is the one thing
the factory excludes from git, in `.factory/.gitignore`
([`REPOSITORY_LAYOUT.md`](REPOSITORY_LAYOUT.md) §3).

The integration script takes it as an **operating-system lock** on that file — `fcntl` on Linux and
macOS, `msvcrt` on Windows — rather than with `flock`, which does not ship with Git for Windows. The
operating system releases the lock when the process holding it exits, however it exits, so a crashed
integration never leaves a lock for a person to delete.

---

## 5. Pull requests

### 5.1 When

A feature's pull request is opened by the human when **all three** hold:

- every task of the feature is `integrated`;
- its [manual batch](GLOSSARY.md#manual-batch) has passed, and any bug it produced has been integrated
  and passed its own;
- the state of execution has been committed on `main` (§2.2), and both `main` and `feat/<feature>`
  are pushed.

It does not wait for the other features of the same wave. Base `main`, head `feat/<feature>`.

### 5.2 Title

```text
<feature-slug>: <summary>
```

The summary is one line the integrator writes at the top of `pr.md`, saying what the feature delivers
— `player-control: The player runs, jumps and lands`. There is no feature title anywhere else to copy:
a feature is named by its slug, and described only here.

The title is deliberately **not** Conventional Commits shaped. A feature holds `feat`, `fix`, `test`
and `build` merges alike, and a single type would describe it as whichever kind of change dominated.

### 5.3 Body

The integrator writes it into `.factory/registry/integrator/<feature>/pr.md` once the feature's last
task is `integrated` ([`REGISTRY_SPEC.md`](REGISTRY_SPEC.md) §4.2), in a session of its own that the
integration script starts, and the human copies it. A bug integrated after that gets a new body beside
the first, `pr-02.md`, and the human copies the latest. Four sections, in this order:

````markdown
## Summary

<what the feature delivers, and what it deliberately does not — two or three sentences>

## Tasks

| id | title | type |
|---|---|---|
| T010 | Add the grounded check for bodies | feat |
| T012 | Apply an upward impulse on jump input | feat |
| B001 | Stop the player sticking to walls on a jump | fix |

## Testing evidence

- Every task passed `verify-task`, and every merge ran the whole suite green.
- <the last suite run: the command and its summary line>
- <the manual tests of the feature, and how many>

## Scrutinise

- <the one or two things most likely to be wrong, and where a reviewer should look first>
````

`Tasks` lists every task and bug of the feature with the type of its merge commit. With the `Task:`
footers, it is what lets a reviewer walk the pull request merge by merge against the plan.

**`Testing evidence` states what the pipeline guarantees**: a task reaches `integrated` only through
`verify-task` and a green suite after its own merge. The manual batch has run by the time the PR is
opened, but not by the time the integrator writes `pr.md`, so its verdicts are in the manual tests
committed on `main`, not here.

**`Scrutinise` is the section that earns the pull request.** It is the first time the feature is seen
as one diff, and what belongs there is what a task at a time could not show: an interaction between
two tasks, a pattern repeated in three, a shared file that grew in a direction nobody planned. It
also lists every `Open finding:` of the feature's implementer entries — a tester finding no task could
close inside its own bounds — so the reviewer sees what the planner's next session must answer.

### 5.4 Merging

**Merge with a merge commit — never squash, never rebase.**

| Strategy | What it costs |
|---|---|
| **squash** | collapses the feature into one commit and orphans every `Task:` footer |
| **rebase** | keeps the commits but flattens the feature away; nothing in `main` says which merges formed one pull request |
| **merge commit** | keeps both: the task merges survive intact, and the merge commit is the feature's boundary |

After the merge, the human deletes `feat/<feature>`, removes `../wt-feat-<feature>`, and pulls `main`
into the main checkout.

---

## 6. Division of labour

| Action | By |
|---|---|
| cut `feat/<feature>` and its integration worktree | the launcher |
| cut `task/<id>` and its worktree; run `install_command` in each | the launcher |
| write the code and tests of a task | the implementer |
| run `verify-task` | the implementer runs it; the script decides |
| start the integration of an implemented task, under the feature's lock | the launcher, through the integration script |
| the task commit | the implementer |
| merge a task into its feature, apply shared-file notes, run the suite, write the message | the integrator |
| remove a task's worktree and branch after integrating | the integrator |
| set a task `integrated` | the integration script, on finding the merge commit |
| commit a gated session's write set on `main` | the translator, architect or planner of that session |
| merge `main` into open feature branches after a contract change | the architect |
| commit the state of execution on `main` | **the human** |
| `git push` | **the human** |
| open the pull request | **the human** |
| merge into `main` | **the human** |
| delete the feature branch and its worktree after the merge | **the human** |

Read it as one sentence: **agents do the git work of building; the human does the git work of
publishing.** The three actions that stay human — push, pull request, merge into `main` — are the ones
that make work visible beyond the machine or permanent in `main`, and each is where a person decides
the work is ready. Every harness's `RULES.md` carries the rule, and no agent reaches the network for
git.

---

## 7. What a game repository deliberately does not do

| Not this | Why |
|---|---|
| squash or rebase merges | each destroys half of the unit equation (§5.4) |
| rebasing a task branch, or merging a feature branch into it | task branches are disjoint in files and need neither (§1.3) |
| `git commit --amend`, force-push, rewriting a pushed branch | a task is committed once it passed, so there is nothing to amend, and the merges depend on the history staying put |
| factory state on a feature or task branch | it lives on `main` only (§2.1) |
| a `depends_on_task` across features | the dependency's code is not on the dependent's branch until it reaches `main` (§1.4) |
| tags, releases, version bumps of the game | the game has no release process; the semver that exists is the [factory's](GLOSSARY.md#factory-version) |
| a `CHANGELOG` | the history and the registries are the record |
| `BREAKING CHANGE:` footers, or `!` after the type | they warn consumers of a public API, and a game has none |
| issue references | there is no tracker; the plan is the queue |
| attribution trailers | every commit in a game is produced the same way, so a trailer distinguishes nothing |
| an agent opening a pull request, merging into `main`, or pushing | §6 |
