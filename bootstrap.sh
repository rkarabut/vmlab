#!/bin/bash

# add the ri user
sudo groupadd -r autologin
sudo useradd -m -p saA3Gu85b.CZM ri -G sudo,autologin -s /bin/bash # password: ri

sudo apt-get -qq -y update

# select the best apt source
sudo apt-get -qq -y install aptitude curl netselect-apt whois

COUNTRY=$(whois $(curl -s ifconfig.me) | grep country: | awk '{print $2}')
sudo netselect-apt -a amd64 -c $COUNTRY -s -n -o /etc/apt/sources.list testing >/dev/null 2>&1

# update to testing
sudo apt-get -qq -y update

# aptitude autofixes some held packages problems after switching to testing
sudo aptitude -q -y install cmake build-essential
sudo aptitude -q -y install lightdm mate-desktop-environment terminator vim-nox fish 

sudo sed -i 's/.*autologin-user.*/autologin-user=ri/' /etc/lightdm/lightdm.conf 
sudo sed -i 's/.*autologin-session.*/autologin-session=mate/' /etc/lightdm/lightdm.conf 

for d in $(find /tmp/scripts -mindepth 1 -maxdepth 1 -type d); do
  ( cd $d && bash ./setup.sh )
done
