# Introduction

Using [yadm](https://yadm.io/) to store all my dotfiles

# Commands

| Command          | Description                      |
|------------------|----------------------------------|
| `yadm bootstrap` | Run bootstrap script             |
| `yadm status`    | Status of yadm git repository    |
| `yadm add -u`    | Stage all modified files at once |
| `yadm push`      | Push commited changes            |

# TODOs

## Upgrade TMUX > 3.4

Currently hard coded to use `3.3a`

This is because search broke as described in [3864](https://github.com/tmux/tmux/issues/3864)

- Cause is commit [43e5e803](https://github.com/tmux/tmux/commit/43e5e80343185e69a1b864fc48095ede0b898180)
- Last working formula version is [defd6d81](https://github.com/Homebrew/homebrew-core/blob/defd6d81be1be58f137bef2fa2dc389100d0125b/Formula/t/tmux.rb)

Post upgrade cleanup:

- Delete `~/.config/tmux/tmux.rb`
- Change path to `tmux` in `~/.config/homebrew/Brewfile`
- Remove pinning of `tmux` in `~/.config/yadm/bootstrap`

## Remove `just` filetype once supported

Once `neovim` supports justfile can remove logic from `~/.config/nvim/lua/mp/config/options.lua`

Already a merged PR for this [25511](https://github.com/neovim/neovim/pull/25511)

# Setup

## Install `curl` (Linux)

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
| `./setup.sh clean` | Deletes the setup script              |

# Optional

## Activate Argcomplete

[Doc](https://github.com/kislyuk/argcomplete?tab=readme-ov-file#installation)

```bash
activate-global-python-argcomplete --user
```

## Install Nix

[Doc](https://nixos.org/)

Uses [Determinate Installer](https://github.com/DeterminateSystems/nix-installer)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```