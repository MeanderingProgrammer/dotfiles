# Introduction

Using [yadm](https://yadm.io/) to store all my dotfiles.

# Setup

Install [homebrew](https://brew.sh/)

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Evaluate [homebrew](https://brew.sh/)

```
MacOS: eval "$(/opt/homebrew/bin/brew shellenv)"
Linux: eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Install [git](https://formulae.brew.sh/formula/git) and [yadm](https://formulae.brew.sh/formula/yadm)

```
brew install git
brew install yadm
```

Set git [known hosts](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)

```
mkdir ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts
```

[Bootstrap](https://yadm.io/docs/bootstrap) dotfiles repo

```
yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
```

# Commands

| Command          | Description                      |
|------------------|----------------------------------|
| `yadm bootstrap` | Run bootstrap script             |
| `yadm status`    | Status of yadm git repository    |
| `yadm add -u`    | Stage all modified files at once |
| `yadm push`      | Push commited changes            |
