#!/bin/bash

if [[ "${#}" -ne 1 ]]; then
    echo "Usage: <command>"
    exit 1
fi

system_type=$(uname -s)

install_deps() {
    if [[ "${system_type}" == "Darwin" ]]; then
        echo "No additional dependencies for mac"
    elif [[ "${system_type}" == "Linux" ]]; then
        sudo apt install \
          git \
          wget \
          make \
          gcc \
          llvm \
          wl-clipboard \
          build-essential \
          bubblewrap \
          xz-utils \
          libbz2-dev \
          libffi-dev \
          liblzma-dev \
          libncursesw5-dev \
          libreadline-dev \
          libsqlite3-dev \
          libssl-dev \
          libxml2-dev \
          libxmlsec1-dev \
          tk-dev \
          zlib1g-dev
    else
        echo "Unhandled system type ${system_type}"
        exit 1
    fi
}

change_shell() {
    # https://www.zsh.org/
    if [[ "${system_type}" == "Darwin" ]]; then
        echo "mac already uses Z Shell"
    elif [[ "${system_type}" == "Linux" ]]; then
        sudo apt install zsh
        chsh -s $(which zsh)
        echo "Shell changed, restart your terminal"
    else
        echo "Unhandled system type ${system_type}"
        exit 1
    fi
}

evaluate_homebrew() {
    if [[ $(command -v brew) == "" ]]; then
        if [[ "${system_type}" == "Darwin" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ "${system_type}" == "Linux" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            echo "Unhandled system type ${system_type}"
            exit 1
        fi
    else
        echo "Homebrew already evaluated"
    fi
}

install_homebrew() {
    if [[ $(command -v brew) == "" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        evaluate_homebrew
    else
        echo "Homebrew already installed"
    fi
}

install_git() {
    # https://formulae.brew.sh/formula/git
    evaluate_homebrew
    brew install git

    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    mkdir -p ~/.ssh
    touch ~/.ssh/known_hosts
    ssh-keyscan github.com >> ~/.ssh/known_hosts

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    ssh_file="$HOME/.ssh/id_ed25519.pub"
    if [[ -f $ssh_file ]]; then
        echo "${ssh_file} already exists"
    else
        ssh-keygen -t ed25519 -C "meanderingprogrammer@gmail.com"
        eval "$(ssh-agent -s)"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    if [[ "${system_type}" == "Darwin" ]]; then
        cat ${ssh_file} | pbcopy
    elif [[ "${system_type}" == "Linux" ]]; then
        cat ${ssh_file} | wl-copy
    else
        echo "Unhandled system type ${system_type}"
        exit 1
    fi
    echo "SSH key copied to clipboard, paste to GitHub"
}

install_yadm() {
    # https://formulae.brew.sh/formula/yadm
    evaluate_homebrew
    brew install yadm

    # https://yadm.io/docs/bootstrap
    yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
}

cleanup_script() {
    rm -rf "setup.sh"
}

case ${1} in
  "deps")
    install_deps
    ;;
  "shell")
    change_shell
    ;; 
  "brew")
    install_homebrew
    ;;
  "git")
    install_git
    ;;
  "yadm")
    install_yadm
    ;;
  "clean")
    cleanup_script
    ;;
  *)
    echo "Unknown command: ${1}"
    echo "Commands: deps, shell, brew, git, yadm, clean"
    exit 1
    ;;
esac
