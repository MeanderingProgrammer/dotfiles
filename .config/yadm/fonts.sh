#!/bin/bash

set -euo pipefail

font_dir="$HOME/.local/share/fonts"
[[ ! -d $font_dir ]] && mkdir -p $font_dir

font_names=(
    "segoeui.ttf"
    "segoeuib.ttf"
    "segoeuil.ttf"
    "segoeuisl.ttf"
    "seguisb.ttf"
)
for font_name in "${font_names[@]}"; do
    if [[ ! -f "${font_dir}/${font_name}" ]]; then
        cp "$(dirname $0)/fonts/${font_name}" "${font_dir}"
        sleep 1
        fc-cache -f
    fi
done
