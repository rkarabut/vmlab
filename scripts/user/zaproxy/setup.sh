#!/bin/bash
set -e

sudo apt-get -qq -y install openjdk-11-jre

mkdir -p $HOME/work

ZAP_LINK=$(curl -sL https://www.zaproxy.org/download/ | grep "ZAP_[0-9\.]*_Linux.tar.gz" | sed 's/.*\(https:\/\/[^"]*ZAP_[0-9\.]*_Linux.tar.gz\).*/\1/')
wget -c -q $ZAP_LINK -O zap.tar.gz 
tar xzf zap.tar.gz && rm -f zap.tar.gz

ZAP_DIR=$(find -maxdepth 1 -type d | grep ZAP)
mv $ZAP_DIR $HOME/work/zaproxy

mkdir -p $HOME/.local/bin
ln -s $HOME/work/zaproxy/zap.sh $HOME/.local/bin/zap.sh
