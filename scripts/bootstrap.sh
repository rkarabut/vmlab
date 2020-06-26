#!/bin/bash
set -e

# add the /home partition (for the expanded disk)
if [[ ! -e /dev/sda3 ]]; then
    echo 41531392 | sudo sfdisk -a /dev/sda -N 3 --force
    sudo partx -v -a /dev/sda >/dev/null 2>&1 || true
    sudo mkfs.ext4 /dev/sda3
    sudo mount /dev/sda3 /mnt
    sudo cp -rfp /home/* /mnt
    sudo umount /mnt
    sudo mount /dev/sda3 /home
    echo "/dev/sda3 /home ext4 defaults 0 0" | sudo tee -a /etc/fstab 
fi

# add the user 
sudo groupadd -r autologin
VM_PASSWORD_HASH=$(perl -e 'print crypt($ARGV[0], "salt"),"\n"' $VM_PASSWORD)
sudo useradd -m -p $VM_PASSWORD_HASH $VM_USERNAME -G sudo,autologin,kvm,vboxsf -s /bin/bash 

sudo apt-get -qq -y update

# select the best apt source
sudo apt-get -qq -y install aptitude curl netselect-apt whois

COUNTRY=$(whois $(curl -s ifconfig.me) | grep country: | awk '{print $2}')
sudo netselect-apt -a amd64 -c $COUNTRY -s -n -o /etc/apt/sources.list testing >/dev/null 2>&1

# update to testing
sudo apt-get -qq -y update

# aptitude autofixes some held packages problems after switching to testing
sudo aptitude -q=2 -y install cmake build-essential
sudo aptitude -q=2 -y install lightdm mate-desktop-environment vim-nox fish git \
    jq proxychains firefox-esr python3-pip

sudo sed -i "s/.*autologin-user.*/autologin-user = $VM_USERNAME/" /etc/lightdm/lightdm.conf 
sudo sed -i 's/.*autologin-session.*/autologin-session = mate/' /etc/lightdm/lightdm.conf 

# don't ask the user for password
echo "$VM_USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers >/dev/null

echo 'PATH="$HOME/.local/bin:$PATH"' | sudo tee -a /home/$VM_USERNAME/.bashrc

curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py | sudo python
