#!/usr/bin/env zsh

# https://wezfurlong.org/wezterm/install/linux.html
wezterm_install() {
    if dpkg -s "wezterm" > /dev/null; then
        return
    fi

    local gpg_file="/usr/share/keyrings/wezterm-fury.gpg"
    if [[ ! -f "${gpg_file}" ]]; then
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o "${gpg_file}"
    fi

    local sources_file="/etc/apt/sources.list.d/wezterm.list"
    if [[ ! -f "${sources_file}" ]]; then
        echo "deb [signed-by=${gpg_file}] https://apt.fury.io/wez/ * *" | sudo tee "${sources_file}"
    fi

    sudo apt update --yes
    sudo apt install --yes wezterm
}

wezterm_install
