#!/bin/bash

# Simple script to install or remove an AppImage
# Usage: ./appimage_installer.sh install /path/to/AppImage [AppName]
#        ./appimage_installer.sh remove AppName

set -e

# === Input Validation ===
ACTION="$1"
APPIMAGE_PATH="$2"
APP_NAME="$3"

if [[ -z "$ACTION" ]]; then
  echo "Usage: $0 install /path/to/AppImage [AppName]"
  echo "       $0 remove AppName"
  exit 1
fi

if [[ "$ACTION" == "remove" ]]; then
  APP_NAME="$2"
  if [[ -z "$APP_NAME" ]]; then
    echo "Usage: $0 remove AppName"
    exit 1
  fi
elif [[ "$ACTION" == "install" ]]; then
  if [[ -z "$APPIMAGE_PATH" || ! -f "$APPIMAGE_PATH" ]]; then
    echo "Usage: $0 install /path/to/AppImage [AppName]"
    exit 1
  fi
else
  echo "Invalid action: $ACTION"
  echo "Usage: $0 install /path/to/AppImage [AppName]"
  echo "       $0 remove AppName"
  exit 1
fi

USERNAME=$(whoami)
TARGET_DIR="/home/$USERNAME/Applications"

# === Handle Remove Action ===
if [[ "$ACTION" == "remove" ]]; then
  DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"
  APPIMAGE_FILE="$TARGET_DIR/$APP_NAME.AppImage"
  ICON_PATH="$TARGET_DIR/$APP_NAME.png"
  
  echo "Removing $APP_NAME..."
  
  # Remove AppImage
  if [[ -f "$APPIMAGE_FILE" ]]; then
    rm "$APPIMAGE_FILE"
    echo "Removed: $APPIMAGE_FILE"
  else
    echo "Warning: AppImage not found at $APPIMAGE_FILE"
  fi
  
  # Remove .desktop file
  if [[ -f "$DESKTOP_FILE" ]]; then
    rm "$DESKTOP_FILE"
    echo "Removed: $DESKTOP_FILE"
  else
    echo "Warning: .desktop file not found at $DESKTOP_FILE"
  fi
  
  # Remove icon if exists
  if [[ -f "$ICON_PATH" ]]; then
    rm "$ICON_PATH"
    echo "Removed: $ICON_PATH"
  fi
  
  echo "SUCCESS: $APP_NAME has been removed"
  exit 0
fi

# === Handle Install Action ===
if [[ -z "$APP_NAME" ]]; then
  APP_NAME=$(basename "$APPIMAGE_PATH" .AppImage)
fi

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

