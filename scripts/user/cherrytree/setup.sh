#!/bin/bash
set -e

sudo apt-get -y install snapd
sudo snap install cherrytree
sudo ln -s /snap/bin/cherrytree /usr/local/bin/cherrytree
