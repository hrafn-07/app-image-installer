# AppImage Installer

A simple bash script that helps you install and remove AppImage applications on Linux systems.

## Overview

This script automates the process of managing AppImage applications by:

1. **Installing**: Moving the AppImage to a dedicated Applications directory, making it executable, and optionally creating a desktop entry
2. **Removing**: Cleaning up the AppImage, desktop entry, and icon files

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

### Install an Application

```bash
./appimage_installer.sh install /path/to/your-application.AppImage [AppName]
```

**Parameters:**

- `install`: Action to install an application
- `/path/to/your-application.AppImage`: The path to the AppImage file you want to install (required)
- `AppName`: Optional name for your application. If not provided, the script will use the AppImage filename without the `.AppImage` extension

**Example:**

```bash
./appimage_installer.sh install ~/Downloads/MyApp-1.2.3.AppImage "My Application"
```

### Remove an Application

```bash
./appimage_installer.sh remove AppName
```

**Parameters:**

- `remove`: Action to remove an installed application
- `AppName`: The name of the application to remove (required)

**Example:**

```bash
./appimage_installer.sh remove "My Application"
```

## What the Script Does

### Install Action

1. Validates that the AppImage path is provided and exists
2. Creates a `~/Applications` directory if it doesn't exist
3. Makes the AppImage executable
4. Moves the AppImage to `~/Applications/AppName.AppImage`
5. Prompts you to create a desktop entry file
6. If you choose to create a desktop entry:
   - Creates a `.desktop` file in `~/.local/share/applications/`
   - Tells you where to place an icon for the application

### Remove Action

1. Validates that the application name is provided
2. Removes the AppImage from `~/Applications/AppName.AppImage`
3. Removes the `.desktop` file from `~/.local/share/applications/`
4. Removes the icon file `~/Applications/AppName.png` if it exists
5. Provides warnings if any files are not found

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

- **Permission denied**: Make sure the script is executable (`chmod +x appimage_installer.sh`)
- **Cannot find AppImage**: Verify the path to your AppImage file is correct
- **Application doesn't appear in menu**: You may need to log out and log back in for the desktop entry to be recognized
- **Remove warnings**: If you see warnings during removal, it means some files were already deleted or never existed

