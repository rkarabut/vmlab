#!/bin/bash
set -e

# apt-get completion is broken in fish 3.1.2, building from master
# sudo apt-get -qq -y install fish

sudo apt-get -qq -y install libncurses-dev cmake

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all >/dev/null

git clone -q https://github.com/fish-shell/fish-shell.git
cd fish-shell
mkdir build && cd build
cmake .. >/dev/null 2>/dev/null
make >/dev/null && sudo make install
sudo ln -s /usr/local/bin/fish /usr/bin/fish

echo $'export FZF_DEFAULT_COMMAND=\'rg --files --no-ignore --hidden --follow --glob "!.git/*"\'' \
    | sudo tee -a $HOME/.bashrc

if [[ ! -d $HOME/.local/share/omf ]]; then
    curl -s -L https://get.oh-my.fish > omf.fish

    fish omf.fish --noninteractive
    fish -c 'omf install fzf z bobthefish'
fi
