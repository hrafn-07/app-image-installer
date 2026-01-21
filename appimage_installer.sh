#!/bin/bash

# Simple script to install an AppImage
# Usage: ./install-appimage.sh /path/to/AppImage [AppName]

set -e

# === Input Validation ===
APPIMAGE_PATH="$1"
APP_NAME="$2"

if [[ -z "$APPIMAGE_PATH" || ! -f "$APPIMAGE_PATH" ]]; then
  echo "Usage: $0 /path/to/AppImage [AppName]"
  exit 1
fi

if [[ -z "$APP_NAME" ]]; then
  APP_NAME=$(basename "$APPIMAGE_PATH" .AppImage)
fi

USERNAME=$(whoami)
TARGET_DIR="/home/$USERNAME/Applications"
DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"
ICON_PATH="$TARGET_DIR/$APP_NAME.png"

# === Prepare ===
mkdir -p "$TARGET_DIR"

# === Make executable ===
chmod +x "$APPIMAGE_PATH"

# === Move AppImage ===
mv "$APPIMAGE_PATH" "$TARGET_DIR/$APP_NAME.AppImage"

# === Ask for icon ===
echo "If you have an icon for $APP_NAME (PNG), place it at: $ICON_PATH"
read -p "Do you want to create a .desktop file for menu integration? (y/n): " CREATE_ENTRY

if [[ "$CREATE_ENTRY" =~ ^[Yy]$ ]]; then
  echo "Creating $DESKTOP_FILE..."

  cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$APP_NAME
Exec=$TARGET_DIR/$APP_NAME.AppImage
Icon=$ICON_PATH
Type=Application
Categories=Utility;
Terminal=false
EOF

  chmod +x "$DESKTOP_FILE"
  echo ".desktop entry created at $DESKTOP_FILE"
else
  echo "Skipping .desktop creation."
fi

echo "SUCCESS: $APP_NAME installed to $TARGET_DIR"

