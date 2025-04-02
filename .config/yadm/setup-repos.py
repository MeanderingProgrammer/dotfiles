import subprocess
import traceback
from dataclasses import dataclass, field
from functools import cache
from pathlib import Path

import git


@dataclass(frozen=True)
class Repo:
    name: str
    owner: str | None = None
    post_update: list[str] = field(default_factory=list)

    @property
    def ssh(self) -> str:
        owner: str = self.owner or get_user_name()
        return f"git@github.com:{owner}/{self.name}.git"

    def setup(self, root: Path) -> None:
        path: Path = root.joinpath(self.name)
        self.update(path)
        for command in self.post_update:
            Repo.run(path, command)

    def update(self, path: Path) -> None:
        if path.is_dir():
            Repo.update_existing_repo(path)
        else:
            print(f"Cloning {self.ssh} to {path}")
            repo: git.Repo = git.Repo.clone_from(self.ssh, path)
            Repo.update_submodules(repo)

    @staticmethod
    def update_existing_repo(path: Path) -> None:
        repo: git.Repo = git.Repo(path)

        changes: int = len(repo.index.diff(None)) + len(repo.untracked_files)
        if changes > 0:
            raise Exception(f"Found {changes} unstaged changes, not updating {path}")

        local_commit: str = str(repo.head.commit)
        revision: str = f"{repo.remote().name}/{repo.active_branch.name}"
        merged_commit: str = str(repo.rev_parse(revision))
        if local_commit != merged_commit:
            raise Exception(f"Found unmerged commits, not updating {path}")

        print(f"Pulling: {path}")
        repo.remote().pull()
        Repo.update_submodules(repo)

    @staticmethod
    def update_submodules(repo: git.Repo) -> None:
        repo.git.submodule("update", "--init", "--recursive", "--remote", "--rebase")

    @staticmethod
    def run(path: Path, command: str) -> None:
        print(f"Runnning '{command}' in '{path}'")
        result = subprocess.run(command.split(), cwd=path)
        assert result.returncode == 0


@cache
def get_user_name() -> str:
    return str(git.GitConfigParser().get_value("user", "name"))


@dataclass(frozen=True)
class Stats:
    success: list[str] = field(default_factory=list)
    failed: list[str] = field(default_factory=list)

    def summary(self) -> None:
        self.print(f"Successes: {len(self.success)}", 32)
        for name in self.success:
            self.print(f"  - {name}", 32)

        self.print(f"Failures: {len(self.failed)}", 31)
        for name in self.failed:
            self.print(f"  - {name}", 31)

    def print(self, text: str, color: int) -> None:
        print(f"\033[{color}m{text}\033[0m")


@dataclass(frozen=True)
class RepoRoot:
    root: Path
    repos: list[Repo]

    def setup(self, stats: Stats) -> None:
        if not self.root.is_dir():
            print(f"Creating: {self.root}")
            self.root.mkdir(parents=True)
        for repo in self.repos:
            try:
                repo.setup(self.root)
                stats.success.append(repo.name)
            except:
                traceback.print_exc()
                stats.failed.append(repo.name)


def main() -> None:
    repo_roots: list[RepoRoot] = []

    document_root = RepoRoot(
        root=Path.home().joinpath("Documents"),
        repos=[
            Repo(name="notes"),
            Repo(name="pass"),
        ],
    )
    repo_roots.append(document_root)

    personal_root = RepoRoot(
        root=Path.home().joinpath("dev/repos/personal"),
        repos=[
            Repo(name="advent-of-code"),
            Repo(name="chess"),
            Repo(name="cli", post_update=["just install"]),
            Repo(name="dashboard.nvim"),
            Repo(name="debug-it"),
            Repo(name="harpoon-core.nvim"),
            Repo(name="learning"),
            Repo(name="pass-yank", post_update=["just install"]),
            Repo(name="py-requirements.nvim"),
            Repo(name="render-markdown.nvim"),
            Repo(name="resume"),
            Repo(name="small-apps"),
            Repo(name="stashpad.nvim"),
        ],
    )
    repo_roots.append(personal_root)

    open_source_root = RepoRoot(
        root=Path.home().joinpath("dev/repos/open-source"),
        repos=[
            Repo(owner="kdheepak", name="panvimdoc"),
        ],
    )
    repo_roots.append(open_source_root)

    stats = Stats()
    for repo_root in repo_roots:
        repo_root.setup(stats)
    stats.summary()


if __name__ == "__main__":
    main()
