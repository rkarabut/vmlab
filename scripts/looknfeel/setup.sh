#!/bin/bash
sudo apt-get install dconf-cli greybird-gtk-theme tango-icon-theme numix-gtk-theme
sudo -u ri dbus-launch dconf load / < ./dconf-settings	
