# Configuration Guide

Complete guide to configuring and customizing HyprUpld to suit your needs.

## Configuration Overview

HyprUpld stores all configuration in `~/.config/hyprupld/` and automatically manages settings based on your usage. The configuration system is designed to be user-friendly while providing extensive customization options.

## Configuration Directory Structure

```
~/.config/hyprupld/
├── settings.json      # User preferences and saved values
├── pckmgrs.json       # Detected package managers
└── debug.log          # Debug log file
```

## Settings File (`settings.json`)

The settings file contains all user preferences and saved values in JSON format.

### Basic Settings Structure

```json
{
  "screenshot_save_directory": "/path/to/save/directory",
  "preferred_audio_player": "paplay",
  "guns_auth": "your_guns_api_key",
  "pixelvault_auth": "your_pixelvault_token",
  "hyprland_tool": "hyprshot",
  "kde_tool": "spectacle",
  "gnome_tool": "gnome-screenshot"
}
```

### Available Settings

#### Screenshot Settings

| Setting | Type | Description | Default |
|---------|------|-------------|---------|
| `screenshot_save_directory` | string | Directory for saving screenshots | Prompted on first use |
| `hyprland_tool` | string | Preferred tool for Hyprland | `hyprshot` |
| `kde_tool` | string | Preferred tool for KDE | `spectacle` |
| `gnome_tool` | string | Preferred tool for GNOME | `gnome-screenshot` |
| `xfce_tool` | string | Preferred tool for XFCE | `xfce4-screenshooter` |
| `wayland_tool` | string | Preferred tool for Wayland | `grimblast` |
| `mate_tool` | string | Preferred tool for MATE | `mate-screenshot` |
| `cinnamon_tool` | string | Preferred tool for Cinnamon | `gnome-screenshot` |
| `cosmic_tool` | string | Preferred tool for Cosmic | `gnome-screenshot` |

#### Audio Settings

| Setting | Type | Description | Default |
|---------|------|-------------|---------|
| `preferred_audio_player` | string | Preferred audio player | Prompted on first use |

**Supported Audio Players:**
- `paplay` - PulseAudio Sound Player
- `play` - SoX Sound Player
- `aplay` - ALSA Sound Player
- `mpg123` - MPG123 Audio Player

#### Upload Service Authentication

| Setting | Type | Description |
|---------|------|-------------|
| `guns_auth` | string | API key for guns.lol |
| `ez_auth` | string | API key for e-z.host |
| `fakecrime_auth` | string | Authorization token for fakecri.me |
| `nest_auth` | string | Authorization token for nest.rip |
| `pixelvault_auth` | string | Authorization token for pixelvault.co |

## Environment Variables

HyprUpld supports several environment variables for advanced configuration:

### Core Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `HYPRUPLD_CONFIG` | Override default config directory | `export HYPRUPLD_CONFIG=/custom/path` |
| `HYPRUPLD_DEBUG` | Enable debug output | `export HYPRUPLD_DEBUG=1` |

### Usage Examples

```bash
# Set custom config directory
export HYPRUPLD_CONFIG="$HOME/.my-hyprupld-config"
hyprupld

# Enable debug mode via environment
export HYPRUPLD_DEBUG=1
hyprupld

# Combine multiple settings
export HYPRUPLD_CONFIG="/custom/config"
export HYPRUPLD_DEBUG=1
hyprupld -imgur
```

## Screenshot Tool Configuration

### Automatic Tool Selection

HyprUpld automatically detects your desktop environment and suggests appropriate screenshot tools:

#### Wayland Environments

**Hyprland:**
- Primary: `hyprshot`
- Fallback: `grim` + `slurp`

**Sway:**
- Primary: `grimblast`
- Fallback: `grim` + `slurp`

**KDE Plasma:**
- Primary: `spectacle`
- Fallback: `flameshot`

**GNOME:**
- Primary: `grim` + `slurp`
- Fallback: `grimblast`

#### X11 Environments

**GNOME:**
- Primary: `gnome-screenshot`
- Fallback: `flameshot`

**KDE:**
- Primary: `spectacle`
- Fallback: `flameshot`

**XFCE:**
- Primary: `xfce4-screenshooter`
- Fallback: `flameshot`

### Manual Tool Selection

You can manually configure your preferred screenshot tool:

```bash
# Reset settings to force tool selection
hyprupld -reset

# Run hyprupld and select your preferred tool when prompted
hyprupld
```

### Tool-Specific Configuration

#### hyprshot Configuration

Hyprshot is the recommended tool for Hyprland environments. Configuration options:

```bash
# Basic usage (auto-configured)
hyprshot -m region -z -s -o /tmp -f screenshot.png

# Custom options
hyprshot -m region -z -s -o /custom/path -f custom_name.png
```

#### grimblast Configuration

Grimblast is recommended for Sway environments:

```bash
# Area selection
grimblast save area /tmp/screenshot.png

# Window selection
grimblast save window /tmp/screenshot.png

# Screen selection
grimblast save screen /tmp/screenshot.png
```

#### Flameshot Configuration

Flameshot is a cross-platform fallback option:

```bash
# GUI mode
flameshot gui -p /tmp/screenshot.png

# Full screen
flameshot full -p /tmp/screenshot.png

# Area selection
flameshot gui --raw > /tmp/screenshot.png
```

## Audio Configuration

### Audio Player Selection

HyprUpld supports multiple audio players and will prompt you to select one on first run:

#### PulseAudio (paplay)
```bash
# Test audio
paplay /usr/local/share/hyprupld/sounds/sstaken.mp3

# Configuration
# Uses system PulseAudio configuration
```

#### SoX (play)
```bash
# Test audio
play -q /usr/local/share/hyprupld/sounds/sstaken.mp3

# Configuration
# Uses ~/.soxrc for configuration
```

#### ALSA (aplay)
```bash
# Test audio
aplay -q /usr/local/share/hyprupld/sounds/sstaken.mp3

# Configuration
# Uses ~/.asoundrc for configuration
```

#### MPG123 (mpg123)
```bash
# Test audio
mpg123 -q /usr/local/share/hyprupld/sounds/sstaken.mp3

# Configuration
# Uses ~/.mpg123rc for configuration
```

### Sound Files

HyprUpld includes three sound files for different actions:

| Sound File | Action | Description |
|------------|--------|-------------|
| `sstaken.mp3` | Screenshot taken | Played when screenshot is captured |
| `clipboard.mp3` | Copied to clipboard | Played when image is copied to clipboard |
| `link.mp3` | URL copied | Played when URL is copied to clipboard |

**Sound file locations:**
- Linux: `/usr/local/share/hyprupld/sounds/`
- macOS: `~/.local/share/hyprupld/sounds/`

## Upload Service Configuration

### Authentication Management

#### Setting Up Authentication

1. **Get API key/token** from the service website
2. **Run HyprUpld** with the service flag
3. **Enter credentials** when prompted
4. **Credentials are saved** for future use

```bash
# Example: Set up guns.lol
hyprupld -guns
# Enter your API key when prompted

# Example: Set up pixelvault.co
hyprupld -pixelvault
# Enter your authorization token when prompted
```

#### Managing Saved Credentials

**View saved credentials:**
```bash
cat ~/.config/hyprupld/settings.json
```

**Reset all credentials:**
```bash
hyprupld -reset
```

**Remove specific credential:**
```bash
# Edit settings file manually
nano ~/.config/hyprupld/settings.json
# Remove the specific auth line
```

### Service-Specific Configuration

#### imgur Configuration

Imgur supports both anonymous and authenticated uploads:

```bash
# Anonymous upload (no configuration needed)
hyprupld -imgur

# With Client-ID (optional, for higher rate limits)
# Get Client-ID from https://api.imgur.com/oauth2/addclient
```

#### Custom Zipline Configuration

```bash
# Basic usage
hyprupld -zipline https://my-zipline.com myauthkey

# With custom options
hyprupld -zipline https://my-zipline.com myauthkey -debug
```

#### Custom xBackBone Configuration

```bash
# Basic usage
hyprupld -xbackbone https://my-xbackbone.com mytoken

# With custom options
hyprupld -xbackbone https://my-xbackbone.com mytoken -silent
```

## Screenshot Save Configuration

### Directory Structure

When using the `-s` option, screenshots are saved with an organized structure:

```
~/Pictures/hyprupld/
├── january-2024/
│   ├── hyprupld-20240115-143022.png
│   ├── hyprupld-20240118-091545.png
│   └── hyprupld-20240125-162033.png
├── february-2024/
│   ├── hyprupld-20240203-104512.png
│   └── hyprupld-20240220-155847.png
└── march-2024/
    ├── hyprupld-20240308-120934.png
    ├── hyprupld-20240315-094728.png
    └── hyprupld-20240329-183651.png
```

### File Naming Convention

Screenshots are named using the format:
```
hyprupld-YYYYMMDD-HHMMSS.png
```

Where:
- `YYYY` = Year (4 digits)
- `MM` = Month (2 digits)
- `DD` = Day (2 digits)
- `HH` = Hour (2 digits, 24-hour format)
- `MM` = Minute (2 digits)
- `SS` = Second (2 digits)

### Customizing Save Location

1. **First time setup:**
   ```bash
   hyprupld -s
   # Select your preferred directory when prompted
   ```

2. **Change save location:**
   ```bash
   # Reset settings
   hyprupld -reset
   
   # Run with save option to select new location
   hyprupld -s
   ```

3. **Manual configuration:**
   ```bash
   # Edit settings file
   nano ~/.config/hyprupld/settings.json
   
   # Change the screenshot_save_directory value
   ```

## Advanced Configuration

### Debug Configuration

#### Enabling Debug Mode

```bash
# Temporary debug mode
hyprupld -debug

# Permanent debug mode via environment
export HYPRUPLD_DEBUG=1
hyprupld

# Debug with specific service
hyprupld -debug -imgur
```

#### Debug Log Configuration

Debug logs are written to `~/.config/hyprupld/debug.log`:

```bash
# View recent logs
tail -f ~/.config/hyprupld/debug.log

# Search for specific information
grep -i "screenshot" ~/.config/hyprupld/debug.log
grep -i "upload" ~/.config/hyprupld/debug.log
grep -i "error" ~/.config/hyprupld/debug.log
```

### UWSM Configuration

UWSM (User Wayland Session Manager) compatibility mode provides enhanced stability:

```bash
# Enable UWSM mode
hyprupld -uwsm

# UWSM mode with debug
hyprupld -uwsm -debug

# UWSM mode with upload service
hyprupld -uwsm -imgur
```

### Silent Mode Configuration

Silent mode disables all audio and visual feedback:

```bash
# Disable all feedback
hyprupld -silent

# Silent mode with upload
hyprupld -silent -imgur

# Silent mode with save
hyprupld -silent -s
```

### Mute Mode Configuration

Mute mode disables only audio feedback:

```bash
# Disable audio only
hyprupld -mute

# Mute with upload
hyprupld -mute -imgur
```

## Configuration Management

### Backup Configuration

```bash
# Backup settings
cp ~/.config/hyprupld/settings.json ~/.config/hyprupld/settings.json.backup

# Backup entire config directory
cp -r ~/.config/hyprupld ~/.config/hyprupld.backup
```

### Restore Configuration

```bash
# Restore settings
cp ~/.config/hyprupld/settings.json.backup ~/.config/hyprupld/settings.json

# Restore entire config directory
cp -r ~/.config/hyprupld.backup ~/.config/hyprupld
```

### Reset Configuration

```bash
# Reset all settings
hyprupld -reset

# Manual reset
rm ~/.config/hyprupld/settings.json
rm ~/.config/hyprupld/pckmgrs.json
```

### Configuration Validation

```bash
# Validate JSON format
python3 -c "import json; json.load(open('~/.config/hyprupld/settings.json'))"

# Check configuration
hyprupld -debug
```

## Custom Scripts and Automation

### Creating Custom Wrappers

You can create custom wrapper scripts for specific use cases:

```bash
#!/bin/bash
# ~/bin/screenshot-upload.sh

# Screenshot and upload to imgur with custom options
hyprupld -silent -imgur -s
```

```bash
#!/bin/bash
# ~/bin/screenshot-debug.sh

# Screenshot with full debug information
hyprupld -debug -s
```

### Keyboard Shortcuts

Configure keyboard shortcuts in your desktop environment:

#### Hyprland
```conf
# ~/.config/hypr/hyprland.conf
bind = , Print, exec, hyprupld
bind = SHIFT, Print, exec, hyprupld -imgur
bind = CTRL, Print, exec, hyprupld -s
bind = ALT, Print, exec, hyprupld -debug
```

#### i3/Sway
```conf
# ~/.config/i3/config or ~/.config/sway/config
bindsym Print exec hyprupld
bindsym Shift+Print exec hyprupld -imgur
bindsym Ctrl+Print exec hyprupld -s
bindsym Alt+Print exec hyprupld -debug
```

#### GNOME
1. Go to Settings → Keyboard → Keyboard Shortcuts
2. Add custom shortcuts:
   - Name: "Screenshot"
   - Command: `hyprupld`
   - Shortcut: `Print`

## Troubleshooting Configuration

### Common Configuration Issues

#### Settings File Corruption

```bash
# Check if settings file is valid JSON
python3 -c "import json; json.load(open('~/.config/hyprupld/settings.json'))"

# If invalid, reset configuration
hyprupld -reset
```

#### Permission Issues

```bash
# Check file permissions
ls -la ~/.config/hyprupld/

# Fix permissions
chmod 600 ~/.config/hyprupld/settings.json
chmod 755 ~/.config/hyprupld/
```

#### Missing Configuration Directory

```bash
# Create configuration directory
mkdir -p ~/.config/hyprupld

# Set proper permissions
chmod 755 ~/.config/hyprupld
```

### Configuration Debugging

```bash
# Enable debug mode
hyprupld -debug

# Check configuration loading
grep -i "config" ~/.config/hyprupld/debug.log

# Check settings file access
grep -i "settings" ~/.config/hyprupld/debug.log
```

## Best Practices

### Security

1. **Protect credentials:**
   ```bash
   chmod 600 ~/.config/hyprupld/settings.json
   ```

2. **Regular backups:**
   ```bash
   cp ~/.config/hyprupld/settings.json ~/.config/hyprupld/settings.json.backup
   ```

3. **Secure storage:**
   - Don't share your settings file
   - Use secure methods to store API keys
   - Regularly rotate API keys

### Performance

1. **Choose appropriate tools:**
   - Use native tools for your desktop environment
   - Avoid unnecessary fallbacks

2. **Optimize audio:**
   - Choose the fastest audio player for your system
   - Consider disabling audio for batch operations

3. **Manage logs:**
   ```bash
   # Rotate debug logs
   mv ~/.config/hyprupld/debug.log ~/.config/hyprupld/debug.log.old
   ```

### Maintenance

1. **Regular updates:**
   ```bash
   hyprupld -update
   ```

2. **Configuration review:**
   ```bash
   # Review settings periodically
   cat ~/.config/hyprupld/settings.json
   ```

3. **Cleanup:**
   ```bash
   # Remove old debug logs
   find ~/.config/hyprupld/ -name "*.log.old" -delete
   ```

---

**Note**: HyprUpld is designed to work with minimal configuration. Most settings are automatically detected and configured based on your system and usage patterns. 