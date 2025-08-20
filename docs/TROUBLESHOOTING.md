# Troubleshooting Guide

Comprehensive troubleshooting guide for HyprUpld, covering common issues, error messages, and their solutions.

## Quick Diagnostic Commands

Before diving into specific issues, run these diagnostic commands:

```bash
# Check if HyprUpld is installed and accessible
which hyprupld

# Check version and basic functionality
hyprupld

# Enable debug mode for detailed information
hyprupld -debug

# Check configuration directory
ls -la ~/.config/hyprupld/

# Check debug logs
tail -f ~/.config/hyprupld/debug.log
```

## Common Issues and Solutions

### Installation Issues

#### "Command not found: hyprupld"

**Symptoms:**
- `hyprupld: command not found` error
- Script not found in PATH

**Solutions:**

1. **Check if installed:**
   ```bash
   ls -la /usr/local/bin/hyprupld
   ls -la ~/.local/bin/hyprupld
   ```

2. **Reinstall:**
   ```bash
   # Using the install script
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/NumeriDev/hyprupld/main/install.sh)"
   ```

3. **Check PATH:**
   ```bash
   echo $PATH
   # Ensure /usr/local/bin or ~/.local/bin is in PATH
   ```

4. **Manual installation:**
   ```bash
   git clone https://github.com/Numeri-Dev/hyprupld.git
   cd hyprupld
   bash compile.sh
   bash install_scripts.sh
   ```

#### Permission Denied Errors

**Symptoms:**
- `Permission denied` when running hyprupld
- Cannot execute script

**Solutions:**

1. **Fix permissions:**
   ```bash
   sudo chmod +x /usr/local/bin/hyprupld
   ```

2. **Check file ownership:**
   ```bash
   ls -la /usr/local/bin/hyprupld
   sudo chown $USER:$USER /usr/local/bin/hyprupld
   ```

### Screenshot Tool Issues

#### "Screenshot tool not found"

**Symptoms:**
- Error about missing screenshot tool
- Screenshot fails to capture

**Solutions:**

1. **Check available tools:**
   ```bash
   which hyprshot grimblast grim flameshot spectacle gnome-screenshot
   ```

2. **Install missing tools:**

   **For hyprshot (Hyprland):**
   ```bash
   # Arch Linux
   yay -S hyprshot
   
   # From source
   git clone https://github.com/Gustash/hyprshot.git
   cd hyprshot
   sudo make install
   ```

   **For grimblast (Sway):**
   ```bash
   git clone https://github.com/hyprwm/contrib.git
   cd contrib/grimblast
   sudo make install
   ```

   **For other tools:**
   ```bash
   # Ubuntu/Debian
   sudo apt install flameshot spectacle gnome-screenshot
   
   # Arch Linux
   sudo pacman -S flameshot spectacle gnome-screenshot
   ```

3. **Force tool selection:**
   ```bash
   # Reset settings to force tool selection
   hyprupld -reset
   ```

#### Screenshot Capture Fails

**Symptoms:**
- Screenshot tool runs but no image is captured
- Empty or corrupted screenshot files

**Solutions:**

1. **Check display server:**
   ```bash
   echo $WAYLAND_DISPLAY
   echo $DISPLAY
   ```

2. **Test screenshot tool manually:**
   ```bash
   # Test hyprshot
   hyprshot -m region -z -s -o /tmp -f test.png
   
   # Test grimblast
   grimblast save area /tmp/test.png
   
   # Test flameshot
   flameshot gui -p /tmp/test.png
   ```

3. **Check permissions:**
   ```bash
   # For Wayland
   ls -la /dev/video*
   
   # For X11
   xhost +local:
   ```

4. **Enable debug mode:**
   ```bash
   hyprupld -debug
   ```

### Clipboard Issues

#### "Clipboard utility not found"

**Symptoms:**
- Error about missing clipboard tool
- Cannot copy to clipboard

**Solutions:**

1. **Install clipboard utilities:**

   **For Wayland:**
   ```bash
   # Ubuntu/Debian
   sudo apt install wl-clipboard
   
   # Arch Linux
   sudo pacman -S wl-clipboard
   ```

   **For X11:**
   ```bash
   # Ubuntu/Debian
   sudo apt install xclip
   
   # Arch Linux
   sudo pacman -S xclip
   ```

2. **Test clipboard manually:**
   ```bash
   # Wayland
   echo "test" | wl-copy
   wl-paste
   
   # X11
   echo "test" | xclip -selection clipboard
   xclip -selection clipboard -o
   ```

#### Clipboard Not Working

**Symptoms:**
- Screenshot taken but not copied to clipboard
- Cannot paste screenshot

**Solutions:**

1. **Check clipboard content:**
   ```bash
   # Wayland
   wl-paste --list-types
   
   # X11
   xclip -selection clipboard -t TARGETS -o
   ```

2. **Test with different formats:**
   ```bash
   # Force PNG format
   xclip -selection clipboard -t image/png -i screenshot.png
   ```

3. **Check clipboard manager conflicts:**
   - Disable clipboard managers temporarily
   - Check for conflicting clipboard utilities

### Audio Player Issues

#### "No audio player configured"

**Symptoms:**
- Audio player selection dialog appears repeatedly
- No sound feedback

**Solutions:**

1. **Install audio players:**
   ```bash
   # Ubuntu/Debian
   sudo apt install pulseaudio-utils sox alsa-utils mpg123
   
   # Arch Linux
   sudo pacman -S pulseaudio-utils sox alsa-utils mpg123
   ```

2. **Check available players:**
   ```bash
   which paplay play aplay mpg123
   ```

3. **Reset audio configuration:**
   ```bash
   hyprupld -reset
   ```

4. **Test audio manually:**
   ```bash
   # Test each player
   paplay /usr/local/share/hyprupld/sounds/sstaken.mp3
   play /usr/local/share/hyprupld/sounds/sstaken.mp3
   aplay /usr/local/share/hyprupld/sounds/sstaken.mp3
   mpg123 /usr/local/share/hyprupld/sounds/sstaken.mp3
   ```

### Upload Service Issues

#### Authentication Errors

**Symptoms:**
- "Authentication failed" errors
- API key rejected

**Solutions:**

1. **Check saved credentials:**
   ```bash
   cat ~/.config/hyprupld/settings.json
   ```

2. **Reset credentials:**
   ```bash
   hyprupld -reset
   ```

3. **Verify API key:**
   - Check the service's website for correct API key
   - Ensure the key is active and not expired
   - Test the key manually with curl

4. **Test service manually:**
   ```bash
   # Example for guns.lol
   curl -X POST \
     -F "file=@screenshot.png" \
     -F "key=your_api_key" \
     https://guns.lol/api/upload
   ```

#### Network Errors

**Symptoms:**
- "Connection failed" errors
- Timeout errors
- Upload fails

**Solutions:**

1. **Check internet connectivity:**
   ```bash
   ping -c 3 google.com
   curl -I https://guns.lol/api/upload
   ```

2. **Check firewall/proxy:**
   ```bash
   # Test with curl
   curl -v https://guns.lol/api/upload
   
   # Check proxy settings
   echo $http_proxy
   echo $https_proxy
   ```

3. **Try different service:**
   ```bash
   # Test with imgur (no auth required)
   hyprupld -imgur
   ```

4. **Enable debug mode:**
   ```bash
   hyprupld -debug -guns
   ```

#### Rate Limiting

**Symptoms:**
- "Rate limit exceeded" errors
- Uploads fail after multiple attempts

**Solutions:**

1. **Wait and retry:**
   - Wait a few minutes before trying again
   - Some services have per-minute or per-hour limits

2. **Use different service:**
   ```bash
   # Switch to imgur for higher limits
   hyprupld -imgur
   ```

3. **Check service status:**
   - Visit the service's status page
   - Check if the service is experiencing issues

### Configuration Issues

#### Settings File Corruption

**Symptoms:**
- "Invalid settings file format" error
- Configuration not working

**Solutions:**

1. **Check settings file:**
   ```bash
   cat ~/.config/hyprupld/settings.json
   ```

2. **Validate JSON:**
   ```bash
   python3 -c "import json; json.load(open('~/.config/hyprupld/settings.json'))"
   ```

3. **Reset configuration:**
   ```bash
   hyprupld -reset
   ```

4. **Backup and recreate:**
   ```bash
   cp ~/.config/hyprupld/settings.json ~/.config/hyprupld/settings.json.backup
   rm ~/.config/hyprupld/settings.json
   hyprupld
   ```

#### Package Manager Detection Issues

**Symptoms:**
- "No package manager found" errors
- Cannot install dependencies

**Solutions:**

1. **Check package manager cache:**
   ```bash
   cat ~/.config/hyprupld/pckmgrs.json
   ```

2. **Reset package manager detection:**
   ```bash
   rm ~/.config/hyprupld/pckmgrs.json
   hyprupld -debug
   ```

3. **Install dependencies manually:**
   ```bash
   # Ubuntu/Debian
   sudo apt install curl python3 zenity wl-clipboard flameshot
   
   # Arch Linux
   sudo pacman -S curl python3 zenity wl-clipboard flameshot
   ```

### Desktop Environment Issues

#### Wrong Screenshot Tool Selected

**Symptoms:**
- Screenshot tool doesn't work for your environment
- Wrong tool being used

**Solutions:**

1. **Check detected environment:**
   ```bash
   echo $XDG_CURRENT_DESKTOP
   echo $WAYLAND_DISPLAY
   echo $DISPLAY
   ```

2. **Reset tool selection:**
   ```bash
   hyprupld -reset
   ```

3. **Force tool selection:**
   - Run hyprupld and select the correct tool when prompted
   - The selection will be saved for future use

#### UWSM Compatibility Issues

**Symptoms:**
- Screenshot fails in UWSM environment
- Unstable behavior

**Solutions:**

1. **Enable UWSM mode:**
   ```bash
   hyprupld -uwsm
   ```

2. **Check UWSM session:**
   ```bash
   systemctl --user is-active uwsm.service
   echo $UWSM_MANAGED
   ```

3. **Use debug mode with UWSM:**
   ```bash
   hyprupld -uwsm -debug
   ```

### macOS Specific Issues

#### Screenshot Capture Issues

**Symptoms:**
- screencapture fails
- Permission denied errors

**Solutions:**

1. **Check screencapture:**
   ```bash
   which screencapture
   screencapture -i /tmp/test.png
   ```

2. **Check permissions:**
   - Go to System Preferences → Security & Privacy → Privacy
   - Ensure terminal has screen recording permissions

3. **Check macOS version:**
   ```bash
   sw_vers -productVersion
   ```

#### Clipboard Issues

**Symptoms:**
- Cannot copy to clipboard
- pbcopy/pbpaste errors

**Solutions:**

1. **Test clipboard:**
   ```bash
   echo "test" | pbcopy
   pbpaste
   ```

2. **Check clipboard permissions:**
   - Ensure terminal has clipboard access permissions

## Debug Mode

### Enabling Debug Mode

```bash
hyprupld -debug
```

### What Debug Mode Shows

- **System Information:**
  - OS detection
  - Desktop environment detection
  - Display server detection
  - Package manager detection

- **Process Information:**
  - Function calls with line numbers
  - Variable values
  - Command execution
  - Error stack traces

- **Network Information:**
  - Upload requests and responses
  - HTTP status codes
  - Response headers and body
  - Network timing

### Debug Log File

Debug information is also written to `~/.config/hyprupld/debug.log`:

```bash
# View recent logs
tail -f ~/.config/hyprupld/debug.log

# Search for errors
grep -i error ~/.config/hyprupld/debug.log

# Search for specific service
grep -i guns ~/.config/hyprupld/debug.log
```

## Getting Help

### Before Asking for Help

1. **Enable debug mode:**
   ```bash
   hyprupld -debug
   ```

2. **Collect information:**
   ```bash
   # System information
   uname -a
   echo $XDG_CURRENT_DESKTOP
   echo $WAYLAND_DISPLAY
   echo $DISPLAY
   
   # HyprUpld information
   hyprupld
   ls -la ~/.config/hyprupld/
   ```

3. **Check logs:**
   ```bash
   tail -20 ~/.config/hyprupld/debug.log
   ```

### Where to Get Help

1. **GitHub Issues**: [Create an issue](https://github.com/Numeri-Dev/hyprupld/issues)
2. **GitHub Discussions**: [Ask in discussions](https://github.com/Numeri-Dev/hyprupld/discussions)
3. **Documentation**: Check this troubleshooting guide and other docs

### Information to Include

When reporting an issue, include:

- **System information**: OS, desktop environment, display server
- **HyprUpld version**: Output of `hyprupld`
- **Debug output**: Run with `-debug` flag
- **Error messages**: Exact error messages
- **Steps to reproduce**: How to trigger the issue
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens

## Prevention

### Regular Maintenance

1. **Keep updated:**
   ```bash
   hyprupld -update
   ```

2. **Check dependencies:**
   ```bash
   # Verify screenshot tools
   which hyprshot grimblast grim flameshot spectacle
   
   # Verify clipboard tools
   which wl-copy xclip
   
   # Verify audio players
   which paplay play aplay mpg123
   ```

3. **Monitor logs:**
   ```bash
   # Check for errors
   grep -i error ~/.config/hyprupld/debug.log | tail -10
   ```

### Best Practices

1. **Use debug mode for testing:**
   ```bash
   hyprupld -debug -imgur
   ```

2. **Test services manually:**
   ```bash
   # Test upload service
   curl -I https://guns.lol/api/upload
   ```

3. **Keep backups:**
   ```bash
   # Backup configuration
   cp ~/.config/hyprupld/settings.json ~/.config/hyprupld/settings.json.backup
   ```

4. **Use stable services:**
   - Prefer established services (imgur, guns.lol)
   - Test new services before relying on them

---

**Note**: If you encounter an issue not covered in this guide, please create a GitHub issue with detailed information including debug output. 