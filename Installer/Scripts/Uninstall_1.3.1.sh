#!/bin/sh

echo "Uninstalling 1.3.x"
sudo true

if [ "$COMMON_DEFINED" = "" ]; then
	source `dirname "$0"`/Common.sh
fi

if [ -e "$HELPER_PATH" ]; then
    echo "Removing NoSleep.app..."
    ps aux|grep NoSleep.app|awk '{print $2}'|xargs kill &> /dev/null
    sudo rm -rf "$HELPER_PATH"
fi

if [ -e "$LAUNCH_DAEMON_PATH" ]; then
    echo "Removing launch daemon plist..."
    $USER_SUDO_CMD launchctl unload $LAUNCH_DAEMON_PATH &> /dev/null
    sudo rm -rf "$LAUNCH_DAEMON_PATH"
fi

if kextstat | grep "$KEXT_ID" > /dev/null; then
    echo "Unloading kernel extension..."
    sudo kextunload -b "$KEXT_ID"
fi

if [ -e "$KEXT_PATH" ]; then
    echo "Removing kernel extension..."
    sudo rm -rf "$KEXT_PATH"
fi

if [ -e "$PERF_PATH" ]; then
    echo "Removing preferences plug-in..."
    sudo rm -rf "$PERF_PATH"
fi

sudo pkgutil --forget "com.protech.pkg.NoSleep" &> /dev/null

echo "Done"