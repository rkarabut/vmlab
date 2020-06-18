#!/bin/bash
set -e

DIR=$(pwd)
chmod +x *.sh

cd 

# Studio only needed for JRE so far
wget -c -q https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.0.0.16/android-studio-ide-193.6514223-linux.tar.gz
tar --keep-newer-files -xzf android-studio-ide-193.6514223-linux.tar.gz > /dev/null 2>&1

mkdir -p Android/Sdk

(cd Android/Sdk

# find the latest SDK
SDK_TOOLS=$(curl -s https://dl.google.com/android/repository/repository2-1.xml | grep sdk-tools-linux \
    | sed 's/.*\(sdk-tools-linux-[0-9]*\.zip\).*/\1/')

wget -c -q https://dl.google.com/android/repository/$SDK_TOOLS
unzip -qq -n sdk-tools-linux-4333796.zip

#wget -c -q https://dl.google.com/android/repository/3534162-studio.sdk-patcher.zip
#unzip -qq -n 3534162-studio.sdk-patcher.zip

AVD_NAME=5.1_WVGA_API_25

export JAVA_HOME=~/android-studio/jre/
yes | ./tools/bin/sdkmanager --install "platforms;android-25" "emulator" "platform-tools" > /dev/null
yes | ./tools/bin/sdkmanager --install "system-images;android-25;default;x86" > /dev/null
./tools/bin/avdmanager create avd -d "5.1in WVGA" -n "$AVD_NAME" -k "system-images;android-25;default;x86" --force > /dev/null

echo 'hw.cpu.ncore=1' >> ~/.android/avd/$AVD_NAME.avd/config.ini
# TODO setting swiftshader_indirect in this way is ignored for some reason
# echo 'hw.gpu.mode=swiftshader_indirect' >> ~/.android/avd/$AVD_NAME.avd/config.ini
)

$DIR/prepare_quick_boot.sh   
cp $DIR/run_emulator.sh ~
