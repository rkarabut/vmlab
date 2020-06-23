#!/bin/bash
set -e

DIR=$(pwd)
chmod +x *.sh

cd 

# Studio only needed for JRE so far
wget -c -q https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.0.0.16/android-studio-ide-193.6514223-linux.tar.gz
tar --keep-newer-files -xzf android-studio-ide-193.6514223-linux.tar.gz > /dev/null 2>&1
rm android-studio-ide-193.6514223-linux.tar.gz

mkdir -p Android/Sdk

(cd Android/Sdk

SDK_TOOLS=$(curl -s https://dl.google.com/android/repository/repository2-1.xml | grep sdk-tools-linux \
    | sed 's/.*\(sdk-tools-linux-[0-9]*\.zip\).*/\1/')

wget -c -q https://dl.google.com/android/repository/$SDK_TOOLS -O sdk-tools.zip
unzip -qq -n sdk-tools.zip && rm -f sdk-tools.zip

AVD_NAME=5.1_WVGA_API_25

export JAVA_HOME=~/android-studio/jre/

yes | ./tools/bin/sdkmanager --install "platforms;android-25" "emulator" "platform-tools" > /dev/null
yes | ./tools/bin/sdkmanager --install "system-images;android-25;default;x86" > /dev/null
./tools/bin/avdmanager create avd -d "5.1in WVGA" -n "$AVD_NAME" -k "system-images;android-25;default;x86" --force > /dev/null

echo 'hw.cpu.ncore=1' >> $HOME/.android/avd/$AVD_NAME.avd/config.ini
# TODO setting hw.gpu.mode in config.ini doesn't work for some reason
# sed -i 's/hw\.gpu\.mode=.*/hw\.gpu\.mode=swiftshader_indirect/' $HOME/.android/avd/$AVD_NAME.avd/config.ini 
)

$DIR/prepare_quick_boot.sh   
cp $DIR/run_emulator.sh $HOME
