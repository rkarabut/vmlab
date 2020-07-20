#!/bin/bash
set -e

# apt-get completion is broken in fish 3.1.2, building from master
# sudo apt-get -qq -y install fish

sudo apt-get -qq -y install libncurses-dev cmake

git clone -q https://github.com/fish-shell/fish-shell.git
cd fish
mkdir build && cd build
cmake .. >/dev/null 2>/dev/null
make && sudo make install
sudo ln -s /usr/local/bin/fish /usr/bin/fish

if [[ ! -d $HOME/.local/share/omf ]]; then 
    curl -s -L https://get.oh-my.fish > omf.fish
    
    fish omf.fish --noninteractive
    fish -c 'omf install fzf z bobthefish'
fi
