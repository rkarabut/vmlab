#!/bin/bash
set -e

cp .startup.sh ~
chmod +x ~/.startup.sh
mkdir -p ~/.config/autostart && cp startup.desktop ~/.config/autostart/
