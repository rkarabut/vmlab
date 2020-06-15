#!/bin/bash
sudo groupadd -r autologin

sudo useradd -m -p saA3Gu85b.CZM ri -G sudo,autologin -s /bin/bash # password: ri

sudo apt-get -y update
sudo apt-get -y install curl netselect-apt whois

COUNTRY=$(whois $(curl ifconfig.me) | grep country: | awk '{print $2}')
sudo netselect-apt -a amd64 -c $COUNTRY -s -n -o /etc/apt/sources.list testing

sudo apt-get -y update
sudo apt-get -y install lightdm fluxbox terminator cmake build-essential vim-nox fish 

sudo sed -i 's/.*autologin-user.*/autologin-user=ri/' /etc/lightdm/lightdm.conf 
sudo sed -i 's/.*autologin-session.*/autologin-session=fluxbox/' /etc/lightdm/lightdm.conf 
