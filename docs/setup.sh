#!/bin/bash

set -euo pipefail

FAIL=31
SUCCESS=32
SKIP=33
TITLE=35
INFO=36
notify() {
    echo -e "\033[0;${1}m${2}\033[0m"
}

system_type=$(uname -s)
system_os=$(uname -o)

main() {
    notify $TITLE "System: ${system_type}-${system_os}"
    if [[ "${#}" -ne 1 ]]; then
        notify $FAIL "Usage: <command>"
        exit 1
    fi
    case ${1} in
        "deps") do_deps ;;
        "shell") do_shell ;;
        "brew") do_homebrew ;;
        "git") do_git ;;
        "yadm") do_yadm ;;
        "clean") do_clean ;;
        *)
            notify $FAIL "Unknown command: ${1}"
            notify $FAIL "Commands: deps, shell, brew, git, yadm, clean"
            exit 1
            ;;
    esac
}

do_deps() {
    notify $TITLE "Installing dependencies"
    if [[ "${system_type}" == "Darwin" ]]; then
        notify $SKIP "  Skipping: none"
    elif [[ "${system_os}" == "Android" ]]; then
        pkg install --yes \
          bat \
          clang \
          cmake \
          curl \
          fd \
          fzf \
          git \
          git-delta \
          golang \
          gradle \
          jq \
          just \
          lazygit \
          lua-language-server \
          make \
          neovim \
          nodejs \
          openjdk \
          python \
          ripgrep \
          rust \
          rust-analyzer \
          stylua \
          wget \
          yadm \
          zsh
        notify $SUCCESS "  Success"
    elif [[ "${system_type}" == "Linux" ]]; then
        sudo apt --yes install \
          bubblewrap \
          build-essential \
          gcc \
          git \
          latexmk \
          libbz2-dev \
          libffi-dev \
          liblzma-dev \
          libncursesw5-dev \
          libreadline-dev \
          libsqlite3-dev \
          libssl-dev \
          libxml2-dev \
          libxmlsec1-dev \
          llvm \
          make \
          texlive \
          texlive-xetex \
          tk-dev \
          wget \
          wl-clipboard \
          xz-utils \
          zlib1g-dev \
          zsh
        notify $SUCCESS "  Success"
    else
        notify $FAIL "  Error: unhandled system type"
        exit 1
    fi
}

do_shell() {
    notify $TITLE "Changing shell to zsh"
    shell_type=$(basename "$SHELL")
    if [[ "${shell_type}" == "zsh" ]]; then
        notify $SKIP "  Skipping: already done"
    elif [[ "${shell_type}" == "bash" ]]; then
        if [[ "${system_type}" == "Linux" ]]; then
            chsh -s $(which zsh)
            notify $SUCCESS "  Success: restart terminal"
        else
            notify $FAIL "  Error: unhandled system type"
            exit 1
        fi
    else
        notify $FAIL "  Error: unhandled shell type ${shell_type}"
        exit 1
    fi
}

do_homebrew() {
    notify $TITLE "Installing homebrew"
    if [[ -x "$(command -v brew)" ]]; then
        notify $SKIP "  Skipping: already done"
    elif [[ "${system_os}" == "Android" ]]; then
        notify $SKIP "  Skipping: android"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        notify $SUCCESS "  Success"
    fi
    evaluate_homebrew
}

evaluate_homebrew() {
    notify $TITLE "Evaluating homebrew"
    if [[ -x "$(command -v brew)" ]]; then
        notify $SKIP "  Skipping: already done"
    elif [[ "${system_os}" == "Android" ]]; then
        notify $SKIP "  Skipping: android"
    else
        if [[ "${system_type}" == "Darwin" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ "${system_type}" == "Linux" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            notify $FAIL "  Error: unhandled system type"
            exit 1
        fi
        notify $SUCCESS "  Success"
    fi
}

brew_install() {
    evaluate_homebrew
    notify $TITLE "Installing ${1} with homebrew"
    if [[ "${system_os}" == "Android" ]]; then
        notify $SKIP "  Skipping: android"
    else
        brew install ${1}
        notify $SUCCESS "  Success"
    fi
}

setup_file() {
    notify $TITLE "Creating empty file: ${1}"
    if [[ -f ${1} ]]; then
        notify $SKIP "  Skipping: already done"
    else
        local directory
        directory=$(dirname ${1})
        mkdir -p ${directory}
        touch ${1}
        notify $SUCCESS "  Success"
    fi
}

setup_ssh() {
    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    notify $TITLE "Adding hosts: ${2}"
    local hosts
    hosts=$(cat ${1} | grep ${2})
    if [[ -z "${hosts}" ]]; then
        ssh-keyscan ${2} >> ${1}
        notify $SUCCESS "  Success"
    else
        notify $SKIP "  Skipping: already done"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    notify $TITLE "Generating SSH key: ${2}"
    local ssh_file="$HOME/.ssh/${3}"
    if [[ -f ${ssh_file} ]]; then
        notify $SKIP "  Skipping: already done"
    else
        ssh-keygen -f ${ssh_file} -t ed25519 -C "meanderingprogrammer@gmail.com"
        eval "$(ssh-agent -s)"
        notify $SUCCESS "  Success"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    notify $TITLE "Copy command: ${2}"
    local copy_command
    if [[ "${system_type}" == "Darwin" ]]; then
        copy_command="pbcopy"
    elif [[ "${system_type}" == "Linux" ]]; then
        copy_command="wl-copy"
    else
        notify $FAIL "  Error: unhandled system type"
        exit 1
    fi
    notify $INFO "  cat ${ssh_file}.pub | ${copy_command}"
}

do_git() {
    # https://formulae.brew.sh/formula/git
    brew_install "git"

    # Setup SSH keys for each git host
    local known_hosts="$HOME/.ssh/known_hosts"
    setup_file ${known_hosts}
    setup_ssh ${known_hosts} "github.com" "id_ed25519"
    setup_ssh ${known_hosts} "gitlab.com" "id_ed25519_lab"
    setup_ssh ${known_hosts} "bitbucket.org" "id_ed25519_bit"
}

do_yadm() {
    # https://formulae.brew.sh/formula/yadm
    brew_install "yadm"

    # https://yadm.io/docs/bootstrap
    notify $TITLE "Cloning dotfiles repo"
    local yadm_directory="$HOME/.config/yadm"
    if [[ -d ${yadm_directory} ]]; then
        notify $SKIP "  Skipping: already done"
    else
        yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
        notify $SUCCESS "  Success"
    fi
}

do_clean() {
    notify $TITLE "Deleting setup.sh"
    rm -rf "setup.sh"
    notify $SUCCESS "  Success"
}

main "$@"
