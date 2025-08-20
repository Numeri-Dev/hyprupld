# Quick Start Guide

Get up and running with HyprUpld in minutes! This guide will help you install and use HyprUpld for basic screenshot and upload functionality.

## Prerequisites

Before installing HyprUpld, ensure you have:

### Linux
- A supported Linux distribution (Arch, Debian, Fedora, Ubuntu, etc.)
- Basic command-line tools (curl, python3)
- A desktop environment (GNOME, KDE, Hyprland, etc.)

### macOS
- macOS 10.0 or later
- Homebrew (recommended for easy installation)

## Installation

### One-Line Install (Recommended)

```bash
# Linux
bash -c "$(curl -fsSL https://raw.githubusercontent.com/NumeriDev/hyprupld/main/install.sh)"

# macOS
bash -c "$(curl -fsSL https://raw.githubusercontent.com/NumeriDev/hyprupld/main/install_macos.sh)"
```

### Alternative: Package Manager (Arch Linux)

```bash
# Using yay
yay -S hyprupld

# Using paru
paru -S hyprupld
```

## First Run

1. **Open a terminal** and run:
   ```bash
   hyprupld
   ```

2. **Select your audio player** when prompted (the script will detect available options)

3. **Take your first screenshot** - the script will automatically detect your desktop environment and use the appropriate screenshot tool

4. **The screenshot will be copied to your clipboard** - you can paste it anywhere!

## Basic Usage

### Take Screenshot and Copy to Clipboard
```bash
hyprupld
```
This is the most basic usage - takes a screenshot and copies it directly to your clipboard.

### Upload to a Service
```bash
# Upload to imgur (no authentication required)
hyprupld -imgur

# Upload to guns.lol (will prompt for API key on first use)
hyprupld -guns
```

### Save Screenshot Locally
```bash
hyprupld -s
```
This will prompt you to select a directory and save the screenshot with organized folder structure.

## Setting Up Keybindings

### Hyprland
Add to your `~/.config/hypr/hyprland.conf`:
```conf
# Screenshot and copy to clipboard
bind = , Print, exec, hyprupld

# Screenshot and upload to imgur
bind = SHIFT, Print, exec, hyprupld -imgur

# Screenshot and save locally
bind = CTRL, Print, exec, hyprupld -s
```

### GNOME
1. Go to Settings → Keyboard → Keyboard Shortcuts
2. Click "Add Shortcut"
3. Set name: "Screenshot"
4. Set command: `hyprupld`
5. Set keyboard shortcut (e.g., `Print`)

### KDE
1. Go to System Settings → Shortcuts → Custom Shortcuts
2. Click "Edit" → "New" → "Global Shortcut" → "Command/URL"
3. Set name: "Screenshot"
4. Set command: `hyprupld`
5. Set trigger to your preferred key combination

### i3/Sway
Add to your config file:
```conf
# Screenshot and copy to clipboard
bindsym Print exec hyprupld

# Screenshot and upload to imgur
bindsym Shift+Print exec hyprupld -imgur
```

## Common Commands

| Command | Description |
|---------|-------------|
| `hyprupld` | Take screenshot and copy to clipboard |
| `hyprupld -imgur` | Take screenshot and upload to imgur |
| `hyprupld -guns` | Take screenshot and upload to guns.lol |
| `hyprupld -s` | Take screenshot and save locally |
| `hyprupld -debug` | Enable debug mode for troubleshooting |
| `hyprupld -silent` | Run without sounds or notifications |
| `hyprupld -h` | Show help information |

## What Happens When You Run HyprUpld

1. **Environment Detection**: The script detects your OS, desktop environment, and display server
2. **Dependency Check**: Verifies required tools are installed (installs missing ones if possible)
3. **Screenshot Capture**: Uses the appropriate tool for your environment
4. **Processing**: Either copies to clipboard or uploads to selected service
5. **Feedback**: Plays sound and shows notification (unless silenced)

## Next Steps

- **Configure upload services**: See [Upload Services Guide](UPLOAD_SERVICES.md)
- **Customize settings**: See [Configuration Guide](CONFIGURATION.md)
- **Set up keybindings**: Configure your desktop environment shortcuts
- **Learn advanced features**: Read the [User Guide](USER_GUIDE.md)

## Getting Help

If you encounter any issues:

1. **Check the logs**: Run `hyprupld -debug` for detailed information
2. **Read troubleshooting**: See [Troubleshooting Guide](TROUBLESHOOTING.md)
3. **Report issues**: Create an issue on the GitHub repository

## Supported Services

HyprUpld supports many upload services out of the box:

- **imgur** - No authentication required
- **guns.lol** - Requires API key
- **pixelvault.co** - Requires API key
- **e-z.host** - Requires API key
- **fakecri.me** - Requires API key
- **nest.rip** - Requires API key
- **Custom Zipline instances**
- **Custom xBackBone instances**

For detailed information about each service, see [Upload Services Guide](UPLOAD_SERVICES.md).

---

**Congratulations!** You're now ready to use HyprUpld. The script will handle most things automatically, but feel free to explore the advanced features and customization options. 