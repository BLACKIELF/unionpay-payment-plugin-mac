#!/usr/bin/env bash
set -e

APP_PATH="$HOME/Applications/OpenIEHandler.app"

if [ -d "$APP_PATH" ]; then
    echo "==> Unregistering from macOS LaunchServices..."
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -u "$APP_PATH" 2>/dev/null || true
    echo "==> Removing $APP_PATH..."
    rm -rf "$APP_PATH"
    echo "==> OpenIEHandler successfully uninstalled."
else
    echo "==> OpenIEHandler not found in $HOME/Applications."
fi
