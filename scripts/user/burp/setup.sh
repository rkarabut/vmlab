#!/bin/bash
set -e

sudo apt-get -qq -y install openjdk-11-jre

mkdir -p $HOME/work/burp

BURP_FILENAME=$(curl -sL https://portswigger.net/burp/releases/community/latest | grep burpsuite_community.*jar | sed 's/.*\(burpsuite_community.*\.jar\).*/\1/')
wget -c -q https://portswigger.net/burp/releases/download/$BURP_FILENAME -O $HOME/work/burp/burpsuite_community.jar

echo "#!/bin/bash\njava -jar $HOME/work/burp/burpsuite_community.jar" >> $HOME/work/burp/burpsuite_community.sh
chmod +x $HOME/work/burp/burpsuite_community.sh

mkdir -p $HOME/.local/bin
ln -s $HOME/work/burp/burpsuite_community.sh $HOME/.local/bin/burpsuite_community
