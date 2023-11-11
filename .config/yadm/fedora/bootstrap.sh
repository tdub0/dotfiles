#!/bin/bash
_script_dir="$( dirname "${BASH_SOURCE[0]}" )" 
_yadm_cfg_dir="$( dirname "$( dirname "${BASH_SOURCE[0]}" )" )"

_pkgs="\
    alacritty \
    git \
    neovim \
    python3-neovim \
    tmux \
    "

# sudo dnf install $_pkgs -y

# bash $_yadm_cfg_dir/go.sh
# bash $_yadm_cfg_dir/jbm_font.sh
# bash $_yadm_cfg_dir/rust.sh
