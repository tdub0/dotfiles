#!/bin/bash
_script_dir="$(dirname "${BASH_SOURCE:-$0}")"

RELEASE=v0.11.2

if [ ! -f ~/.local/bin/nvim ]; then
    _install_dir=~/.local/share
    _resource_dir=~/.local/resources
    mkdir -p $_install_dir
    mkdir -p $_resource_dir

    pushd $_resource_dir || return
    [ -f nvim-linux-x86_64.appimage ] && rm nvim-linux-x86_64.appimage
    curl -LOsS https://github.com/neovim/neovim/releases/download/$RELEASE/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    popd || return
    ln -s $_resource_dir/nvim-linux-x86_64.appimage ~/.local/bin/nvim
fi
