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
          zlib1g-dev
    else
        echo "  Error: unhandled system type"
        exit 1
    fi
}

change_shell() {
    echo "Changing shell to Zsh"
    shell_type=$(basename "$SHELL")
    if [[ "${shell_type}" == "zsh" ]]; then
        echo "  Already using zsh"
    elif [[ "${shell_type}" == "bash" ]]; then
        if [[ "${system_type}" == "Linux" ]]; then
            echo "  Installing"
            sudo apt --yes install zsh
            echo "  Changing"
            chsh -s $(which zsh)
            echo "  SUCCESS RESTART TERMINAL"
        else
            echo "  Error: unhandled system type"
            exit 1
        fi
    else
        echo "  Error: unhandled shell type ${shell_type}"
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
    brew list ${1}
    # $? is a special value that stores the exit status of the last executed command
    if [[ $? == 0 ]]; then
        echo "  Already installed"
    else
        brew install ${1}
        echo "  Done"
    fi
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

setup_ssh() {
    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    echo "Adding ${1} hosts to: ${known_hosts_file}"
    hosts=$(cat ${known_hosts_file} | grep ${1})
    if [[ -z "${hosts}" ]]; then
        ssh-keyscan ${1} >> ${known_hosts_file}
        echo "  Done"
    else
        echo "  Already added"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    ssh_file="$HOME/.ssh/${2}"
    echo "Generating SSH key: ${ssh_file}"
    if [[ -f $ssh_file ]]; then
        echo "  Already exists"
    else
        ssh-keygen -f ${ssh_file} -t ed25519 -C "meanderingprogrammer@gmail.com"
        eval "$(ssh-agent -s)"
        echo "  Done"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    echo "Command to copy to clipboard: ${1}"
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

    # Setup SSH keys for each git host
    initialize_known_hosts
    setup_ssh "github.com" "id_ed25519"
    setup_ssh "gitlab.com" "id_ed25519_lab"
    setup_ssh "bitbucket.org" "id_ed25519_bit"
}

install_yadm() {
    # https://formulae.brew.sh/formula/yadm
    brew_install "yadm"

    # https://yadm.io/docs/bootstrap
    echo "Cloning dotfiles repo"
    yadm_directory="$HOME/.config/yadm"
    if [[ -d $yadm_directory ]]; then
        echo "  Already cloned"
    else
        yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
        echo "  Done"
    fi
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
