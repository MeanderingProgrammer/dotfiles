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

## Install `curl` (Linux)

```bash
sudo apt install curl
```

## Download Setup Script

```bash
curl -fsSL https://raw.githubusercontent.com/MeanderingProgrammer/dotfiles/main/.github/setup.sh -o setup.sh && chmod +x setup.sh
```

## Execute Script Commands in Order

| Command            | Description                           |
|--------------------|---------------------------------------|
| `./setup.sh deps`  | Installs dependencies                 |
| `./setup.sh shell` | Changes the shell                     |
| `./setup.sh brew`  | Installs [homebrew](https://brew.sh/) |
| `./setup.sh git`   | Installs [git](https://git-scm.com/)  |
| `./setup.sh yadm`  | Installs [yadm](https://yadm.io/)     |
| `./setup.sh clean` | Deletes the setup script              |

# Optional

<details>
<summary>Activate Argcomplete</summary>

[Doc](https://github.com/kislyuk/argcomplete?tab=readme-ov-file#installation)

```bash
activate-global-python-argcomplete --user
```

</details>

<details>
<summary>Install Nix</summary>

[Doc](https://nixos.org/)

Uses [Determinate Installer](https://github.com/DeterminateSystems/nix-installer)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

</details>
