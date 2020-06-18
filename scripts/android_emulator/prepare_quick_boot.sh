#!/bin/bash
set -e

export SDK_ROOT=~/Android/Sdk

$SDK_ROOT/platform-tools/adb start-server
$SDK_ROOT/emulator/emulator -avd 5.1_WVGA_API_25 -gpu swiftshader_indirect -no-window &

while true; do
    lines=$($SDK_ROOT/platform-tools/adb logcat -d 'AlertService' -s -e BOOT_COMPLETED)
    if [[ "1" -eq "$(echo $lines | grep BOOT_COMPLETED | wc -l)" ]]; then
        # emu kill already saves a snapshot
        #$SDK_ROOT/platform-tools/adb emu avd snapshot save default 
        $SDK_ROOT/platform-tools/adb emu kill
        break
    fi
    sleep 5
done
