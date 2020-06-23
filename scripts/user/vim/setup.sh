#!/bin/bash
set -e

sudo apt-get -qq -y install vim-nox fzf silversearcher-ag
cp .vimrc ~/.vimrc
if [[ ! -d ~/.vim/bundle/Vundle.vim ]] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim -E -s -c "source ~/.vimrc" -c PluginInstall -c qa
