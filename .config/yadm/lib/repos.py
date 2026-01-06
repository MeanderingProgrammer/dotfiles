import subprocess
import traceback
from dataclasses import dataclass, field
from pathlib import Path

import git

type Root = tuple[Path, *tuple[Repo, ...]]


@dataclass(frozen=True)
class Repo:
    name: str
    owner: str = str(git.GitConfigParser().get_value("user", "name"))
    after: list[str] = field(default_factory=list)

    @property
    def ssh(self) -> str:
        return f"git@github.com:{self.owner}/{self.name}.git"

    def setup(self, root: Path) -> None:
        if not root.is_dir():
            assert not root.exists()
            print(f"creating: {root}")
            root.mkdir(parents=True)
        path = root / self.name
        self.update(path)
        for cmd in self.after:
            print(f"runnning '{cmd}' in '{path}'")
            result = subprocess.run(cmd.split(), cwd=path)
            assert result.returncode == 0

    def update(self, path: Path) -> None:
        if path.is_dir():
            repo = git.Repo(path)

            changes = len(repo.index.diff(None)) + len(repo.untracked_files)
            if changes > 0:
                raise Exception(f"skipping {path}: {changes} unstaged changes")

            local_commit = str(repo.head.commit)
            revision = f"{repo.remote().name}/{repo.active_branch.name}"
            merged_commit = str(repo.rev_parse(revision))
            if local_commit != merged_commit:
                raise Exception(f"skipping {path}: unmerged commits")

            print(f"pulling: {path}")
            repo.remote().pull()
        else:
            print(f"cloning: {self.ssh} -> {path}")
            repo = git.Repo.clone_from(self.ssh, path)

        repo.git.submodule("update", "--init", "--recursive", "--remote", "--rebase")


@dataclass(frozen=True)
class Stats:
    success: list[str] = field(default_factory=list)
    failed: list[str] = field(default_factory=list)

    def add(self, name: str, success: bool) -> None:
        info = self.success if success else self.failed
        info.append(name)

    def summary(self) -> None:
        print(Stats.color(32, Stats.group("successes", self.success)))
        print(Stats.color(31, Stats.group("failures", self.failed)))

    @staticmethod
    def group(label: str, values: list[str]) -> list[str]:
        return [f"{label}: {len(values)}"] + [f"  - {value}" for value in values]

    @staticmethod
    def color(color: int, lines: list[str]) -> str:
        lines[0] = f"\033[{color}m" + lines[0]
        lines[-1] = lines[-1] + "\033[0m"
        return "\n".join(lines)


def main() -> None:
    document = (
        Path.home() / "Documents",
        Repo(name="notes"),
        Repo(name="pass"),
    )
    personal = (
        Path.home() / "dev/repos/personal",
        Repo(name="advent-of-code"),
        Repo(name="chess"),
        Repo(name="cli", after=["just install"]),
        Repo(name="dashboard.nvim"),
        Repo(name="debug-it"),
        Repo(name="harpoon-core.nvim"),
        Repo(name="learning"),
        Repo(name="pass-yank", after=["just install"]),
        Repo(name="py-requirements.nvim"),
        Repo(name="render-markdown.nvim"),
        Repo(name="resume"),
        Repo(name="scripts"),
        Repo(name="small-apps"),
        Repo(name="stashpad.nvim"),
        Repo(name="treesitter-modules.nvim"),
        Repo(name="yadm-rs"),
    )
    tools = (
        Path.home() / "dev/repos/tools",
        Repo(owner="kdheepak", name="panvimdoc"),
    )

    roots: list[Root] = [
        document,
        personal,
        tools,
    ]
    setup(roots).summary()


def setup(roots: list[Root]) -> Stats:
    stats = Stats()
    for root, *repos in roots:
        for repo in repos:
            try:
                repo.setup(root)
                success = True
            except Exception:
                traceback.print_exc()
                success = False
            stats.add(repo.name, success)
    return stats


if __name__ == "__main__":
    main()
