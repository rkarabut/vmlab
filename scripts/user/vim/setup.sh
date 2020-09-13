#!/bin/bash
set -e

sudo apt-get -qq -y install vim-nox fzf silversearcher-ag libpython3-dev xdg-utils

cp .vimrc ~/.vimrc
if [[ ! -d ~/.vim/autoload/plug.vim ]] ; then
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

vim -E -s -c "source ~/.vimrc" -c PlugInstall -c qa
