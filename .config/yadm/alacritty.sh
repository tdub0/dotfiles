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
else
    _resource_dir=~/.local/resources
    mkdir -p $_resource_dir

    _pkgs="cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel scdoc"
    sudo dnf install $_pkgs -y
    sudo group install "Development Tools"

    pushd $_resource_dir || return
    [ -f alacrity ] && rm -rf alacritty
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty || return
    cargo build --release
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    sudo cp target/release/alacritty /usr/local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
    sudo mkdir -p /usr/local/share/man/man1
    sudo mkdir -p /usr/local/share/man/man5
    scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
    scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
    scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
    scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null
    mkdir -p ~/.bash_completion
    cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
    echo "source ~/.bash_completion/alacritty" >> ~/.bashrc
    popd || return
fi
