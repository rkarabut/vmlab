#!/bin/bash
set -e

sudo apt-get -qq -y install libimage-exiftool-perl graphicsmagick-imagemagick-compat terminology

sudo pip install ranger-fm -q
ranger --copy-config=all
sed -i 's/^set preview_images.*$/set preview_images true/' $HOME/.config/ranger/rc.conf
sed -i 's/^set preview_images_method.*$/set preview_images_method terminology/' $HOME/.config/ranger/rc.conf

mkdir -p $HOME/.config/terminology/config/standard/
cp terminology/base.cfg $HOME/.config/terminology/config/standard/

