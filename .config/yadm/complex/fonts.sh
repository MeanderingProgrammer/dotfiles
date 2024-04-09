#!/bin/bash

# https://github.com/githubnext/monaspace/blob/main/util/install_linux.sh
font_dir="$HOME/.local/share/fonts"
mkdir -p $font_dir
if [[ ! -f "${font_dir}/MonaspaceNeon-Regular.otf" ]]; then
    wget https://github.com/githubnext/monaspace/releases/download/v1.000/monaspace-v1.000.zip
    unzip -d temp-fonts monaspace-v1.000.zip
    cp temp-fonts/monaspace-v1.000/fonts/otf/* $font_dir
    rm -rf monaspace-v1.000.zip temp-fonts
    fc-cache -f
fi
