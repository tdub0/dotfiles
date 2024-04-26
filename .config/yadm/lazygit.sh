#!/bin/bash

sudo dnf copr enable atim/lazygit -y || return
sudo dnf install lazygit -y
