#!/usr/bin/env bash

FAIL=31
SUCCESS=32
TITLE=35
INFO=36

notify() {
    echo -e "\033[0;${1}m${2}\033[0m"
}

has() {
    if command -v "${1}" > /dev/null; then
        notify $INFO "  present: ${1}"
        return 0
    else
        notify $INFO "  missing: ${1}"
        return 1
    fi
}

is_phone() {
    [[ $(uname -o) == "Android" ]]
}

main() {
    if [[ "${#}" -ne 1 ]]; then
        notify $FAIL "usage: <command>"
        exit 1
    fi
    case ${1} in
        "deps") do_deps ;;
        "shell") do_shell ;;
        "limit") do_limit ;;
        "brew") do_homebrew ;;
        "git") do_git ;;
        "yadm") do_yadm ;;
        "clean") do_clean ;;
        *)
            notify $FAIL "unknown command: ${1}"
            notify $FAIL "valid commands: deps, shell, limit, brew, git, yadm, clean"
            exit 1
            ;;
    esac
}

do_deps() {
    notify $TITLE "start: installing dependencies"
    if has "pkg"; then
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
          xz-utils \
          yadm \
          zsh
        notify $SUCCESS "  success"
    elif has "apt"; then
        sudo apt --yes install \
          bubblewrap \
          build-essential \
          gcc \
          git \
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
          tk-dev \
          wget \
          wl-clipboard \
          xclip \
          xz-utils \
          zlib1g-dev \
          zsh
        notify $SUCCESS "  success"
    elif has "pacman"; then
        sudo pacman -S --noconfirm \
          git \
          man-db \
          man-pages \
          wl-clipboard \
          zsh
        notify $SUCCESS "  success"
    else
        notify $INFO "  skip: unknown package manager"
    fi
}

do_shell() {
    notify $TITLE "start: changing shell to zsh"
    local shell_type=$(basename "$SHELL")
    if [[ "${shell_type}" == "bash" ]]; then
        chsh -s $(which zsh)
        notify $SUCCESS "  success: restart system"
    elif [[ "${shell_type}" == "zsh" ]]; then
        notify $INFO "  skip: already using zsh"
    else
        notify $FAIL "  error: unhandled shell ${shell_type}"
        exit 1
    fi
}

do_limit() {
    notify $TITLE "start: increasing limits"
    local limit_directory="/Library/LaunchDaemons"
    if [[ -d ${limit_directory} ]]; then
        local limit_file="limit.maxfiles.plist"
        sudo cp "$HOME/docs/${limit_file}" "${limit_directory}"
        sudo chown root:wheel "${limit_directory}/${limit_file}"
        sudo launchctl load -w "${limit_directory}/${limit_file}"
        notify $SUCCESS "  success"
    else
        notify $INFO "  skip: missing ${limit_directory}"
    fi
}

do_homebrew() {
    notify $TITLE "start: installing homebrew"
    if is_phone; then
        notify $INFO "  skip: phone"
    elif has "brew"; then
        notify $INFO "  skip: already done"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        notify $SUCCESS "  success"
        evaluate_homebrew
    fi
}

evaluate_homebrew() {
    notify $TITLE "start: evaluating homebrew"
    local brew_mac="/opt/homebrew/bin/brew"
    local brew_linux="/home/linuxbrew/.linuxbrew/bin/brew"
    if has "brew"; then
        notify $INFO "  skip: already done"
    elif [[ -x ${brew_mac} ]]; then
        eval "$($brew_mac shellenv)"
        notify $SUCCESS "  success"
    elif [[ -x ${brew_linux} ]]; then
        eval "$($brew_linux shellenv)"
        notify $SUCCESS "  success"
    else
        notify $INFO "  skip: missing init"
        return 1
    fi
}

brew_install() {
    notify $TITLE "start: installing ${1} with homebrew"
    if evaluate_homebrew; then
        brew install ${1}
        notify $SUCCESS "  success"
    fi
}

setup_file() {
    notify $TITLE "start: creating empty file ${1}"
    if [[ -f ${1} ]]; then
        notify $INFO "  skip: already done"
    else
        local directory=$(dirname ${1})
        mkdir -p ${directory}
        touch ${1}
        notify $SUCCESS "  success"
    fi
}

setup_ssh() {
    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    notify $TITLE "start: adding hosts ${2}"
    local hosts=$(cat ${1} | grep ${2})
    if [[ -z "${hosts}" ]]; then
        ssh-keyscan ${2} >> ${1}
        notify $SUCCESS "  success"
    else
        notify $INFO "  skip: already done"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    notify $TITLE "start: generating SSH key ${2}"
    local ssh_file="$HOME/.ssh/${3}"
    if [[ -f ${ssh_file} ]]; then
        notify $INFO "  skip: already done"
    else
        ssh-keygen -f ${ssh_file} -t ed25519 -C "meanderingprogrammer@gmail.com"
        eval "$(ssh-agent -s)"
        notify $SUCCESS "  success"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    notify $TITLE "start: copy command ${2}"
    local copy_command
    if has "pbcopy"; then
        copy_command="pbcopy"
    elif [[ "${XDG_SESSION_TYPE}" == "x11" ]]; then
        copy_command="xclip -selection clipboard"
    else
        copy_command="wl-copy"
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
    notify $TITLE "start: cloning dotfiles repo"
    local yadm_directory="$HOME/.config/yadm"
    if [[ -d ${yadm_directory} ]]; then
        notify $INFO "  skip: already done"
    else
        yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
        notify $SUCCESS "  success"
    fi
}

do_clean() {
    notify $TITLE "start: deleting setup.sh"
    rm -rf "setup.sh"
    notify $SUCCESS "  success"
}

main "$@"
