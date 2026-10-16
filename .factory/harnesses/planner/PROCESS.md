# planner — process

One session, from its input to the commit. The steps are numbered continuously and are not
comparable with the steps of another harness.

## Session start

1. Confirm the session is running the model named in `AGENT.md` — Opus 5.5. If it is not, say so and
   stop.
2. Establish which session this is, and say which in chat:
   - **`wave-NN`** — the next wave is due. The first one follows the architect's `project` session,
     is `wave-01`, and writes waves 0 and 1 together. Every later one writes one wave, numbered one
     more than the highest `wave` in the plan.
   - **`replan-NN`** — the operator summoned you after a blocked file with `needs: planner`, after
     the architect changed a contract, or after a manual test came back `FAIL`. `NN` is one more than
     the last `replan-NN` under `.factory/registry/planner/`. You never decide that one is due.
3. Read the input whole: the vision, the root and module `CLAUDE.md` files, the contracts,
   `.factory/project/reference/README.md` and every approved piece the wave's features answer for,
   and — on a replanning — the blocked files, the manual tests and the architect's `change-NN`
   entries the operator points you to. A feature whose references are not yet approved is not
   planned: say so at gate 1 — `docs/TASK_FILE_SPEC.md` §2.10.
4. Compare the `factory_version` field in `AGENT.md` against `.factory/FACTORY_VERSION`. A
   difference means this harness text predates the current factory contract: mention it in the
   gate-1 report and continue. It never blocks. See `docs/HARNESS_SPEC.md` §8.1.

## The work

Iteration with the operator here is unlimited and expected. See `docs/APPROVAL_PROTOCOL.md` §1.2.
Present one feature at a time, iterate on it until the operator confirms it, and only then open the
next.

5. Read the state of the plan: every task file's frontmatter under `.factory/tasks/`. Then your own
   registry, and every implementer's and tester's entries since your last session — the deviations
   are how the tree came to differ from what you predicted. Every `Open finding:` line among them
   you either plan, in a task that names it, or decline, in a registry decision that says why.
6. Read the code the next tasks will touch: on `main` in the main checkout, and on each open feature
   branch in `../wt-feat-<feature>`. Search from `source_root`, never from the repository root.
7. State to the operator what you found before you write anything. On a `wave-NN` session, which
   features this wave carries and what the last wave did differently from what the plan said. On a
   `replan-NN` session, what is wrong with the plan, for which tasks, and what you propose to change.

**On a `wave-NN` session, steps 8 to 11.**

8. On the first session, write wave 0: the `tooling` feature, as `scaffolding` tasks, in the order
   their commands need — the manifest before the test runner that it installs. Wave 1 builds the
   `shared` modules the next waves import, in features of their own — `docs/TASK_FILE_SPEC.md`
   §6.4.
9. Cut the wave's features into tasks, one thing each, and give each its module, its files, its
   `depends_on_contract` and `depends_on_task`. Keep every dependency inside its feature.
10. Give each task its `references`: the exact paths of the approved pieces it is built against,
    `08-engineering/coding-standards.md` on every task that writes code — `docs/TASK_FILE_SPEC.md`
    §2.10. Then write its `Implementation`, `Interfaces` and `Acceptance criteria` against the code as
    it stands and against those references: every number, duration, pose, frame order and sound the
    contracts and pose sheets fix becomes a criterion that states it and names its source —
    `docs/TASK_FILE_SPEC.md` §2.6. Where the code and a reference disagree, the task follows the
    reference. Add a `Manual check` only where a person must judge something no test can assert — how
    it looks beside its `sheet.png` or its `sandbox.html`. Add each feature's integration-test task.
11. Read the wave for file disjointness: list every file, and every task that names it. Two tasks
    that could run together never share one.

**On a `replan-NN` session, steps 12 to 15.**

12. For each blocked task: decide whether the task file was wrong and is rewritten, or is no longer
    needed and is deleted; and whether the work on its `task/` branch is reused or discarded.
13. For each manual test that came back `FAIL`: classify the failure — `docs/TASK_FILE_SPEC.md` §8.2.
    An implementation failure is a bug task file. An integration or contract failure goes to the
    architect first: say so and stop, and write the bug task after the architect's session.
14. Write the bug task files, and add each bug's id to the `depends_on_task` of the pending tasks that
    rely on the failed behaviour.
15. Rewrite, add or delete only the task files the finding reaches, with their `references` as at
    step 10. Read the result for file disjointness, as at step 11.

16. Hold every task file against `docs/TASK_FILE_SPEC.md` §6 and §7.2 — what the implementer will
    check before it acts — and verify the `Work` block of `CHECKLIST.md`.

## Gate 1

17. File the report, naming the features in the order the operator confirmed them. Show the task
    files in full beside it.

```text
Gate 1 — file a work report and wait. See `docs/APPROVAL_PROTOCOL.md` §4.1.
```

## Draft the write set

18. Read `OUTPUT.md` and draft every artefact from its template — the task files and one registry
    entry per decision. Write nothing to disk. Prepare the rewrite preview of every task file you
    rewrite in place or delete — `docs/APPROVAL_PROTOCOL.md` §3.

## Gate 2

19. Verify the `Write set` block of `CHECKLIST.md`, then file the report. Its `Scrutinise` block
    names every file two tasks share.

```text
Gate 2 — file a write-set report and wait. See `docs/APPROVAL_PROTOCOL.md` §4.2.
```

## Write and commit

Write exactly the approved paths, in this order, and nothing else.

20. `.factory/tasks/<feature>/<id>.md` — each new or rewritten task file, stamped from
    `.factory/FACTORY_VERSION`, with `status: pending`. Delete each task file the report dropped.
21. `.factory/registry/planner/<wave-NN | replan-NN>/<decision>.md` — one file per decision.
22. Stage exactly those paths, by path — deletions included — and commit them on `main` with the
    message `docs/GIT_CONVENTIONS.md` §2.3 gives this session. Never `git add -A`.

## Session end

23. State in chat what was written, deleted and committed, and in one line what the operator does
    next — run the launcher, or, after a `wave-01` session, run it for `tooling` and merge
    `feat/tooling` into `main` by pull request before any other feature starts. Name every `task/`
    branch the replanning discarded, for the operator to remove. Nothing further happens here.

## If you must block

24. File a blocked report and produce nothing — `docs/APPROVAL_PROTOCOL.md` §5.1–§5.3. You block
    when the plan needs a contract, a module or a root that does not exist, when the vision and the
    architect's work contradict each other, or when a replanning's input does not say what went
    wrong. Blocking is available at every step, and how it resolves is `docs/APPROVAL_PROTOCOL.md`
    §5.4.
