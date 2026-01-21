# AppImage Installer

A simple bash script that helps you install AppImage applications on Linux systems.

## Overview

This script automates the process of installing AppImage applications by:
1. Moving the AppImage to a dedicated Applications directory
2. Making the AppImage executable
3. Optionally creating a desktop entry for easy access from your application menu

## Requirements

- Linux operating system
- Bash shell
- File permissions to create directories in your home folder

## Installation

1. Download the script:
   ```bash
   git clone https://github.com/hrafn-07/app-image-installer.git app-image-installer
   ```

2. Make it executable:
   ```bash
   cd app-image-installer && chmod +x appimage_installer.sh
   ```

## Usage

### Basic Usage

```bash
./install-appimage.sh /path/to/your-application.AppImage [AppName]
```

### Parameters

- `/path/to/your-application.AppImage`: The path to the AppImage file you want to install (required)
- `AppName`: Optional name for your application. If not provided, the script will use the AppImage filename without the `.AppImage` extension

### Example

```bash
./install-appimage.sh ~/Downloads/MyApp-1.2.3.AppImage "My Application"
```

## What the Script Does

1. Validates that the AppImage path is provided and exists
2. Creates a `~/Applications` directory if it doesn't exist
3. Makes the AppImage executable
4. Moves the AppImage to `~/Applications/AppName.AppImage`
5. Prompts you to create a desktop entry file
6. If you choose to create a desktop entry:
   - Creates a `.desktop` file in `~/.local/share/applications/`
   - Tells you where to place an icon for the application

## Desktop Entry

If you choose to create a desktop entry, the script will generate a `.desktop` file that includes:
- The application name
- Path to the executable
- Path to the icon (which you need to provide)
- Application category (set to "Utility" by default)

## Icon File

The script expects you to provide an icon file in PNG format at:
```
~/Applications/AppName.png
```

## Troubleshooting

- **Permission denied**: Make sure the script is executable (`chmod +x install-appimage.sh`)
- **Cannot find AppImage**: Verify the path to your AppImage file is correct
- **Application doesn't appear in menu**: You may need to log out and log back in for the desktop entry to be recognized

