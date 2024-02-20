#!/usr/bin/env python

import os
import subprocess

import click


@click.group()
@click.help_option("-h", "--help")
def cli() -> None:
    "Improves interacting with Git PRs"
    pass


@cli.command()
def push() -> None:
    """push current branch as PR"""
    branch = run("git branch --show-current")
    print(f"Pushing {branch} to origin")
    os.system(f"git push -f origin {branch}")


@cli.command()
@click.argument("id", type=int)
def pull(id: int) -> None:
    """pull PR with ID"""
    branch = f"review-{id}"
    os.system(f'git fetch origin "pull/{id}/head:{branch}"')
    os.system(f"git checkout {branch}")


def run(command: str) -> str:
    result = subprocess.run(command.split(" "), capture_output=True, text=True)
    if result.returncode == 0:
        return result.stdout.strip()
    else:
        raise Exception(f"{command} failed with {result.stderr.strip()}")


if __name__ == "__main__":
    cli()
