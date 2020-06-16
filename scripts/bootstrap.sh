#!/bin/bash

# add the ri user
sudo groupadd -r autologin
sudo useradd -m -p saA3Gu85b.CZM ri -G sudo,autologin -s /bin/bash # password: ri

sudo apt-get -q -y update

# select the best apt source
sudo apt-get -q -y install aptitude curl netselect-apt whois

COUNTRY=$(whois $(curl ifconfig.me) | grep country: | awk '{print $2}')
sudo netselect-apt -a amd64 -c $COUNTRY -s -n -o /etc/apt/sources.list testing > /dev/null

# update to testing
sudo apt-get -q -y update

# aptitude autofixes some held packages problems after switching to testing
sudo aptitude -q -y install cmake build-essential
sudo aptitude -q -y install lightdm fluxbox terminator vim-nox fish 

sudo sed -i 's/.*autologin-user.*/autologin-user=ri/' /etc/lightdm/lightdm.conf 
sudo sed -i 's/.*autologin-session.*/autologin-session=fluxbox/' /etc/lightdm/lightdm.conf 
