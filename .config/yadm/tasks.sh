#!/bin/bash

_tw_version="2.6.2"
_tw_tui_version="0.25.4"
_resource_dir=~/.local/resources
_install_dir=~/.local/

mkdir -p $_resource_dir
mkdir -p $_install_dir

sudo dnf install libuuid-devel -y || return

echo "Installing Taskwarrior"
pushd $_resource_dir || return
curl -fLOsS https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v${_tw_version}/task-${_tw_version}.tar.gz
tar xzf task-${_tw_version}.tar.gz
cd task-${_tw_version} || return
cmake -DCMAKE_BUILD_TYPE=release -DENABLE_SYNC=OFF -DCMAKE_INSTALL_PREFIX=${_install_dir} .
make
sudo make install
echo "Installation complete"
cd .. || return
rm -rf task-${_tw_version}/
rm task-${_tw_version}.tar.gz
echo "Installing taskwarrior-tui"
curl -fLOsS https://github.com/kdheepak/taskwarrior-tui/releases/download/v${_tw_tui_version}/taskwarrior-tui-x86_64-unknown-linux-gnu.tar.gz
tar xzf taskwarrior-tui-x86_64-unknown-linux-gnu.tar.gz
mv ./taskwarrior-tui ${_install_dir}/bin/
rm taskwarrior-tui-x86_64-unknown-linux-gnu.tar.gz
echo "Installation complete"
popd || return
