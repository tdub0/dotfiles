#!/bin/bash

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.bitwarden.desktop
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub org.signal.Signal
flatpak install flathub tv.plex.PlexDesktop
