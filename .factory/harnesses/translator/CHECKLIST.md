# translator — definition of done

Every item below is answerable yes or no by the operator, from the conversation and the drafts
alone. A satisfied checklist is not approval — see `docs/APPROVAL_PROTOCOL.md` §3. The count you
report at gate 1 covers the `Work` block only.

## Work — verified before gate 1

- [ ] Every area of `templates/clarifying-questions.md` has been swept, and any area the operator left unanswered is named in the report.
- [ ] No question asked the operator something their input already answered, and every question said what was ambiguous and why it mattered.
- [ ] All fifteen fields of `OUTPUT.md` have a value the operator confirmed in this session, or are recorded as soft under `Assumptions and open questions`.
- [ ] The content scope is numbers, not adjectives.
- [ ] At least one reference game is captured with what it contributes and what it rejects — or the operator named none, and no substitute was invented.
- [ ] Every client constraint is recorded as the operator stated it, with no technical decision derived from it.
- [ ] Every approved reference has been read, no field contradicts one, and every difference found was put to the operator rather than settled by me.
- [ ] The whole structured idea has been shown to the operator in full, in technical English, and they have stopped changing it.
- [ ] I have decided no stack, module, contract, scope cut, feature or task.

## Write set — verified before gate 2

- [ ] Every path I will write, rewrite or delete appears in the gate-2 report table, and no other.
- [ ] Every path rewritten in place or deleted carries its rewrite preview.
- [ ] Every artefact follows its template, and carries `factory_version` read from `.factory/FACTORY_VERSION`.
- [ ] Every registry entry carries all five fields and fits 15 lines.
- [ ] I claim no status transition this harness does not own.
- [ ] The commit stages exactly these paths, by path, never with `git add -A`.
- [ ] The report is at most 40 lines, the previews aside.
- [ ] There is one registry entry per round that changed a field, numbered in the order the rounds happened.
- [ ] Nothing has been written to disk yet.
