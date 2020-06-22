#!/bin/bash
set -e

DIR=$(pwd)
chmod +x *.sh

cd 

# get download link
DOWNLOAD_LINK=`curl -s https://developer.android.com/studio\#downloads | grep -Po "(https://).+?(commandlinetools-linux-\d+).+?latest.zip"`

# donwload the tools
wget -q -O "android-sdk-tools.zip" $DOWNLOAD_LINK
unzip android-sdk-tools.zip && rm -f ./android-sdk-tools.zip

mkdir -p $HOME/.android/sdk
mv ./tools $HOME/.android/sdk

(cd $HOME/.android/sdk

AVD_NAME=5.1_WVGA_API_25

export JAVA_HOME=~/android-studio/jre/
yes | ./tools/bin/sdkmanager --sdk_root=$HOME/.android/sdk --install "platforms;android-25" "emulator" "platform-tools" > /dev/null
yes | ./tools/bin/sdkmanager --sdk_root=$HOME/.android/sdk --install "system-images;android-25;default;x86" > /dev/null
./tools/bin/avdmanager create avd -d "5.1in WVGA" -n "$AVD_NAME" -k "system-images;android-25;default;x86" --force > /dev/null

echo 'hw.cpu.ncore=1' >> ~/.android/avd/$AVD_NAME.avd/config.ini
# TODO setting swiftshader_indirect in this way is ignored for some reason
# echo 'hw.gpu.mode=swiftshader_indirect' >> ~/.android/avd/$AVD_NAME.avd/config.ini
)

$DIR/prepare_quick_boot.sh   
cp $DIR/run_emulator.sh ~
