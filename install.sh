#!/usr/bin/env bash
set -e

# Target directories
INSTALL_DIR="$HOME/Applications"
APP_NAME="OpenIEHandler.app"
APP_PATH="$INSTALL_DIR/$APP_NAME"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_SCRIPT="$DIR/src/OpenIEHandler.applescript"

echo "==> Building OpenIEHandler for macOS..."
mkdir -p "$INSTALL_DIR"
rm -rf "$APP_PATH"

# Compile AppleScript into Application bundle
osacompile -o "$APP_PATH" "$SRC_SCRIPT"

# Configure Info.plist with URL Scheme handler
PLIST="$APP_PATH/Contents/Info.plist"

/usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string com.custom.openie" "$PLIST" 2>/dev/null || /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier com.custom.openie" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :CFBundleName string OpenIE Handler" "$PLIST" 2>/dev/null || /usr/libexec/PlistBuddy -c "Set :CFBundleName OpenIE Handler" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :LSUIElement bool true" "$PLIST" 2>/dev/null || /usr/libexec/PlistBuddy -c "Set :LSUIElement true" "$PLIST"

/usr/libexec/PlistBuddy -c "Delete :CFBundleURLTypes" "$PLIST" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Add :CFBundleURLTypes array" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :CFBundleURLTypes:0 dict" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :CFBundleURLTypes:0:CFBundleURLName string OpenIE Protocol" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :CFBundleURLTypes:0:CFBundleURLSchemes array" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :CFBundleURLTypes:0:CFBundleURLSchemes:0 string openIE" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :CFBundleURLTypes:0:CFBundleURLSchemes:1 string openie" "$PLIST"

# Ad-hoc code sign for macOS Gatekeeper and LaunchServices compatibility
codesign --force --deep --sign - "$APP_PATH" >/dev/null 2>&1

# Register with macOS LaunchServices
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$APP_PATH"

echo "==> Successfully installed OpenIEHandler to $APP_PATH"
echo "==> Registered openIE:// protocol handler with macOS LaunchServices."
