#!/bin/bash
set -e

sudo apt-get -qq -y install dconf-cli greybird-gtk-theme tango-icon-theme numix-gtk-theme \
    parcellite

XDG_RUNTIME_DIR="/run/user/$(id -u)" dbus-launch dconf load / < ./dconf-settings

mkdir -p $HOME/.config/parcellite
cp parcelliterc $HOME/.config/parcellite

chmod +x add_mate_launcher.sh
sudo cp add_mate_launcher.sh /usr/local/bin/

if [[ ! -e "$HOME/.local/share/fonts/Hack Regular Nerd Font Complete.ttf" ]]; then
    echo "Installing NerdFonts Hack..."
    wget -q -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -O /tmp/Hack.zip
    mkdir -p ~/.local/share/fonts && unzip -u /tmp/Hack.zip -d ~/.local/share/fonts 
    fc-cache -fv >/dev/null 2>&1
fi
