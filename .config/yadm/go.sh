#!/bin/bash

_GO_VERSION=1.22.2

if [ ! -f ~/.local/bin/go ]; then
    _tarball_name=go$_GO_VERSION.linux-amd64.tar.gz
    _install_dir=~/.local/share
    _resource_dir=~/.local/resources
    mkdir -p $_install_dir
    mkdir -p $_resource_dir
    pushd $_resource_dir || return
    curl -LO https://go.dev/dl/$_tarball_name
    tar -C $_install_dir -xzf $_tarball_name
    ln -s $_install_dir/go/bin/go ~/.local/bin/go
    ln -s $_install_dir/go/bin/gofmt ~/.local/bin/gofmt
    popd || return
fi
