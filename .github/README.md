# Introduction

Using [yadm](https://yadm.io/) to store all my dotfiles.

# Commands

| Command          | Description                      |
|------------------|----------------------------------|
| `yadm bootstrap` | Run bootstrap script             |
| `yadm status`    | Status of yadm git repository    |
| `yadm add -u`    | Stage all modified files at once |
| `yadm push`      | Push commited changes            |

# Setup

## Install Linux Requirements

<details>
<summary>Command</summary>

```bash
sudo apt install \
  curl git \
  wget make gcc llvm wl-clipboard \
  build-essential bubblewrap xz-utils \
  libbz2-dev libffi-dev liblzma-dev \
  libncursesw5-dev libreadline-dev \
  libsqlite3-dev libssl-dev \
  libxml2-dev libxmlsec1-dev \
  tk-dev zlib1g-dev
```

</details>

## [Homebrew](https://brew.sh/)

<details>
<summary>Install</summary>

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

</details>

<details>
<summary>Evaluate</summary>

```bash
if [[ $(uname -s) == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $(uname -s) == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Unhandled system type $(uname -s)"
fi
```

</details>

## [Git](https://git-scm.com/)

<details>
<summary>Install</summary>

[Formula](https://formulae.brew.sh/formula/git)

```bash
brew install git
```

</details>

<details>
<summary>Set Known Hosts</summary>

[Doc](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)

```bash
mkdir ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan github.com > ~/.ssh/known_hosts
```

</details>

<details>
<summary>Generate SSH Key</summary>

[Doc](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```bash
ssh-keygen -t ed25519 -C "meanderingprogrammer@gmail.com"
eval "$(ssh-agent -s)"
```

</details>

<details>
<summary>Add SSH Key to GitHub</summary>

[Doc](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

```bash
if [[ $(uname -s) == "Darwin" ]]; then
    cat ~/.ssh/id_ed25519.pub | pbcopy
elif [[ $(uname -s) == "Linux" ]]; then
    cat ~/.ssh/id_ed25519.pub | clip.exe
else
    echo "Unhandled system type $(uname -s)"
fi
```

</details>

## [yadm](https://yadm.io/)

<details>
<summary>Install</summary>

[Formula](https://formulae.brew.sh/formula/yadm)

```bash
brew install yadm
```

</details>

<details>
<summary>Bootstrap</summary>

[Doc](https://yadm.io/docs/bootstrap)

```bash
yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
```

- Python installation may fail see [ISSUE-2823](https://github.com/pyenv/pyenv/issues/2823)
- Solution: `brew unlink pkg-config`

</details>

## Miscellaneous

<details>
<summary>Use Z Shell in WSL2</summary>

[Shell](https://www.zsh.org/)

```bash
sudo apt install zsh
chsh -s $(which zsh)
```

</details>

<details>
<summary>Activate Argcomplete</summary>

[Doc](https://github.com/kislyuk/argcomplete?tab=readme-ov-file#installation)

```bash
activate-global-python-argcomplete --user
```

</details>

## [Nix](https://nixos.org/)

<details>
<summary>Install</summary>

Uses [Determinate Installer](https://github.com/DeterminateSystems/nix-installer)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

</details>
