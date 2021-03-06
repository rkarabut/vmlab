#!/bin/bash
set -e

export SDK_ROOT=$HOME/Android/Sdk

$SDK_ROOT/platform-tools/adb start-server
$SDK_ROOT/emulator/emulator -avd 5.1_WVGA_API_25 -no-window -gpu swiftshader_indirect &

while true; do
    if [[ -z $(pgrep emulator) ]]; then
        break
    fi

    lines=$($SDK_ROOT/platform-tools/adb logcat -d 'AlertService' -s -e BOOT_COMPLETED)
    if [[ ! -z "$lines" ]]; then
        # emu kill already saves a snapshot
        #$SDK_ROOT/platform-tools/adb emu avd snapshot save default 
        $SDK_ROOT/platform-tools/adb emu kill
        break
    fi
    sleep 5
done
