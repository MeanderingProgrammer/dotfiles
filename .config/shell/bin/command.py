import os
import subprocess


def run(command: str) -> str:
    result = subprocess.run(command.split(" "), capture_output=True, text=True)
    if result.returncode == 0:
        return result.stdout.strip()
    else:
        raise Exception(f"{command} failed with {result.stderr.strip()}")


def execute(command: str) -> None:
    os.system(command)
