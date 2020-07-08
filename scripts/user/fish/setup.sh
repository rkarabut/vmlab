#!/bin/bash
set -e

sudo apt-get -qq -y install fish
curl -s -L https://get.oh-my.fish | fish
omf install fzf z bobthefish
