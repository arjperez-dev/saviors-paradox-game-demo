# tester — process

One run, inside one implementer session, from the implementer's request to your last write. The
steps are numbered continuously and are not comparable with the steps of another harness.

## Session start

1. The implementer that started you names: the task id, the path of its task file in the main
   checkout, the main checkout, and its worktree. You have nothing else.
2. Read the task file whole.
3. Compare the `factory_version` field in `AGENT.md` against `.factory/FACTORY_VERSION`, and keep the
   answer for your report to the implementer. It never blocks. See `docs/HARNESS_SPEC.md` §8.1.

## The work

4. Read every path in the task's `references`, and every approved piece of
   `.factory/project/reference/08-engineering/`, `checklist.md` included, in the main checkout. Then read each `Test file` the acceptance criteria name, in the worktree,
   and the code it exercises.
5. For each criterion: does its test, under its `Test name`, assert what the `Assertion` states? A
   test that references the right symbols and asserts something else is the case nothing mechanical
   catches — `docs/TASK_FILE_SPEC.md` §5.2. Where the criterion names a reference, does the test
   assert the value as the reference gives it?
6. Name what the tests do not reach: a criterion with no real assertion, a branch of the
   `Implementation` no test enters, an input the `Assertion` implies and no test tries. You may run
   `test_command` to see what the tests do.
7. Hold the task's code and tests against every item of the checklist, and against every cited
   reference: a value, a pose, an order of frames the code gets wrong is a gap, and the reference
   wins. A reference ambiguous on something the tests depend on is not yours to settle.
8. Report to the implementer, as a list: criterion or checklist item, file, what is missing. Only
   gaps in this task's criteria, and checklist items its code fails, are its to close; say which the
   others are, for your registry entry.
9. If the task file has a `Manual check`, write the steps a person must follow to judge it — only
   what no automated test can see, each step naming what it answers.

## Write

In the main checkout, in this order:

10. The manual test, when the task file has a `Manual check`: from `templates/manual-test.md`, at
    `.factory/manual-tests/<feature>/<id>.md`, or `<id>-02.md` beside an earlier run's.
11. Your registry entry, from `templates/registry-entry.md`, at
    `.factory/registry/tester/<feature>/<id>.md`, or `<id>-02.md` beside an earlier run's.

## Session end

12. Return to the implementer: your findings, the paths you wrote, and — if step 3 found one — the
    harness version mismatch.

## If you must block

13. Tell the implementer, in your reply, why you cannot proceed and what would unblock it — in the
    terms of a blocked file's `Blocked because` and `Needs`. Write nothing. The implementer decides
    whether it stops the task — `docs/APPROVAL_PROTOCOL.md` §5.1.
