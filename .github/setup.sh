#!/bin/bash

if [[ "${#}" -ne 1 ]]; then
    echo "Usage: <command>"
    exit 1
fi

system_type=$(uname -s)
echo "System type: ${system_type}"

install_deps() {
    echo "Installing dependencies"
    if [[ "${system_type}" == "Darwin" ]]; then
        echo "  None"
    elif [[ "${system_type}" == "Linux" ]]; then
        echo "  Starting"
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
        echo "  Error: unhandled system type"
        exit 1
    fi
}

change_shell() {
    echo "Changing shell to Zsh"
    if [[ "${system_type}" == "Darwin" ]]; then
        echo "  Already the default"
    elif [[ "${system_type}" == "Linux" ]]; then
        echo "  Installing"
        sudo apt install zsh
        echo "  Changing"
        chsh -s $(which zsh)
        echo "  SUCCESS RESTART TERMINAL"
    else
        echo "  Error: unhandled system type"
        exit 1
    fi
}

evaluate_homebrew() {
    echo "Evaluating homebrew"
    if [[ -z $(command -v brew) ]]; then
        if [[ "${system_type}" == "Darwin" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ "${system_type}" == "Linux" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            echo "  Error: unhandled system type"
            exit 1
        fi
        echo "  Done"
    else
        echo "  Already evaluated"
    fi
}

install_homebrew() {
    echo "Installing homebrew"
    if [[ -z $(command -v brew) ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "  Done"
    else
        echo "  Already installed"
    fi
    evaluate_homebrew
}

brew_install() {
    evaluate_homebrew
    echo "Installing ${1} with homebrew"
    brew install ${1}
    echo "  Done"
}

known_hosts_file="$HOME/.ssh/known_hosts"

initialize_known_hosts() {
    echo "Creating empty file: ${known_hosts_file}"
    if [[ -f $known_hosts_file ]]; then
        echo "  Already exists"
    else
        ssh_directory=$(dirname ${known_hosts_file})
        mkdir -p ${ssh_directory}
        touch ${known_hosts_file}
        echo "  Done"
    fi
}

add_known_hosts() {
    echo "Adding ${1} hosts to: ${known_hosts_file}"
    hosts=$(cat ${known_hosts_file} | grep ${1})
    if [[ -z "${hosts}" ]]; then
        ssh-keyscan ${1} >> ${known_hosts_file}
        echo "  Done"
    else
        echo "  Already added"
    fi
}

generate_ssh_key() {
    ssh_file="$HOME/.ssh/${1}"
    echo "Generating SSH key: ${ssh_file}"
    if [[ -f $ssh_file ]]; then
        echo "  Already exists"
    else
        ssh-keygen -f ${ssh_file} -t ed25519 -C "meanderingprogrammer@gmail.com"
        eval "$(ssh-agent -s)"
        echo "  Done"
    fi
    echo "Command to copy to clipboard: ${2}"
    if [[ "${system_type}" == "Darwin" ]]; then
        echo "  cat ${ssh_file}.pub | pbcopy"
    elif [[ "${system_type}" == "Linux" ]]; then
        echo "  cat ${ssh_file}.pub | wl-copy"
    else
        echo "  Error: unhandled system type"
        exit 1
    fi
}

install_git() {
    # https://formulae.brew.sh/formula/git
    brew_install "git"

    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    initialize_known_hosts
    add_known_hosts "github.com"
    add_known_hosts "gitlab.com"

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    generate_ssh_key "id_ed25519" "github"
    generate_ssh_key "id_ed25519_lab" "gitlab"
}

install_yadm() {
    # https://formulae.brew.sh/formula/yadm
    brew_install "yadm"

    # https://yadm.io/docs/bootstrap
    echo "Cloning dotfiles repo"
    yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
    echo "  Done"
}

cleanup_script() {
    echo "Deleting setup.sh"
    rm -rf "setup.sh"
    echo "  Done"
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
