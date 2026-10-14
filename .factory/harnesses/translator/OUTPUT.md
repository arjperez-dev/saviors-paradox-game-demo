# translator — output

Nothing in this file is written before gate 2 is approved — not a draft, not a partial file, not a
registry entry.

## The write set

| Path | Artefact | Template | Written when |
|---|---|---|---|
| `.factory/project/VISION.md` | the vision — the canonical project definition | `templates/vision.md` | after gate 2; rewritten in place on a revision, with a preview at gate 2 |
| `.factory/registry/translator/project/round-NN.md` | one registry entry per round that changed a field | `templates/registry-entry.md` | after gate 2, one file per round, numbered on from the last one there |

Two kinds of path, and no third. `templates/clarifying-questions.md` is not in the table because it
is not an artefact: it is a working aid you consult during the work and never copy to disk.

## Frontmatter

**`VISION.md`**:

| Field | Value |
|---|---|
| `project` | the project slug, kebab-case |
| `factory_version` | the value in `.factory/FACTORY_VERSION` at the moment of writing, never the field in `AGENT.md` |
| `created` | today, `YYYY-MM-DD`; a revision sets it again |

**Each registry entry**: `factory_version` alone — `docs/REGISTRY_SPEC.md` §2.4.

## Body structure

### The fifteen fields of `VISION.md`

In this order, under these headings. A field is never dropped: one with no answer is written as an
explicit gap and named again under `Assumptions and open questions`.

| # | Field | What it must carry |
|---|---|---|
| 1 | Vision statement | what this game is, in two or three sentences, as the client would recognise it |
| 2 | Genre | the genre, in the terms the industry uses |
| 3 | Core loop | the cycle the player repeats — what they do, what they get, what makes them do it again |
| 4 | Mechanics | one line per mechanic; what the player does, not how it is implemented |
| 5 | Win / lose conditions | what ends a run, in each direction; `none` if the game cannot be lost, stated deliberately |
| 6 | Content scope | **numbers** — how many levels, enemies, items, screens, weapons, biomes |
| 7 | Reference games | *like X, but Y* — what each reference contributes and what it rejects |
| 8 | Session shape | how long one session runs, whether progress is saved, and what carries between sessions |
| 9 | Input scheme | keyboard, mouse, touch, gamepad, and which of them must be supported |
| 10 | Target platform | where it must run, in the client's terms |
| 11 | Client constraints | what the client requires, recorded as given; never a technical decision derived from it |
| 12 | Non-goals | what this project explicitly will not do, one line each |
| 13 | Success criteria | how the client will judge the finished game |
| 14 | Assumptions and open questions | everything unconfirmed, each marked soft |
| 15 | Risks | what could make this project fail or overrun, in the client's terms |

Fields 6 and 7 carry disproportionate weight. Scope numbers are what let the planner cut a realistic
plan, and reference games are the highest-bandwidth information a client can give. A session that
leaves either vague has not finished the work, whatever the other thirteen say.

### A registry entry

The heading is `# Round NN — <what changed>`, then the five fields of `docs/REGISTRY_SPEC.md` §3.1,
at most fifteen lines. `Evidence` holds what changed in `VISION.md` this round and the question or
answer that forced the change. A round in which nothing changed gets no entry.

## Status transitions you own

None. No task exists when you run — the planner writes them after the architect.

## Git writes you make

One commit on `main` holding exactly the paths above that your gate-2 report named, staged by path,
with the message `docs/GIT_CONVENTIONS.md` §2.3 gives the translator.

## What never goes in

| Not this | Where it belongs |
|---|---|
| the stack, the engine, the language, the modules | the architect |
| a scope cut, the feature list, the tasks, their order | the planner |
| a technical decision derived from a client constraint | nowhere you write; record the constraint and leave the derivation to the architect |
| the clarifying conversation, round by round | nowhere as prose; what changed goes in a registry entry, and the reports stay in chat |
| your own view of whether the idea is a good one | nowhere; the operator decides that |
