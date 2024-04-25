#!/bin/bash
_script_dir="$(dirname "${BASH_SOURCE:-$0}")"
_yadm_cfg_dir="$(dirname "$(dirname "${BASH_SOURCE:-$0}")")"

_pkgs="
    alacritty \
    git \
    neovim \
    tmux
    "

sudo dnf install $_pkgs -y
ln -s /usr/bin/nvim ~/.local/bin/nvim

bash "$_yadm_cfg_dir/go.sh"
bash "$_yadm_cfg_dir/jbm_font.sh"
bash "$_yadm_cfg_dir/rust.sh"
bash "$_yadm_cfg_dir/lazygit.sh"
bash "$_yadm_cfg_dir/lazydocker.sh"
