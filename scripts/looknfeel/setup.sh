#!/bin/bash
sudo apt-get install dconf-cli greybird-gtk-theme tango-icon-theme numix-gtk-theme
sudo -u ri dconf load / < ./dconf-settings	
