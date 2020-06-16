#!/bin/bash
set -e

sudo apt-get install dconf-cli greybird-gtk-theme tango-icon-theme numix-gtk-theme
dbus-launch dconf load / < ./dconf-settings

echo "Installing NerdFonts Hack..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
mkdir -p ~/.local/share/fonts && unzip Hack.zip -d ~/.local/share/fonts
fc-cache -fv
