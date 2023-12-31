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
 WSL2: eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

WSL2 requirements

```
sudo apt install make gcc bubblewrap wl-clipboard \
  wget curl llvm xz-utils tk-dev libssl-dev zlib1g-dev libbz2-dev \
  build-essential libreadline-dev libsqlite3-dev libffi-dev \
  libncursesw5-dev libxml2-dev libxmlsec1-dev liblzma-dev
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

[Generate](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) ssh key

```
ssh-keygen -t ed25519 -C "meanderingprogrammer@gmail.com"
eval "$(ssh-agent -s)"
```

[Add](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) ssh key to github

```
MacOS: ~/.ssh/id_ed25519.pub | pbcopy
 WSL2: ~/.ssh/id_ed25519.pub | clip.exe
```

[Bootstrap](https://yadm.io/docs/bootstrap) dotfiles repo

```
yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
```

* Python installation may fail [2823](https://github.com/pyenv/pyenv/issues/2823): `brew unlink pkg-config`

Use [zshell](https://www.zsh.org/) for WSL2

```
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
