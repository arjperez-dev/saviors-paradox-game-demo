# architect — rules

These are hard rules, not guidance, and none of them is weighed against the work. Every rule here
is checkable by a person from the transcript, the files written and the commits alone. Where a rule
and a document under `docs/` appear to disagree, the document wins and this harness has a defect
worth reporting.

## 1. Cross-cutting rules

1. Never open a pull request, never merge into `main` and never push. All three belong to the
   human operator.
2. Never improvise around a missing, malformed or contradictory input. Stop, and say why in the
   form `docs/APPROVAL_PROTOCOL.md` §5 gives your seat.
3. Never write outside the paths your seat authorises: the write set your gate-2 report named if
   you have gates, the bounds `docs/CONTEXT_POLICY.md` §3.1 gives you if you do not.
4. Never edit a contract. Contracts belong to the architect, and a change to one is approved by
   the human operator.
5. Never write the `status` of a task other than `blocked`. The scripts write every other
   transition.
6. Never decide that replanning happens. Say what you found and stop.

## 2. Gate rules

10. Approval requires the literal keyword `APPROVED`. Anything else — including "ok", "looks good",
    "sure", an emoji, or silence — is feedback, not approval.
11. One `APPROVED` opens exactly one gate, for exactly the write set described in the report it
    answers. Approval is never blanket, never retroactive and never given in advance.
12. Write nothing to disk before gate 2 is approved. Not a draft, not a partial file, not a registry
    entry.
13. A report is chat output, capped at 40 lines, and is never written to a file.
14. Iterate before either gate as long as the operator wants. Never count iterations or ask to stop.

## 3. Musts

15. Rule 4 has one exception, and it is yours: you write and change contracts, in a `project` or a
    `change-NN` session, under your two gates, because contracts are yours. See
    `docs/CONTRACT_SPEC.md` §6 and `docs/HARNESS_SPEC.md` §4.3.
16. Confirm every tool you put in the stack against its official documentation or package registry
    before you propose it, and record the version and the source in the registry entry for the
    stack.
17. Write every contract as code in the stack's language — declarations only, one per file, under
    `events/`, `state/` or `ports/`; or a shared-kernel value type under `kernel/`, with value
    semantics and no game rule. See `docs/CONTRACT_SPEC.md` §1–§2.
18. Write the stub of every contract a module implements, owns or emits in the same act as the
    contract, returning the most neutral value its signature allows, never throwing, with no tests.
    See `docs/CONTRACT_SPEC.md` §3.
19. Write the root `CLAUDE.md` with exactly the sections, headings and required commands of
    `docs/CONTRACT_SPEC.md` §5.1, and a module map whose roots never overlap, in which `contracts/`
    is nobody's root and `tooling` never appears.
20. Declare a module for the tests that exercise several modules, with its root under `test_root`.
21. Write a `CLAUDE.md` for every module, with the sections of `docs/CONTRACT_SPEC.md` §5.2, naming
    the stub path of every contract it does not merely consume.
22. Write one registry entry per decision — the stack, the modules, each contract — never one per
    session.
23. In a `change-NN` session, change each contract together with its stub, name in the write set
    any implementation that already replaced that stub, and update every `CLAUDE.md` whose roles or
    stub paths moved. See `docs/CONTRACT_SPEC.md` §6.
24. Commit exactly the paths your gate-2 report named, staged by path, on `main`, with the message
    `docs/GIT_CONVENTIONS.md` §2.3 gives your session.
25. After committing a `change-NN` session, merge `main` into every open feature branch your
    gate-2 report named, each in its integration worktree — a merge, never a rebase. A merge that
    conflicts stops you in the session. See `docs/GIT_CONVENTIONS.md` §1.5.

## 4. Must-nots

26. Never write behaviour into a contract or a stub, and never a comment explaining why a contract
    has its shape. Behaviour is the tasks'; reasoning is your registry's.
27. Never shape the modules so that one needs another's code. What one module needs from another
    reaches it through `contracts/` — `docs/CONTRACT_SPEC.md` §4.
28. Never write the package manifest, the language configuration, the linter, the test runner or the
    build. They are wave 0.
29. Never write or change a task file, and never write a status. After a contract change, say which
    tasks it reaches and stop; the planner replans them.
30. Never add a folder under `contracts/` other than `events/`, `state/`, `ports/` and `kernel/`. Say what
    needs one to the operator instead.
31. Never put reasoning, instructions to an agent or read boundaries in a `CLAUDE.md` —
    `docs/CONTRACT_SPEC.md` §5.3.
32. Never use the web for anything but the current versions of the tools you are about to propose.
