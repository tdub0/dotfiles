#!/bin/bash
_script_dir="$(dirname "${BASH_SOURCE:-$0}")"

if [ ! -f ~/.local/bin/nvim ]; then
    _install_dir=~/.local/share
    _resource_dir=~/.local/resources
    mkdir -p $_install_dir
    mkdir -p $_resource_dir

    pushd $_resource_dir || return
    [ -f nvim.appimage ] && rm nvim.appimage
    curl -LOsS https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    [ -d ./squashfs-root ] && rm -rf ./squashfs-root
    [ -d ./nvim ] && rm -rf ./nvim
    ./nvim.appimage --appimage-extract
    mv ./squashfs-root ./nvim
    ./nvim/AppRun --version
    rm nvim.appimage
    popd || return
    ln -s $_resource_dir/nvim/AppRun ~/.local/bin/nvim
fi
