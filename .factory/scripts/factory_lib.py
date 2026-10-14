"""Shared helpers for the factory scripts.

Every script lives in <main>/.factory/scripts/ and is always run from there, so the main checkout
is found from this file's own path, never from the working directory or an environment variable.

Standard library only. Python 3.13 or newer.
"""

from __future__ import annotations

import datetime
import json
import os
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

MIN_PYTHON = (3, 13)

STATUSES = ("pending", "in_progress", "implemented", "integrated", "blocked")

# The models of the unattended seats. The model assignment is part of the factory contract.
SONNET = "claude-sonnet-5"
OPUS = "claude-opus-5-5"

# What no unattended session may run, whatever its allowed tools say. Pushing, pulling and
# fetching are the human's; rewriting history is nobody's; `gh` opens pull requests.
DISALLOWED_TOOLS = [
    "Bash(git push:*)",
    "Bash(git pull:*)",
    "Bash(git fetch:*)",
    "Bash(git rebase:*)",
    "Bash(git reset --hard:*)",
    "Bash(gh:*)",
    "WebFetch",
    "WebSearch",
]


class FactoryError(Exception):
    """A condition the script cannot proceed past. The message says what and where."""


# --------------------------------------------------------------------------------------------
# Environment


def require_python() -> None:
    if sys.version_info < MIN_PYTHON:
        found = ".".join(str(n) for n in sys.version_info[:3])
        sys.exit(f"The factory scripts need Python 3.13 or newer; this is Python {found}.")


def main_checkout() -> Path:
    """The repository's own directory: <main>/.factory/scripts/<this file>."""
    return Path(__file__).resolve().parents[2]


def task_worktree(main: Path, task_id: str) -> Path:
    return main.parent / f"wt-{task_id}"


def feature_worktree(main: Path, feature: str) -> Path:
    return main.parent / f"wt-feat-{feature}"


def logs_dir(main: Path) -> Path:
    path = main.parent / "logs"
    path.mkdir(exist_ok=True)
    return path


def factory_version(main: Path) -> str:
    return (main / ".factory" / "FACTORY_VERSION").read_text(encoding="utf-8").strip()


def today() -> str:
    return datetime.date.today().isoformat()


def claude_command() -> list[str]:
    """The Claude Code executable. FACTORY_CLAUDE overrides it, as a JSON list, for the tests."""
    override = os.environ.get("FACTORY_CLAUDE")
    if override:
        return json.loads(override)
    found = shutil.which("claude")
    if not found:
        raise FactoryError("Claude Code is not on PATH: `claude` was not found.")
    return [found]


# --------------------------------------------------------------------------------------------
# Running things


def git(*args: str, cwd: Path, check: bool = True) -> str:
    result = subprocess.run(
        ["git", *args], cwd=cwd, capture_output=True, text=True, encoding="utf-8"
    )
    if check and result.returncode != 0:
        raise FactoryError(f"git {' '.join(args)} failed in {cwd}:\n{result.stderr.strip()}")
    return result.stdout


def branch_exists(main: Path, branch: str) -> bool:
    result = subprocess.run(
        ["git", "rev-parse", "--verify", "--quiet", f"refs/heads/{branch}"],
        cwd=main,
        capture_output=True,
    )
    return result.returncode == 0


def run_command(command: str, cwd: Path, log: Path | None = None) -> int:
    """Run one of the CLAUDE.md commands, exactly as typed there, through the shell."""
    if log is None:
        return subprocess.run(command, cwd=cwd, shell=True).returncode
    with log.open("a", encoding="utf-8") as out:
        out.write(f"$ {command}\n")
        out.flush()
        return subprocess.run(command, cwd=cwd, shell=True, stdout=out, stderr=out).returncode


# --------------------------------------------------------------------------------------------
# Markdown: frontmatter, sections, tables

_FRONTMATTER = re.compile(r"\A---\r?\n(.*?)\r?\n---\r?\n", re.DOTALL)


def split_frontmatter(text: str) -> tuple[str, str]:
    match = _FRONTMATTER.match(text)
    if not match:
        raise FactoryError("the file does not open with a --- frontmatter block")
    return match.group(1), text[match.end():]


def _scalar(value: str):
    value = value.strip()
    if len(value) >= 2 and value[0] == value[-1] and value[0] in "'\"":
        return value[1:-1]
    if value.startswith("[") and value.endswith("]"):
        inner = value[1:-1].strip()
        return [] if not inner else [_scalar(item) for item in inner.split(",")]
    return value


def parse_frontmatter(block: str) -> dict:
    """The subset of YAML the factory writes: scalars, flow lists, block lists of scalars, and
    block lists of one-level mappings (shared_file_notes). Nothing else is needed or accepted."""
    data: dict = {}
    key = None
    for raw in block.splitlines():
        if not raw.strip() or raw.lstrip().startswith("#"):
            continue
        if not raw[0].isspace() and not raw.startswith("-"):
            name, sep, rest = raw.partition(":")
            if not sep:
                raise FactoryError(f"frontmatter line is not `key: value`: {raw!r}")
            key = name.strip()
            data[key] = _scalar(rest) if rest.strip() else []
            continue
        if key is None or not isinstance(data[key], list):
            raise FactoryError(f"frontmatter line belongs to no list: {raw!r}")
        item = raw.strip()
        if item.startswith("- "):
            content = item[2:]
            name, sep, rest = content.partition(":")
            if sep and re.fullmatch(r"[A-Za-z_]+", name.strip()) and rest.startswith(" "):
                data[key].append({name.strip(): _scalar(rest)})
            else:
                data[key].append(_scalar(content))
        else:
            name, sep, rest = item.partition(":")
            if not sep or not data[key] or not isinstance(data[key][-1], dict):
                raise FactoryError(f"frontmatter line belongs to no list item: {raw!r}")
            data[key][-1][name.strip()] = _scalar(rest)
    return data


def section(body: str, heading: str) -> str | None:
    """The text under `## <heading>`, up to the next `## ` heading. None when absent."""
    lines = body.splitlines()
    for index, line in enumerate(lines):
        if line.strip() == f"## {heading}":
            collected = []
            for following in lines[index + 1:]:
                if following.startswith("## "):
                    break
                collected.append(following)
            return "\n".join(collected)
    return None


def _cell(value: str) -> str:
    value = value.strip()
    if len(value) >= 2 and value.startswith("`") and value.endswith("`"):
        return value[1:-1]
    return value


def parse_table(text: str) -> list[dict]:
    """The first markdown table in `text`, as one dict per row keyed by the header."""
    rows = [line.strip() for line in text.splitlines() if line.strip().startswith("|")]
    if len(rows) < 2:
        return []
    header = [_cell(c) for c in rows[0].strip("|").split("|")]
    table = []
    for row in rows[2:]:
        cells = [_cell(c) for c in row.strip("|").split("|")]
        table.append(dict(zip(header, cells)))
    return table


# --------------------------------------------------------------------------------------------
# The plan


class Task:
    def __init__(self, path: Path):
        self.path = path
        text = path.read_text(encoding="utf-8")
        block, self.body = split_frontmatter(text)
        self.meta = parse_frontmatter(block)
        for field in ("id", "feature", "module", "status", "task_type"):
            if not self.meta.get(field):
                raise FactoryError(f"{path}: frontmatter has no `{field}`")
        if self.meta["status"] not in STATUSES:
            raise FactoryError(f"{path}: unknown status `{self.meta['status']}`")
        heading = re.search(r"^# (\S+) — (.+)$", self.body, re.MULTILINE)
        self.title = heading.group(2).strip() if heading else ""

    @property
    def id(self) -> str:
        return self.meta["id"]

    @property
    def feature(self) -> str:
        return self.meta["feature"]

    @property
    def module(self) -> str:
        return self.meta["module"]

    @property
    def status(self) -> str:
        return self.meta["status"]

    @property
    def priority(self) -> str:
        return self.meta.get("priority", "normal")

    @property
    def depends_on_task(self) -> list:
        value = self.meta.get("depends_on_task", [])
        return value if isinstance(value, list) else [value]

    @property
    def files(self) -> list:
        value = self.meta.get("files", [])
        return value if isinstance(value, list) else [value]


def tasks_dir(main: Path) -> Path:
    return main / ".factory" / "tasks"


def load_plan(main: Path) -> dict[str, Task]:
    plan = {}
    root = tasks_dir(main)
    if not root.is_dir():
        return plan
    for path in sorted(root.glob("*/*.md")):
        task = Task(path)
        plan[task.id] = task
    return plan


def find_task(main: Path, task_id: str) -> Task:
    matches = list(tasks_dir(main).glob(f"*/{task_id}.md"))
    if len(matches) != 1:
        raise FactoryError(f"no single task file for {task_id} under .factory/tasks/")
    return Task(matches[0])


def set_status(task: Task, expected: tuple[str, ...], new: str) -> None:
    """Change the `status` line of one task file and nothing else, if it holds an expected value.

    The file is re-read first, so a status another writer changed meanwhile is never overwritten.
    """
    text = task.path.read_text(encoding="utf-8")
    block, _ = split_frontmatter(text)
    current = parse_frontmatter(block).get("status")
    if current not in expected:
        raise FactoryError(
            f"{task.id} is `{current}`, not {' or '.join(expected)}; its status was left alone"
        )
    updated, count = re.subn(
        rf"^status: *{re.escape(current)} *$", f"status: {new}", text, count=1, flags=re.MULTILINE
    )
    if count != 1:
        raise FactoryError(f"{task.path}: no `status:` line to change")
    temporary = task.path.with_name(f".{task.path.name}.tmp")
    temporary.write_text(updated, encoding="utf-8", newline="")
    os.replace(temporary, task.path)
    task.meta["status"] = new


def integrated_on(main: Path, branch: str, task_id: str) -> bool:
    """Whether `branch` holds the merge commit that delivered `task_id`, found by its footer."""
    found = git(
        "log", branch, "--merges", "--format=%H", f"--grep=^Task: {task_id}$",
        cwd=main, check=False,
    )
    return bool(found.strip())


# --------------------------------------------------------------------------------------------
# CLAUDE.md


class ProjectFacts:
    def __init__(self, root: Path):
        path = root / "CLAUDE.md"
        if not path.is_file():
            raise FactoryError(f"{path} does not exist; the architect writes it")
        text = path.read_text(encoding="utf-8")
        self.commands = {
            row["Command"]: row["Value"] for row in parse_table(section(text, "Commands") or "")
        }
        self.paths = {row["Path"]: row["Value"] for row in parse_table(section(text, "Paths") or "")}
        self.modules = {}
        for row in parse_table(section(text, "Modules") or ""):
            roots = [r.strip().strip("`") for r in row["Roots"].split(",") if r.strip()]
            self.modules[row["Module"]] = roots

    def command(self, name: str) -> str:
        value = self.commands.get(name, "")
        if not value or value in ("—", "-"):
            raise FactoryError(f"CLAUDE.md has no `{name}` in its Commands table")
        return value


def normalise(path: str) -> str:
    path = path.strip().replace("\\", "/")
    while path.startswith("./"):
        path = path[2:]
    return path


def under(path: str, root: str) -> bool:
    root = normalise(root)
    if not root.endswith("/"):
        root += "/"
    return normalise(path).startswith(root)


# --------------------------------------------------------------------------------------------
# Blocked files


def write_blocked(
    main: Path,
    task: Task,
    agent: str,
    needs: str,
    asked_to: str,
    because: str,
    needs_text: str,
    state: str,
) -> Path:
    """Write a blocked file beside any earlier one for the same task, never over it."""
    folder = main / ".factory" / "blocked" / task.feature
    folder.mkdir(parents=True, exist_ok=True)
    path = folder / f"{task.id}.md"
    counter = 2
    while path.exists():
        path = folder / f"{task.id}-{counter:02d}.md"
        counter += 1
    path.write_text(
        "---\n"
        f"task_id: {task.id}\n"
        f"needs: {needs}\n"
        f"agent: {agent}\n"
        f"factory_version: {factory_version(main)}\n"
        f"created: {today()}\n"
        "---\n\n"
        f"## Asked to\n{asked_to}\n\n"
        f"## Blocked because\n{because}\n\n"
        f"## Needs\n{needs_text}\n\n"
        f"## State of the work\n{state}\n",
        encoding="utf-8",
        newline="\n",
    )
    return path


# --------------------------------------------------------------------------------------------
# The lock


class Lock:
    """An exclusive lock held by the operating system on `.factory/locks/<name>.lock`.

    `fcntl` on Linux and macOS, `msvcrt` on Windows — Git for Windows ships no `flock`. The
    operating system releases the lock when the process that holds it exits, however it exits,
    so a crashed integration never leaves a lock behind for a person to delete.
    """

    def __init__(self, main: Path, name: str):
        folder = main / ".factory" / "locks"
        folder.mkdir(parents=True, exist_ok=True)
        self.path = folder / f"{name}.lock"
        self._file = None

    def _try(self) -> bool:
        if os.name == "nt":
            import msvcrt

            try:
                self._file.seek(0)
                msvcrt.locking(self._file.fileno(), msvcrt.LK_NBLCK, 1)
                return True
            except OSError:
                return False
        import fcntl

        try:
            fcntl.flock(self._file.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
            return True
        except OSError:
            return False

    def acquire(self, wait: bool = True, poll: float = 1.0) -> bool:
        self._file = open(self.path, "a+", encoding="utf-8")
        while not self._try():
            if not wait:
                self._file.close()
                self._file = None
                return False
            time.sleep(poll)
        return True

    def release(self) -> None:
        if self._file is None:
            return
        if os.name == "nt":
            import msvcrt

            self._file.seek(0)
            msvcrt.locking(self._file.fileno(), msvcrt.LK_UNLCK, 1)
        else:
            import fcntl

            fcntl.flock(self._file.fileno(), fcntl.LOCK_UN)
        self._file.close()
        self._file = None

    def __enter__(self):
        self.acquire()
        return self

    def __exit__(self, *exc):
        self.release()
