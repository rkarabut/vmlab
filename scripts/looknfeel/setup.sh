#!/bin/bash
set -e

sudo apt-get install dconf-cli greybird-gtk-theme tango-icon-theme numix-gtk-theme
XDG_RUNTIME_DIR="/run/user/$(id -u)" dbus-launch dconf load / < ./dconf-settings

echo "Installing NerdFonts Hack..."
wget -q -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -O /tmp/Hack.zip
mkdir -p ~/.local/share/fonts && unzip -u /tmp/Hack.zip -d ~/.local/share/fonts 
fc-cache -fv >/dev/null 2>&1
