#!/usr/bin/env python

import os
import subprocess

import click


@click.command()
@click.option(
    "-p",
    "--previous",
    is_flag=True,
    show_default=True,
    default=False,
    help="Show differences against previous commit.",
)
@click.option(
    "-n",
    "--name",
    is_flag=True,
    show_default=True,
    default=False,
    help="Show file names that have changed.",
)
@click.option(
    "-a",
    "--all",
    is_flag=True,
    show_default=True,
    default=False,
    help="Show lock files.",
)
@click.option(
    "-d",
    "--debug",
    is_flag=True,
    show_default=True,
    default=False,
    help="Debug Mode.",
)
@click.help_option("-h", "--help")
def cli(previous: bool, name: bool, all: bool, debug: bool) -> None:
    """git diff"""
    branch = "HEAD^" if previous else root_branch(["main", "master"])
    options = "--name-only" if name else "--"
    files = "" if all else f'. {exclude("lock.json")} {exclude("lock.yaml")}'
    command = f"git diff {branch} {options} {files}"
    if debug:
        print(command)
    else:
        os.system(command)


def root_branch(roots: list[str]) -> str:
    branches: list[str] = run("git branch")
    branches: list[str] = [branch.split()[-1] for branch in branches]
    result: list[str] = [root for root in roots if root in branches]
    assert len(result) == 1, f"Expected 1 root branch {roots}, found {len(result)}"
    return result[0]


def run(command: str) -> list[str]:
    result = subprocess.run(command.split(), capture_output=True, text=True)
    if result.returncode == 0:
        return result.stdout.strip().splitlines()
    else:
        raise Exception(f"{command} failed due to: {result.stderr.strip()}")


def exclude(suffix: str) -> str:
    return f'":(exclude)*{suffix}"'


if __name__ == "__main__":
    cli()
