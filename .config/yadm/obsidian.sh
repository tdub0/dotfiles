#!/bin/bash
_script_dir="$(dirname "${BASH_SOURCE:-$0}")"

if [ ! -f ~/.local/bin/obsidian ]; then
    _obsidian_version=1.6.3
    _install_dir=~/.local/share
    _resource_dir=~/.local/resources
    mkdir -p $_install_dir
    mkdir -p $_resource_dir

    pushd $_resource_dir || return
    [ -f obsidian.appimage ] && rm obsidian.appimage
    curl -LOsS https://github.com/obsidianmd/obsidian-releases/releases/download/v$_obsidian_version/Obsidian-$_obsidian_version.AppImage
    mv Obsidian-$_obsidian_version.AppImage obsidian.appimage
    chmod u+x obsidian.appimage
    [ -d ./squashfs-root ] && rm -rf ./squashfs-root
    [ -d ./obsidian ] && rm -rf ./obsidian
    ./obsidian.appimage --appimage-extract
    mv ./squashfs-root ./obsidian
    rm obsidian.appimage
    sudo cp ./obsidian/obsidian.png /usr/share/pixmaps/obsidian.png
    sed -i 's|Exec=AppRun|Exec=obsidian|' ./obsidian/obsidian.desktop
    sudo desktop-file-install ./obsidian/obsidian.desktop
    sudo update-desktop-database
    popd || return
    ln -s $_resource_dir/obsidian/AppRun ~/.local/bin/obsidian
fi
