# Introduction

Using [yadm](https://yadm.io/) to store all my dotfiles.

# Setup

Install and evaluate Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

MacOS

```
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Linux

```
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Install yadm then bootstrap the repo

```
brew install yadm
yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
```

# Commands

| Command          | Description                      |
|------------------|----------------------------------|
| `yadm bootstrap` | Run bootstrap script             |
| `yadm status`    | Status of yadm git repository    |
| `yadm add -u`    | Stage all modified files at once |
| `yadm push`      | Push commited changes            |
