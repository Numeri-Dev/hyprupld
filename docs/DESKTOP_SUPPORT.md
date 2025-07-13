# Desktop Environment Support

Comprehensive guide to desktop environment detection, tool selection, and optimization in HyprUpld.

## Overview

HyprUpld automatically detects your desktop environment and display server to provide the best screenshot experience. The script supports a wide range of desktop environments and automatically selects the most appropriate screenshot tool for your setup.

## Display Server Detection

### Wayland vs X11

HyprUpld detects your display server using environment variables:

#### Wayland Detection
```bash
# Check if running on Wayland
echo $WAYLAND_DISPLAY

# Common Wayland display names
# wayland-0, wayland-1, etc.
```

#### X11 Detection
```bash
# Check if running on X11
echo $DISPLAY

# Common X11 display names
# :0, :1, etc.
```

### Detection Logic

```bash
# HyprUpld's detection logic
if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    display_server="wayland"
elif [[ -n "${DISPLAY:-}" ]]; then
    display_server="x11"
else
    display_server="unknown"
fi
```

## Desktop Environment Detection

### Environment Variables

HyprUpld uses several environment variables to detect your desktop environment:

```bash
# Primary desktop environment
echo $XDG_CURRENT_DESKTOP

# Session type
echo $XDG_SESSION_TYPE

# Desktop session
echo $DESKTOP_SESSION
```

### Detection Priority

1. `$XDG_CURRENT_DESKTOP` - Primary detection method
2. `$DESKTOP_SESSION` - Fallback for older systems
3. Process detection - Final fallback

## Supported Desktop Environments

### Wayland Environments

#### Hyprland

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "hyprland"
- `$WAYLAND_DISPLAY` is set

**Primary Tool:** `hyprshot`
**Fallback Tool:** `grim` + `slurp`

**Configuration:**
```bash
# hyprshot configuration
hyprshot -m region -z -s -o /tmp -f screenshot.png

# grim + slurp fallback
grim -g "$(slurp)" /tmp/screenshot.png
```

**Features:**
- Native Hyprland integration
- Region selection with visual feedback
- Automatic clipboard integration
- UWSM compatibility mode

#### Sway

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "sway"
- `$WAYLAND_DISPLAY` is set

**Primary Tool:** `grimblast`
**Fallback Tool:** `grim` + `slurp`

**Configuration:**
```bash
# grimblast configuration
grimblast save area /tmp/screenshot.png

# grim + slurp fallback
grim -g "$(slurp)" /tmp/screenshot.png
```

**Features:**
- Native Sway integration
- Multiple capture modes (area, window, screen)
- Automatic clipboard integration

#### KDE Plasma (Wayland)

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "KDE"
- `$WAYLAND_DISPLAY` is set

**Primary Tool:** `spectacle`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# spectacle configuration
spectacle -r -b -n -o /tmp/screenshot.png

# flameshot fallback
flameshot gui --raw > /tmp/screenshot.png
```

**Features:**
- Native KDE integration
- Region selection with KDE styling
- Multiple output formats

#### GNOME (Wayland)

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "GNOME"
- `$WAYLAND_DISPLAY` is set

**Primary Tool:** `grim` + `slurp`
**Fallback Tool:** `grimblast`

**Configuration:**
```bash
# grim + slurp configuration
grim -g "$(slurp)" /tmp/screenshot.png

# grimblast fallback
grimblast save area /tmp/screenshot.png
```

**Features:**
- Native Wayland support
- Region selection with GNOME styling
- Integration with GNOME Shell

### X11 Environments

#### GNOME (X11)

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "GNOME"
- `$DISPLAY` is set

**Primary Tool:** `gnome-screenshot`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# gnome-screenshot configuration
gnome-screenshot -a -f /tmp/screenshot.png

# flameshot fallback
flameshot gui -p /tmp/screenshot.png
```

**Features:**
- Native GNOME integration
- GNOME Shell notifications
- Automatic clipboard integration

#### KDE Plasma (X11)

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "KDE"
- `$DISPLAY` is set

**Primary Tool:** `spectacle`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# spectacle configuration
spectacle --region --background --nonotify --output /tmp/screenshot.png

# flameshot fallback
flameshot gui -p /tmp/screenshot.png
```

**Features:**
- Native KDE integration
- KDE Plasma notifications
- Multiple capture modes

#### XFCE

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "XFCE"
- `$DISPLAY` is set

**Primary Tool:** `xfce4-screenshooter`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# xfce4-screenshooter configuration
xfce4-screenshooter -r -s /tmp/screenshot.png

# flameshot fallback
flameshot gui -p /tmp/screenshot.png
```

**Features:**
- Native XFCE integration
- XFCE panel integration
- Lightweight and fast

#### Cinnamon

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "X-Cinnamon"
- `$DISPLAY` is set

**Primary Tool:** `gnome-screenshot`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# gnome-screenshot configuration
gnome-screenshot -a -f /tmp/screenshot.png

# flameshot fallback
flameshot gui -p /tmp/screenshot.png
```

**Features:**
- GNOME-based screenshot tool
- Cinnamon desktop integration
- Familiar GNOME interface

#### MATE

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "MATE"
- `$DISPLAY` is set

**Primary Tool:** `mate-screenshot`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# mate-screenshot configuration
mate-screenshot -a -f /tmp/screenshot.png

# flameshot fallback
flameshot gui -p /tmp/screenshot.png
```

**Features:**
- Native MATE integration
- GNOME 2-style interface
- Lightweight and efficient

#### Deepin

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "Deepin"
- `$DISPLAY` is set

**Primary Tool:** `deepin-screenshot`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# deepin-screenshot configuration
deepin-screenshot -s /tmp/screenshot.png

# flameshot fallback
flameshot gui -p /tmp/screenshot.png
```

**Features:**
- Native Deepin integration
- Modern interface design
- Advanced annotation tools

#### Cosmic

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "COSMIC"
- `$DISPLAY` is set

**Primary Tool:** `gnome-screenshot`
**Fallback Tool:** `flameshot`

**Configuration:**
```bash
# gnome-screenshot configuration
gnome-screenshot -a -f /tmp/screenshot.png

# flameshot fallback
flameshot gui -p /tmp/screenshot.png
```

**Features:**
- GNOME-based screenshot tool
- Cosmic desktop integration
- Modern Rust-based desktop

### Minimal Window Managers

#### i3

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "i3"
- `$DISPLAY` is set

**Primary Tool:** `flameshot`
**Fallback Tool:** `scrot`

**Configuration:**
```bash
# flameshot configuration
flameshot gui -p /tmp/screenshot.png

# scrot fallback
scrot -s /tmp/screenshot.png
```

**Features:**
- Lightweight and fast
- Minimal resource usage
- Keyboard-driven interface

#### Openbox

**Detection:**
- `$XDG_CURRENT_DESKTOP` contains "openbox"
- `$DISPLAY` is set

**Primary Tool:** `flameshot`
**Fallback Tool:** `scrot`

**Configuration:**
```bash
# flameshot configuration
flameshot gui -p /tmp/screenshot.png

# scrot fallback
scrot -s /tmp/screenshot.png
```

**Features:**
- Lightweight and fast
- Minimal resource usage
- Highly customizable

## Screenshot Tool Selection

### Automatic Selection

HyprUpld automatically selects the best screenshot tool based on:

1. **Desktop Environment**: Detected from environment variables
2. **Display Server**: Wayland vs X11
3. **Tool Availability**: Checks if tools are installed
4. **User Preference**: Previously selected tools

### Manual Selection

You can manually select your preferred screenshot tool:

```bash
# Reset settings to force tool selection
hyprupld -reset

# Run hyprupld and select your preferred tool when prompted
hyprupld
```

### Tool Configuration

#### Saving Tool Preferences

HyprUpld saves your tool preferences in `~/.config/hyprupld/settings.json`:

```json
{
  "hyprland_tool": "hyprshot",
  "kde_tool": "spectacle",
  "gnome_tool": "gnome-screenshot",
  "xfce_tool": "xfce4-screenshooter",
  "wayland_tool": "grimblast"
}
```

#### Tool-Specific Settings

Each tool has specific configuration options:

**hyprshot:**
```bash
# Basic usage
hyprshot -m region -z -s -o /tmp -f screenshot.png

# Custom options
hyprshot -m region -z -s -o /custom/path -f custom_name.png
```

**grimblast:**
```bash
# Area selection
grimblast save area /tmp/screenshot.png

# Window selection
grimblast save window /tmp/screenshot.png

# Screen selection
grimblast save screen /tmp/screenshot.png
```

**flameshot:**
```bash
# GUI mode
flameshot gui -p /tmp/screenshot.png

# Full screen
flameshot full -p /tmp/screenshot.png

# Area selection
flameshot gui --raw > /tmp/screenshot.png
```

## Clipboard Integration

### Wayland Clipboard

**Tools:** `wl-clipboard`
**Commands:**
```bash
# Copy to clipboard
cat image.png | wl-copy

# Paste from clipboard
wl-paste > image.png

# List available formats
wl-paste --list-types
```

### X11 Clipboard

**Tools:** `xclip`
**Commands:**
```bash
# Copy to clipboard
xclip -selection clipboard -t image/png -i image.png

# Paste from clipboard
xclip -selection clipboard -t image/png -o > image.png

# List available formats
xclip -selection clipboard -t TARGETS -o
```

### macOS Clipboard

**Tools:** `pbcopy`/`pbpaste`
**Commands:**
```bash
# Copy to clipboard
osascript -e 'set the clipboard to (read (POSIX file "image.png") as PNG picture)'

# Paste from clipboard
osascript -e 'the clipboard' > image.png
```

## Audio Integration

### Audio Player Detection

HyprUpld detects available audio players and prompts for selection:

**Supported Players:**
- `paplay` - PulseAudio Sound Player
- `play` - SoX Sound Player
- `aplay` - ALSA Sound Player
- `mpg123` - MPG123 Audio Player

**Detection Logic:**
```bash
# Check available players
for player in paplay play aplay mpg123; do
    if command -v "$player" &>/dev/null; then
        available_players+=("$player")
    fi
done
```

### Audio Configuration

**Settings File:**
```json
{
  "preferred_audio_player": "paplay"
}
```

**Test Audio:**
```bash
# Test each player
paplay /usr/local/share/hyprupld/sounds/sstaken.mp3
play -q /usr/local/share/hyprupld/sounds/sstaken.mp3
aplay -q /usr/local/share/hyprupld/sounds/sstaken.mp3
mpg123 -q /usr/local/share/hyprupld/sounds/sstaken.mp3
```

## UWSM Compatibility

### UWSM Detection

HyprUpld detects UWSM (User Wayland Session Manager) environments:

```bash
# Check for UWSM
systemctl --user is-active uwsm.service
echo $UWSM_MANAGED
ls -la ${XDG_RUNTIME_DIR:-}/uwsm.lock
```

### UWSM Mode

Enable UWSM compatibility mode:

```bash
# Enable UWSM mode
hyprupld -uwsm

# UWSM mode with debug
hyprupld -uwsm -debug
```

**Features:**
- Enhanced error handling
- Retry logic for screenshot capture
- More resilient clipboard operations
- Better logging for UWSM sessions

## Troubleshooting Desktop Environment Issues

### Detection Problems

**Check Environment Variables:**
```bash
echo $XDG_CURRENT_DESKTOP
echo $WAYLAND_DISPLAY
echo $DISPLAY
echo $DESKTOP_SESSION
```

**Check Running Processes:**
```bash
ps aux | grep -E "(gnome|kde|xfce|mate|cinnamon|deepin|cosmic|hyprland|sway)"
```

### Tool Installation Issues

**Install Missing Tools:**

**Ubuntu/Debian:**
```bash
sudo apt install flameshot spectacle gnome-screenshot xfce4-screenshooter
```

**Arch Linux:**
```bash
sudo pacman -S flameshot spectacle gnome-screenshot xfce4-screenshooter
```

**Fedora:**
```bash
sudo dnf install flameshot spectacle gnome-screenshot xfce4-screenshooter
```

### Tool-Specific Issues

**hyprshot Issues:**
```bash
# Check hyprshot installation
which hyprshot

# Install from source
git clone https://github.com/Gustash/hyprshot.git
cd hyprshot
sudo make install
```

**grimblast Issues:**
```bash
# Check grimblast installation
which grimblast

# Install from source
git clone https://github.com/hyprwm/contrib.git
cd contrib/grimblast
sudo make install
```

**flameshot Issues:**
```bash
# Check flameshot installation
which flameshot

# Test flameshot
flameshot gui -p /tmp/test.png
```

## Performance Optimization

### Tool Selection for Performance

**Fastest Tools:**
1. `hyprshot` (Hyprland)
2. `grimblast` (Sway)
3. `grim` + `slurp` (Wayland)
4. `flameshot` (Cross-platform)

**Resource Usage:**
- **Lightweight:** `grim`, `scrot`
- **Medium:** `flameshot`, `spectacle`
- **Heavy:** `gnome-screenshot` (with GUI)

### Optimization Tips

1. **Use Native Tools:** Prefer tools designed for your desktop environment
2. **Avoid GUI Tools:** Use command-line tools when possible for speed
3. **Minimize Dependencies:** Choose tools with fewer dependencies
4. **Cache Tool Selection:** Let HyprUpld remember your preferred tools

## Best Practices

### Tool Selection

1. **Test Multiple Tools:** Try different tools to find the best for your setup
2. **Consider Performance:** Choose faster tools for frequent use
3. **Check Integration:** Ensure tools integrate well with your desktop
4. **Fallback Options:** Always have fallback tools available

### Configuration

1. **Save Preferences:** Let HyprUpld remember your tool choices
2. **Regular Testing:** Test screenshot functionality after updates
3. **Monitor Logs:** Check debug logs for tool-related issues
4. **Update Tools:** Keep screenshot tools updated

### Troubleshooting

1. **Check Detection:** Verify desktop environment detection
2. **Test Tools Manually:** Test screenshot tools outside of HyprUpld
3. **Check Permissions:** Ensure tools have necessary permissions
4. **Review Logs:** Use debug mode to identify issues

---

**Note**: HyprUpld's desktop environment detection is designed to be automatic and reliable. If you encounter issues, the debug mode will provide detailed information about the detection process. 