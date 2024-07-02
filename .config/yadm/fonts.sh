#!/bin/bash

font_dir="$HOME/.local/share/fonts"
[[ ! -d $font_dir ]] && mkdir -p $font_dir

font_names=(
    "HackNerdFont-Regular.ttf"
    "MonaspaceNeon-Regular.otf"
    "segoeui.ttf"
)
for font_name in "${font_names[@]}"; do
    if [[ ! -f "${font_dir}/${font_name}" ]]; then
        cp "$(dirname $0)/${font_name}" "${font_dir}"
        fc-cache -f
    fi
done
