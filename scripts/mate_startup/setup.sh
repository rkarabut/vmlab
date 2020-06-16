#!/bin/bash
set -e

chmod +x .startup.sh
cp .startup.sh ~
cp startup.desktop ~/.config/autostart/
