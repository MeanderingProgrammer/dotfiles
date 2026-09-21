#!/usr/bin/env bash

yadm_path="${HOME}/.config/yadm"

FAIL=31
SUCCESS=32
TITLE=35
INFO=36

notify() {
    printf '\033[0;%sm%s\033[0m\n' "${1}" "${2}"
}

check_cmd() {
    if command -v "${1}" > /dev/null; then
        notify "${INFO}" "  present: ${1}"
        return 0
    else
        notify "${INFO}" "  missing: ${1}"
        return 1
    fi
}

is_mac() {
    [[ $(uname -o) == "Darwin" ]]
}

is_phone() {
    [[ $(uname -o) == "Android" ]]
}

main() {
    if [[ "${#}" -ne 1 ]]; then
        notify "${FAIL}" "usage: <command>"
        exit 1
    fi
    case ${1} in
        "deps") do_deps ;;
        "shell") do_shell ;;
        "brew") do_homebrew ;;
        "git") do_git ;;
        "yadm") do_yadm ;;
        "device") do_device ;;
        "clean") do_clean ;;
        *)
            notify "${FAIL}" "unknown command: ${1}"
            notify "${FAIL}" "valid commands: deps, shell, brew, git, yadm, device, clean"
            exit 1
            ;;
    esac
}

do_deps() {
    notify "${TITLE}" "start: installing dependencies"

    if check_cmd "pkg"; then
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
            openjdk-21 \
            pass \
            python \
            ripgrep \
            rust \
            rust-analyzer \
            stylua \
            termux-api \
            wget \
            xz-utils \
            yadm \
            zsh
        notify "${SUCCESS}" "  success"
    elif check_cmd "apt"; then
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
        notify "${SUCCESS}" "  success"
    elif check_cmd "pacman"; then
        sudo pacman -S --noconfirm \
            git \
            man-db \
            man-pages \
            wl-clipboard \
            zsh
        notify "${SUCCESS}" "  success"
    else
        notify "${INFO}" "  skip: unknown package manager"
    fi
}

do_shell() {
    notify "${TITLE}" "start: changing shell to zsh"

    local shell_type=$(basename "${SHELL}")

    if [[ "${shell_type}" == "bash" ]]; then
        chsh -s $(which zsh)
        notify "${SUCCESS}" "  success: restart system"
    elif [[ "${shell_type}" == "zsh" ]]; then
        notify "${INFO}" "  skip: already using zsh"
    else
        notify "${FAIL}" "  error: unhandled shell ${shell_type}"
        exit 1
    fi
}

do_homebrew() {
    notify "${TITLE}" "start: installing homebrew"

    if is_phone; then
        notify "${INFO}" "  skip: phone"
    elif check_cmd "brew"; then
        notify "${INFO}" "  skip: already done"
    else
        /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        notify "${SUCCESS}" "  success"
        evaluate_homebrew
    fi
}

evaluate_homebrew() {
    notify "${TITLE}" "start: evaluating homebrew"

    local brew_mac="/opt/homebrew/bin/brew"
    local brew_linux="/home/linuxbrew/.linuxbrew/bin/brew"

    if check_cmd "brew"; then
        notify "${INFO}" "  skip: already done"
    elif [[ -x "${brew_mac}" ]]; then
        eval "$("${brew_mac}" shellenv)"
        notify "${SUCCESS}" "  success"
    elif [[ -x "${brew_linux}" ]]; then
        eval "$("${brew_linux}" shellenv)"
        notify "${SUCCESS}" "  success"
    else
        notify "${INFO}" "  skip: missing init"
        return 1
    fi
}

brew_install() {
    notify "${TITLE}" "start: installing ${1} with homebrew"

    if evaluate_homebrew; then
        brew install ${1}
        notify "${SUCCESS}" "  success"
    fi
}

setup_file() {
    notify "${TITLE}" "start: creating empty file ${1}"

    if [[ -f ${1} ]]; then
        notify "${INFO}" "  skip: already done"
    else
        local directory=$(dirname ${1})
        mkdir -p ${directory}
        touch ${1}
        notify "${SUCCESS}" "  success"
    fi
}

setup_ssh() {
    local known_hosts="${1}"
    local host="${2}"
    local key_name="${3}"
    local ssh_file="${HOME}/.ssh/${key_name}"

    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    notify "${TITLE}" "start: adding hosts ${host}"

    local hosts=$(cat ${known_hosts} | grep ${host})
    if [[ -z "${hosts}" ]]; then
        ssh-keyscan "${host}" >> "${known_hosts}"
        notify "${SUCCESS}" "  success"
    else
        notify "${INFO}" "  skip: already done"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    notify "${TITLE}" "start: generating SSH key ${host}"

    if [[ -f "${ssh_file}" ]]; then
        notify "${INFO}" "  skip: already done"
    else
        ssh-keygen \
            -f "${ssh_file}" \
            -t ed25519 \
            -C "meanderingprogrammer@gmail.com"
        eval "$(ssh-agent -s)"
        notify "${SUCCESS}" "  success"
    fi

    # https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
    notify "${TITLE}" "start: copy command ${host}"

    local copy_command
    if check_cmd "pbcopy"; then
        copy_command="pbcopy"
    elif [[ "${XDG_SESSION_TYPE}" == "x11" ]]; then
        copy_command="xclip -selection clipboard"
    else
        copy_command="wl-copy"
    fi

    notify "${INFO}" "  cat ${ssh_file}.pub | ${copy_command}"
}

do_git() {
    # https://formulae.brew.sh/formula/git
    brew_install "git"

    local known_hosts="${HOME}/.ssh/known_hosts"

    setup_file "${known_hosts}"
    setup_ssh "${known_hosts}" "github.com" "id_ed25519"
    setup_ssh "${known_hosts}" "gitlab.com" "id_ed25519_lab"
    setup_ssh "${known_hosts}" "bitbucket.org" "id_ed25519_bit"
}

do_yadm() {
    # https://formulae.brew.sh/formula/yadm
    brew_install "yadm"

    # https://yadm.io/docs/bootstrap
    notify "${TITLE}" "start: cloning dotfiles repo"

    if [[ -d ${yadm_path} ]]; then
        notify "${INFO}" "  skip: already done"
    else
        yadm clone --bootstrap git@github.com:MeanderingProgrammer/dotfiles.git
        notify "${SUCCESS}" "  success"
    fi
}

do_device() {
    notify "${TITLE}" "start: modifying defaults"

    if is_mac; then
        defaults write com.apple.finder AppleShowAllFiles -boolean true
    else
        notify "${INFO}" "  skip: not mac"
    fi

    notify "${TITLE}" "start: increasing limits"

    local limit_directory="/Library/LaunchDaemons"
    local limit_file="limit.maxfiles.plist"
    local limit_path="${limit_directory}/${limit_file}"
    local limit_source="${yadm_path}/macos/${limit_file}"

    if [[ -d ${limit_directory} ]]; then
        sudo cp "${limit_source}" "${limit_directory}"
        sudo chown root:wheel "${limit_path}"
        sudo launchctl load -w "${limit_path}"
        notify "${SUCCESS}" "  success"
    else
        notify "${INFO}" "  skip: missing ${limit_directory}"
    fi

    notify "${TITLE}" "start: setting up termux"

    local font_path="${HOME}/.termux/font.ttf"
    local font_source="${yadm_path}/assets/JetBrainsMonoNerdFont-Regular.ttf"

    if is_phone; then
        termux-setup-storage
        cp "${font_source}" "${font_path}"
        termux-reload-settings
        notify "${SUCCESS}" "  success"
    else
        notify "${INFO}" "  skip: not phone"
    fi
}

do_clean() {
    notify "${TITLE}" "start: deleting setup.sh"

    rm -rf "setup.sh"
    notify "${SUCCESS}" "  success"
}

main "$@"
