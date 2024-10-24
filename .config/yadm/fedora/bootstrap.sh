#!/bin/bash
_script_dir="$(dirname "${BASH_SOURCE:-$0}")"
_yadm_cfg_dir="$(dirname "$(dirname "${BASH_SOURCE:-$0}")")"

_pkgs="
    alacritty \
    fd-find \
    fzf \
    git \
    gnome-shell-extension-pop-shell \
    golang \
    neovim \
    tmux \
    xprop
    "

sudo dnf install $_pkgs -y

bash "$_yadm_cfg_dir/jbm_font.sh"
bash "$_yadm_cfg_dir/lazydocker.sh"
bash "$_yadm_cfg_dir/lazygit.sh"
bash "$_yadm_cfg_dir/rust.sh"
bash "$_yadm_cfg_dir/tmux.sh"
