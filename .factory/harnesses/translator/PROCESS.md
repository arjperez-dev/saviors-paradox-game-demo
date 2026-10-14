# translator — process

One session, from the idea to the commit. The steps are numbered continuously and are not
comparable with the steps of another harness.

## Session start

1. Confirm the session is running the model named in `AGENT.md` — Opus 5.5. If it is not, say so and
   stop.
2. Your input is the operator, in conversation. Nothing on disk is handed to you.
3. Establish which session this is, and say which in chat. A **first session** writes
   `.factory/project/VISION.md`, which does not exist yet. A **revision** reopens a vision that
   exists, because the operator asked for it: read it whole first, and change only what the operator
   reopens.
   In either, if `.factory/project/reference/README.md` exists, read it and every piece it marks
   approved. They are the operator's own decisions, already made: never ask again what one of them
   answers, and name every place where the vision says something different as a question for the
   operator — never settle it yourself, in either direction.
4. Compare the `factory_version` field in `AGENT.md` against `.factory/FACTORY_VERSION`. A
   difference means this harness text predates the current factory contract: mention it in the
   gate-1 report and continue. It never blocks. See `docs/HARNESS_SPEC.md` §8.1.

## The work

Iteration with the operator here is unlimited and expected. See `docs/APPROVAL_PROTOCOL.md` §1.2.

5. Ask the operator for the idea, in whatever language they prefer to give it.
6. Restate the idea back in technical English, in a few lines — including everything it already
   answers — and ask whether the restatement is right. Correct it until they say it is.
7. Work through `templates/clarifying-questions.md`, area by area, in rounds. A round is one
   exchange: the questions you ask, and the answers that come back. Skip every question the
   restatement already answers, and give every question you do ask its reason: what is ambiguous,
   and why it matters to the game.
8. Press the content scope into numbers. An adjective is not an answer, and a plan built on one is
   fiction.
9. Elicit reference games in the form *like X, but Y*: what the project takes from each and what it
   rejects.
10. Separate constraints from decisions as you go. What the client requires is recorded verbatim as
    a constraint; what follows from it technically is the architect's. Where the operator states a
    technical choice, record it as a client constraint — never as your own decision.
11. Mark as soft every field the operator did not confirm, and every question they could not answer.
    Where an approved reference fixes what a field describes, the field says it in prose and names
    the reference by its path under `reference/`, instead of restating its numbers.
12. Keep a note in this session — not on disk — of what changed in each round and of the question or
    answer that forced the change. The registry entries are written from it.
13. Present the structured idea in full, all fifteen fields, and iterate on it until the operator is
    done changing it.

## Gate 1

14. Verify the `Work` block of `CHECKLIST.md`, then file the report.

```text
Gate 1 — file a work report and wait. See `docs/APPROVAL_PROTOCOL.md` §4.1.
```

## Draft the write set

15. Read `OUTPUT.md` and draft every artefact from its template — the vision, and one registry entry
    per round that changed a field. Write nothing to disk. On a revision, prepare the rewrite preview
    of `VISION.md` — `docs/APPROVAL_PROTOCOL.md` §3.

## Gate 2

16. Verify the `Write set` block of `CHECKLIST.md`, then file the report.

```text
Gate 2 — file a write-set report and wait. See `docs/APPROVAL_PROTOCOL.md` §4.2.
```

## Write and commit

Write exactly the approved paths, in this order, and nothing else.

17. `.factory/project/VISION.md`, stamped from `.factory/FACTORY_VERSION`.
18. `.factory/registry/translator/project/round-NN.md` — one file per round that changed a field, in
    the order the rounds happened, numbered on from the last entry already there.
19. Stage exactly those paths, by path, and commit them on `main` — `docs/GIT_CONVENTIONS.md` §2.2
    and §2.3. Never `git add -A`: the main checkout may hold state other sessions wrote.

## Session end

20. State in chat what was written and the commit it went into, and in one line what the operator
    does next — open an architect session. Nothing further happens in this session.

## If you must block

21. File a blocked report and produce nothing — `docs/APPROVAL_PROTOCOL.md` §5.1–§5.3. You block when
    the operator cannot or will not answer enough for the fifteen fields to be filled even as soft
    assumptions, when two answers contradict each other and the operator does not resolve it, or
    when you are asked to record the idea as something other than what the operator said. Blocking
    is available at every step, and how it resolves is `docs/APPROVAL_PROTOCOL.md` §5.4.
