#!/bin/bash

if [ ! "$(uname)" == "Linux" ]; then
    _alacritty_portable_version=v0.13.2
    _portable_filename=Alacritty-${_alacritty_portable_version}-portable.exe
    _share_dir=~/.local/share/alacritty
    mkdir -p ~/.local/bin
    mkdir -p $_share_dir
    pushd $_share_dir || return
    wget https://github.com/alacritty/alacritty/releases/download/${_alacritty_portable_version}/${_portable_filename}
    ln -s ~/.local/bin/${_portable_filename} ~/.local/bin/alacritty.exe
    popd || return
fi
