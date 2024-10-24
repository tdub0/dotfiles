#!/bin/bash

_rust_installed=$(which rustup)
if [ $? -eq 1 ]; then
    # Install rustup if it isn't already installed
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source ~/.bashrc

_check_for_crates="\
    bat \
    ripgrep \
    "

_crates=""

_check_crate() {
    _crate_check=$(which "$1")
    if [ $? -eq 1 ]; then
        _crates+=" $1"
    fi
}

for _crate in $_check_for_crates; do
    _check_crate "$_crate"
done

if [ ! "$_crates" = "" ]; then
    cargo install"$_crates"
fi
