# Introduction

Using [yadm](https://yadm.io/) to store all my dotfiles

# Commands

| Command          | Description                      |
|------------------|----------------------------------|
| `yadm bootstrap` | Run bootstrap script             |
| `yadm status`    | Status of yadm git repository    |
| `yadm add -u`    | Stage all modified files at once |
| `yadm push`      | Push commited changes            |

# Setup

## Linux - Install `curl`

```bash
sudo apt install curl
```

## Download Setup Script

```bash
curl -fsSL https://raw.githubusercontent.com/MeanderingProgrammer/dotfiles/main/docs/setup.sh -o setup.sh && chmod +x setup.sh
```

## Execute Script Commands in Order

| Command            | Description                           |
|--------------------|---------------------------------------|
| `./setup.sh deps`  | Installs dependencies                 |
| `./setup.sh shell` | Changes [shell](https://www.zsh.org/) |
| `./setup.sh brew`  | Installs [homebrew](https://brew.sh/) |
| `./setup.sh git`   | Installs [git](https://git-scm.com/)  |
| `./setup.sh yadm`  | Installs [yadm](https://yadm.io/)     |
| `./setup.sh limit` | Increases system limits               |
| `./setup.sh clean` | Deletes the setup script              |

# Settings

## MacOS - Developer Tools

System Settings -> Privacy & Security -> Developer Tools

- Add terminal emulators to the list
- Removes overhead when running executables
