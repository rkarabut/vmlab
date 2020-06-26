#!/bin/bash
set -e

DIR=$(pwd)

cd 

sudo apt-get -qq -y install openjdk-11-jre

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle >/dev/null 2>&1 

git clone https://github.com/NationalSecurityAgency/ghidra.git

(cd ghidra

sudo apt-get -qq -y install openjdk-11-jdk bison flex
gradle --init-script gradle/support/fetchDependencies.gradle init
gradle buildGhidra
)

mkdir -p work/ && cd work

GHIDRA_DIR=$(unzip -t $HOME/ghidra/build/dist/ghidra*.zip | head -n2 | tail -n1 | awk '{print $2}')
unzip -qq -n $HOME/ghidra/build/dist/ghidra*.zip
rm -rf $HOME/ghidra
ln -s $HOME/work/$GHIDRA_DIR/ghidraRun $HOME/ghidra
mkdir -p $HOME/.ghidra/.$GHIDRA_DIR

#echo "USER_AGREEMENT=ACCEPT" >> $HOME/.ghidra/.$GHIDRA_DIR/preferences
echo "SHOW_TIPS=false" >> $HOME/.ghidra/.$GHIDRA_DIR/preferences
echo "GhidraShowWhatsNew=false" >> $HOME/.ghidra/.$GHIDRA_DIR/preferences











