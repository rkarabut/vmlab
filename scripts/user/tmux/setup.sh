#!/bin/bash
set -e

sudo apt-get -qq -y install tmux
cp .tmux.conf $HOME
