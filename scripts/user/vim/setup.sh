#!/bin/bash
set -e

# vim-gtk is convenient to install for clipboard support
sudo apt-get -qq -y install vim-nox fzf silversearcher-ag libpython3-dev xdg-utils vim-gtk

cp .vimrc ~/.vimrc
if [[ ! -d ~/.vim/autoload/plug.vim ]] ; then
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

wget https://github.com/wfxr/code-minimap/releases/download/v0.4.1/code-minimap-v0.4.1-x86_64-unknown-linux-gnu.tar.gz
tar xzf code-minimap-v0.4.1-x86_64-unknown-linux-gnu.tar.gz
cp code-minimap-v0.4.1-x86_64-unknown-linux-gnu/code-minimap ~/.local/bin/

vim -E -s -c "source ~/.vimrc" -c PlugInstall -c qa
