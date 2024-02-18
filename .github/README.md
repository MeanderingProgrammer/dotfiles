# Introduction

Using [yadm](https://yadm.io/) to store all my dotfiles.

# Setup

## Install [homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Evaluate [homebrew](https://brew.sh/)

### MacOS

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### WSL2

```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

## WSL2 requirements

```
sudo apt install \
  wget curl make gcc llvm wl-clipboard \
  build-essential bubblewrap xz-utils \
  libbz2-dev libffi-dev liblzma-dev \
  libncursesw5-dev libreadline-dev \
  libsqlite3-dev libssl-dev \
  libxml2-dev libxmlsec1-dev \
  tk-dev zlib1g-dev
```

## Install [git](https://formulae.brew.sh/formula/git) and [yadm](https://formulae.brew.sh/formula/yadm)

```bash
brew install git yadm
```

## Set git known hosts

[Doc](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)

```bash
mkdir ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts
```

## Generate SSH key

[Doc](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```bash
ssh-keygen -t ed25519 -C "meanderingprogrammer@gmail.com"
eval "$(ssh-agent -s)"
```

## Add SSH key to github

[Doc](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

### MacOS

```bash
cat ~/.ssh/id_ed25519.pub | pbcopy
```

### WSL2

```bash
cat ~/.ssh/id_ed25519.pub | clip.exe
```

## [Bootstrap](https://yadm.io/docs/bootstrap) dotfiles repo

```bash
yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
```

- Python installation may fail see [ISSUE-2823](https://github.com/pyenv/pyenv/issues/2823)
- Solution: `brew unlink pkg-config`

## Use [zshell](https://www.zsh.org/) for WSL2

```bash
sudo apt install zsh
chsh -s $(which zsh)
```

# Commands

| Command          | Description                      |
|------------------|----------------------------------|
| `yadm bootstrap` | Run bootstrap script             |
| `yadm status`    | Status of yadm git repository    |
| `yadm add -u`    | Stage all modified files at once |
| `yadm push`      | Push commited changes            |
