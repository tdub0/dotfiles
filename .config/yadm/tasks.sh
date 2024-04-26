#!/bin/bash

_version="2.6.2"
_resource_dir=~/.local/resources
_install_dir=~/.local/

mkdir -p $_resource_dir
mkdir -p $_install_dir

sudo dnf install libuuid-devel -y || return

echo "Installing Taskwarrior"
pushd $_resource_dir || return
curl -fLO https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v${_version}/task-${_version}.tar.gz
tar xzf task-${_version}.tar.gz
echo "Untar complete"
cd task-${_version} || return
cmake -DCMAKE_BUILD_TYPE=release -DENABLE_SYNC=OFF -DCMAKE_INSTALL_PREFIX=${_install_dir} .
make
sudo make install
echo "Installation complete"
cd .. || return
rm -rf task-${_version}/
rm task-${_version}.tar.gz
echo "Removal complete"
popd || return
