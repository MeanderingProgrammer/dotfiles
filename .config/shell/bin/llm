#!/usr/bin/env python

from dataclasses import dataclass
from pathlib import Path

import click
import requests


@dataclass(frozen=True)
class Ollama:
    port: int
    model: str

    @property
    def endpoint(self) -> str:
        return f"http://127.0.0.1:{self.port}"

    def update(self) -> None:
        response = requests.post(
            f"{self.endpoint}/api/pull",
            json=dict(
                model=self.model,
                stream=False,
            ),
        )
        assert response.status_code == 200, "LLM pull failed"
        print(response.json().get("status"))

    def run(self, prompt: list[str]) -> None:
        response = requests.post(
            f"{self.endpoint}/api/generate",
            json=dict(
                model=self.model,
                prompt="\n\n".join(prompt),
                stream=False,
            ),
        )
        assert response.status_code == 200, "LLM generate failed"
        print(response.json().get("response"))


MODEL: Ollama = Ollama(port=11434, model="llama3")


@click.group()
def cli() -> None:
    """
    Interact with llm: ollama serve
    """
    pass


@cli.command()
def update() -> None:
    """
    Update / install the current model
    """
    MODEL.update()


@cli.command()
@click.argument("file", type=Path)
def cr(file: Path) -> None:
    """
    Provides a code review for an input file
    """
    assert file.is_file(), "Input must be a valid file"
    MODEL.run(["Can you provide a code review for the following:", file.read_text()])


@cli.command()
@click.argument("language", type=str)
@click.argument("file", type=Path)
def rewrite(language: str, file: Path) -> None:
    """
    Rewrite the input file to specified langauge
    """
    assert file.is_file(), "Input must be a valid file"
    MODEL.run([f"Can you rewrite the folowing to {language}:", file.read_text()])


@cli.command()
@click.argument("input", type=str)
def prompt(input: str) -> None:
    """
    Passes prompt directly to llm
    """
    MODEL.run([input])


if __name__ == "__main__":
    cli()
