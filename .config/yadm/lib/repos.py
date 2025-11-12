import subprocess
import traceback
from dataclasses import dataclass, field
from pathlib import Path

import git


@dataclass(frozen=True)
class Repo:
    name: str
    owner: str = str(git.GitConfigParser().get_value("user", "name"))
    after: list[str] = field(default_factory=list)

    @property
    def ssh(self) -> str:
        return f"git@github.com:{self.owner}/{self.name}.git"

    def setup(self, directory: Path) -> None:
        path: Path = directory.joinpath(self.name)
        self.update(path)
        for command in self.after:
            print(f"runnning '{command}' in '{path}'")
            result = subprocess.run(command.split(), cwd=path)
            assert result.returncode == 0

    def update(self, path: Path) -> None:
        if path.is_dir():
            Repo.update_existing(path)
        else:
            print(f"cloning {self.ssh} to {path}")
            repo: git.Repo = git.Repo.clone_from(self.ssh, path)
            Repo.update_submodules(repo)

    @staticmethod
    def update_existing(path: Path) -> None:
        repo: git.Repo = git.Repo(path)

        changes: int = len(repo.index.diff(None)) + len(repo.untracked_files)
        if changes > 0:
            raise Exception(f"found {changes} unstaged changes, skipping {path}")

        local_commit: str = str(repo.head.commit)
        revision: str = f"{repo.remote().name}/{repo.active_branch.name}"
        merged_commit: str = str(repo.rev_parse(revision))
        if local_commit != merged_commit:
            raise Exception(f"found unmerged commits, skipping {path}")

        print(f"pulling: {path}")
        repo.remote().pull()
        Repo.update_submodules(repo)

    @staticmethod
    def update_submodules(repo: git.Repo) -> None:
        repo.git.submodule("update", "--init", "--recursive", "--remote", "--rebase")


@dataclass(frozen=True)
class Root:
    directory: Path
    repos: list[Repo]

    def __post_init__(self) -> None:
        if not self.directory.is_dir():
            assert not self.directory.exists()
            print(f"creating: {self.directory}")
            self.directory.mkdir(parents=True)


@dataclass(frozen=True)
class Stats:
    success: list[str] = field(default_factory=list)
    failed: list[str] = field(default_factory=list)

    def add(self, name: str, success: bool) -> None:
        info = self.success if success else self.failed
        info.append(name)

    def summary(self) -> str:
        lines: list[str] = []
        lines.append(Stats.line(f"successes: {len(self.success)}", 32))
        for name in self.success:
            lines.append(Stats.line(f"  - {name}", 32))
        lines.append(Stats.line(f"failures: {len(self.failed)}", 31))
        for name in self.failed:
            lines.append(Stats.line(f"  - {name}", 31))
        return "\n".join(lines)

    @staticmethod
    def line(text: str, color: int) -> str:
        return f"\033[{color}m{text}\033[0m"


def main() -> None:
    document = Root(
        directory=Path.home().joinpath("Documents"),
        repos=[
            Repo(name="notes"),
            Repo(name="pass"),
        ],
    )
    personal = Root(
        directory=Path.home().joinpath("dev/repos/personal"),
        repos=[
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
        ],
    )
    tools = Root(
        directory=Path.home().joinpath("dev/repos/tools"),
        repos=[
            Repo(owner="kdheepak", name="panvimdoc"),
        ],
    )

    roots: list[Root] = [
        document,
        personal,
        tools,
    ]
    print(setup(roots).summary())


def setup(roots: list[Root]) -> Stats:
    stats = Stats()
    for root in roots:
        for repo in root.repos:
            success = True
            try:
                repo.setup(root.directory)
            except Exception:
                traceback.print_exc()
                success = False
            stats.add(repo.name, success)
    return stats


if __name__ == "__main__":
    main()
