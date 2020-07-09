#!/bin/bash
set -e

sudo apt-get -qq -y install fish

if [[ ! -d $HOME/.local/share/omf ]]; then 
    curl -s -L https://get.oh-my.fish > omf.fish
    
    fish omf.fish --noninteractive
    fish -c 'omf install fzf z bobthefish'
fi
