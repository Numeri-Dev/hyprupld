# Debug Guide

Advanced debugging and logging information for HyprUpld, designed for developers and power users who need detailed insights into the script's operation.

## Overview

HyprUpld provides comprehensive debugging capabilities to help identify and resolve issues. The debug system includes multiple levels of logging, detailed error reporting, and tools for troubleshooting complex problems.

## Debug Mode

### Enabling Debug Mode

#### Command Line Debug Mode
```bash
# Enable debug mode for a single run
hyprupld -debug

# Debug mode with specific service
hyprupld -debug -imgur

# Debug mode with save option
hyprupld -debug -s
```

#### Environment Variable Debug Mode
```bash
# Enable debug mode via environment variable
export HYPRUPLD_DEBUG=1
hyprupld

# Combine with other options
export HYPRUPLD_DEBUG=1
hyprupld -imgur -s
```

#### Strict Debug Mode
```bash
# Enable strict error handling with debug
hyprupld -strict -debug
```

### What Debug Mode Shows

#### System Information
```
[DEBUG][2024-01-15 14:30:22.123][check_system_requirements:45] Detected macOS system
[DEBUG][2024-01-15 14:30:22.124][check_system_requirements:46] macOS version: 14.2.1
[DEBUG][2024-01-15 14:30:22.125][detect_display_server:234] Display server: wayland
[DEBUG][2024-01-15 14:30:22.126][detect_package_managers:267] Found package manager: pacman
```

#### Function Calls and Line Numbers
```
[DEBUG][2024-01-15 14:30:22.127][take_screenshot:456] Starting screenshot capture
[DEBUG][2024-01-15 14:30:22.128][take_wayland_screenshot:478] Using hyprshot for Hyprland
[DEBUG][2024-01-15 14:30:22.129][take_wayland_screenshot:485] Executing: hyprshot -m region -z -s -o /tmp -f screenshot.png
```

#### Variable Values
```
[DEBUG][2024-01-15 14:30:22.130][upload_screenshot:567] Service: imgur
[DEBUG][2024-01-15 14:30:22.131][upload_screenshot:568] URL: https://api.imgur.com/3/upload
[DEBUG][2024-01-15 14:30:22.132][upload_screenshot:569] Auth required: false
```

#### Error Information
```
[ERROR][2024-01-15 14:30:22.133][upload_screenshot:570] Failed to upload screenshot
[ERROR][2024-01-15 14:30:22.134][upload_screenshot:571] HTTP status: 429
[ERROR][2024-01-15 14:30:22.135][upload_screenshot:572] Response: {"error":"Rate limit exceeded"}
```

## Debug Log File

### Log File Location
```
~/.config/hyprupld/debug.log
```

### Log File Structure

#### Timestamp Format
```
[DEBUG][YYYY-MM-DD HH:MM:SS.mmm][function:line] message
```

#### Log Levels
- `[DEBUG]` - Detailed debugging information
- `[INFO]` - General information
- `[SUCCESS]` - Successful operations
- `[WARNING]` - Warning messages
- `[ERROR]` - Error messages
- `[STEP]` - Major operation steps

### Log File Management

#### Viewing Logs
```bash
# View entire log file
cat ~/.config/hyprupld/debug.log

# View recent entries
tail -f ~/.config/hyprupld/debug.log

# View last 50 lines
tail -50 ~/.config/hyprupld/debug.log

# View logs from specific date
grep "2024-01-15" ~/.config/hyprupld/debug.log
```

#### Searching Logs
```bash
# Search for errors
grep -i "error" ~/.config/hyprupld/debug.log

# Search for specific function
grep "take_screenshot" ~/.config/hyprupld/debug.log

# Search for specific service
grep "imgur" ~/.config/hyprupld/debug.log

# Search for warnings
grep -i "warning" ~/.config/hyprupld/debug.log
```

#### Log Rotation
```bash
# Archive old log
mv ~/.config/hyprupld/debug.log ~/.config/hyprupld/debug.log.old

# Compress old log
gzip ~/.config/hyprupld/debug.log.old

# Remove old logs
find ~/.config/hyprupld/ -name "debug.log.*" -mtime +30 -delete
```

## Debug Information Categories

### System Detection Debug

#### OS Detection
```bash
# Check OS detection
grep "Detected.*system" ~/.config/hyprupld/debug.log

# Check macOS version detection
grep "macOS version" ~/.config/hyprupld/debug.log

# Check Linux distribution detection
grep "Detected distribution" ~/.config/hyprupld/debug.log
```

#### Desktop Environment Detection
```bash
# Check desktop environment detection
grep "Detected desktop environment" ~/.config/hyprupld/debug.log

# Check display server detection
grep "Display server" ~/.config/hyprupld/debug.log

# Check environment variables
grep "XDG_CURRENT_DESKTOP" ~/.config/hyprupld/debug.log
grep "WAYLAND_DISPLAY" ~/.config/hyprupld/debug.log
grep "DISPLAY" ~/.config/hyprupld/debug.log
```

#### Package Manager Detection
```bash
# Check package manager detection
grep "Found package manager" ~/.config/hyprupld/debug.log

# Check package manager cache
grep "Using cached package manager" ~/.config/hyprupld/debug.log

# Check package installation
grep "Installing.*packages" ~/.config/hyprupld/debug.log
```

### Screenshot Tool Debug

#### Tool Detection
```bash
# Check screenshot tool detection
grep "Using.*for.*environment" ~/.config/hyprupld/debug.log

# Check tool availability
grep "is already installed" ~/.config/hyprupld/debug.log
grep "is not installed" ~/.config/hyprupld/debug.log

# Check tool selection
grep "No preferred.*tool saved" ~/.config/hyprupld/debug.log
```

#### Screenshot Execution
```bash
# Check screenshot commands
grep "Executing:" ~/.config/hyprupld/debug.log

# Check screenshot success
grep "Screenshot taken successfully" ~/.config/hyprupld/debug.log

# Check screenshot failures
grep "Failed to take screenshot" ~/.config/hyprupld/debug.log
```

#### UWSM Mode Debug
```bash
# Check UWSM detection
grep "Detected UWSM managed session" ~/.config/hyprupld/debug.log

# Check UWSM retry logic
grep "Screenshot attempt.*failed, retrying" ~/.config/hyprupld/debug.log

# Check UWSM mode status
grep "Running with UWSM compatibility mode" ~/.config/hyprupld/debug.log
```

### Upload Service Debug

#### Service Configuration
```bash
# Check service detection
grep "Uploading screenshot to" ~/.config/hyprupld/debug.log

# Check authentication
grep "Retrieving authentication key" ~/.config/hyprupld/debug.log
grep "Using saved auth key" ~/.config/hyprupld/debug.log

# Check URL construction
grep "URL:" ~/.config/hyprupld/debug.log
```

#### Network Requests
```bash
# Check curl commands
grep "curl.*-X POST" ~/.config/hyprupld/debug.log

# Check HTTP status codes
grep "HTTP status:" ~/.config/hyprupld/debug.log

# Check response parsing
grep "Response:" ~/.config/hyprupld/debug.log
grep "Failed to extract URL" ~/.config/hyprupld/debug.log
```

#### Service-Specific Debug
```bash
# Check imgur-specific debug
grep "imgur" ~/.config/hyprupld/debug.log

# Check guns.lol-specific debug
grep "guns" ~/.config/hyprupld/debug.log

# Check custom service debug
grep "zipline\|xbackbone" ~/.config/hyprupld/debug.log
```

### Clipboard Debug

#### Clipboard Tool Detection
```bash
# Check clipboard tool detection
grep "Using.*for.*clipboard operations" ~/.config/hyprupld/debug.log

# Check clipboard tool availability
grep "wl-copy\|xclip.*not found" ~/.config/hyprupld/debug.log
```

#### Clipboard Operations
```bash
# Check clipboard copy operations
grep "Direct image copied to clipboard" ~/.config/hyprupld/debug.log

# Check clipboard paste operations
grep "URL copied to clipboard" ~/.config/hyprupld/debug.log

# Check clipboard failures
grep "Failed to copy.*clipboard" ~/.config/hyprupld/debug.log
```

### Audio Debug

#### Audio Player Detection
```bash
# Check audio player detection
grep "Audio player not configured" ~/.config/hyprupld/debug.log

# Check audio player selection
grep "Set preferred audio player" ~/.config/hyprupld/debug.log

# Check audio player availability
grep "No supported audio players found" ~/.config/hyprupld/debug.log
```

#### Audio Playback
```bash
# Check sound file locations
grep "Sound file not found" ~/.config/hyprupld/debug.log

# Check audio playback
grep "Playing sound" ~/.config/hyprupld/debug.log

# Check audio failures
grep "Failed to play sound" ~/.config/hyprupld/debug.log
```

## Advanced Debugging Techniques

### Function-Level Debugging

#### Trace Function Calls
```bash
# Enable function tracing
export BASH_TRACE=1
hyprupld -debug

# Or use bash -x
bash -x hyprupld -debug
```

#### Check Function Stack
```bash
# View function call stack in logs
grep "FUNCNAME" ~/.config/hyprupld/debug.log

# Check line numbers
grep "BASH_LINENO" ~/.config/hyprupld/debug.log
```

### Environment Debugging

#### Check Environment Variables
```bash
# Log all environment variables
env | grep -E "(XDG|WAYLAND|DISPLAY|DESKTOP)" >> ~/.config/hyprupld/debug.log

# Check specific variables
echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP" >> ~/.config/hyprupld/debug.log
echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY" >> ~/.config/hyprupld/debug.log
echo "DISPLAY: $DISPLAY" >> ~/.config/hyprupld/debug.log
```

#### Check System Information
```bash
# Log system information
uname -a >> ~/.config/hyprupld/debug.log
lsb_release -a >> ~/.config/hyprupld/debug.log 2>/dev/null || echo "No lsb_release" >> ~/.config/hyprupld/debug.log
```

### Network Debugging

#### Test Network Connectivity
```bash
# Test upload service connectivity
curl -I https://api.imgur.com/3/upload >> ~/.config/hyprupld/debug.log 2>&1

# Test with verbose output
curl -v https://api.imgur.com/3/upload >> ~/.config/hyprupld/debug.log 2>&1
```

#### Check DNS Resolution
```bash
# Test DNS resolution
nslookup api.imgur.com >> ~/.config/hyprupld/debug.log 2>&1

# Test with dig
dig api.imgur.com >> ~/.config/hyprupld/debug.log 2>&1
```

### File System Debugging

#### Check File Permissions
```bash
# Check configuration directory permissions
ls -la ~/.config/hyprupld/ >> ~/.config/hyprupld/debug.log

# Check script permissions
ls -la /usr/local/bin/hyprupld >> ~/.config/hyprupld/debug.log

# Check sound file permissions
ls -la /usr/local/share/hyprupld/sounds/ >> ~/.config/hyprupld/debug.log
```

#### Check File Contents
```bash
# Check settings file
cat ~/.config/hyprupld/settings.json >> ~/.config/hyprupld/debug.log

# Check package manager cache
cat ~/.config/hyprupld/pckmgrs.json >> ~/.config/hyprupld/debug.log
```

## Debug Scripts and Tools

### Custom Debug Scripts

#### System Information Script
```bash
#!/bin/bash
# debug-system.sh

echo "=== System Information ===" > debug-system.log
uname -a >> debug-system.log
echo "" >> debug-system.log

echo "=== Environment Variables ===" >> debug-system.log
env | grep -E "(XDG|WAYLAND|DISPLAY|DESKTOP)" >> debug-system.log
echo "" >> debug-system.log

echo "=== Package Managers ===" >> debug-system.log
which pacman apt-get dnf yay paru brew >> debug-system.log 2>&1
echo "" >> debug-system.log

echo "=== Screenshot Tools ===" >> debug-system.log
which hyprshot grimblast grim flameshot spectacle gnome-screenshot >> debug-system.log 2>&1
echo "" >> debug-system.log

echo "=== Clipboard Tools ===" >> debug-system.log
which wl-copy xclip >> debug-system.log 2>&1
echo "" >> debug-system.log

echo "=== Audio Players ===" >> debug-system.log
which paplay play aplay mpg123 >> debug-system.log 2>&1
```

#### Network Test Script
```bash
#!/bin/bash
# debug-network.sh

echo "=== Network Connectivity Test ===" > debug-network.log

services=("api.imgur.com" "guns.lol" "api.e-z.host" "upload.fakecrime.bio" "nest.rip" "pixelvault.co")

for service in "${services[@]}"; do
    echo "Testing $service..." >> debug-network.log
    curl -I "https://$service" >> debug-network.log 2>&1
    echo "" >> debug-network.log
done
```

### Debug Analysis Tools

#### Log Analyzer Script
```bash
#!/bin/bash
# analyze-logs.sh

LOG_FILE="$HOME/.config/hyprupld/debug.log"

echo "=== HyprUpld Log Analysis ==="
echo ""

echo "=== Error Summary ==="
grep -c "ERROR" "$LOG_FILE" 2>/dev/null || echo "No errors found"

echo "=== Warning Summary ==="
grep -c "WARNING" "$LOG_FILE" 2>/dev/null || echo "No warnings found"

echo "=== Most Common Functions ==="
grep -o "\[[^]]*\]" "$LOG_FILE" | grep -v "DEBUG\|INFO\|ERROR\|WARNING" | sort | uniq -c | sort -nr | head -10

echo "=== Recent Errors ==="
tail -50 "$LOG_FILE" | grep "ERROR" | tail -5
```

#### Performance Analysis Script
```bash
#!/bin/bash
# performance-test.sh

echo "=== HyprUpld Performance Test ===" > performance-test.log

# Test basic screenshot
echo "Testing basic screenshot..." >> performance-test.log
time (hyprupld -silent) >> performance-test.log 2>&1

echo "" >> performance-test.log

# Test upload (if imgur is available)
echo "Testing upload..." >> performance-test.log
time (hyprupld -silent -imgur) >> performance-test.log 2>&1

echo "" >> performance-test.log

# Test save
echo "Testing save..." >> performance-test.log
time (hyprupld -silent -s) >> performance-test.log 2>&1
```

## Debug Best Practices

### Logging Best Practices

1. **Use Appropriate Log Levels:**
   - `DEBUG` for detailed technical information
   - `INFO` for general operational information
   - `WARNING` for potential issues
   - `ERROR` for actual errors

2. **Include Context:**
   - Always include function names and line numbers
   - Include relevant variable values
   - Include system state information

3. **Avoid Sensitive Information:**
   - Never log API keys or passwords
   - Be careful with file paths that might contain sensitive data
   - Sanitize URLs and responses

### Debug Workflow

1. **Reproduce the Issue:**
   ```bash
   hyprupld -debug [options]
   ```

2. **Collect Information:**
   ```bash
   # Check recent logs
   tail -50 ~/.config/hyprupld/debug.log
   
   # Check for errors
   grep -i "error" ~/.config/hyprupld/debug.log | tail -10
   ```

3. **Analyze the Problem:**
   ```bash
   # Look for specific patterns
   grep "function_name" ~/.config/hyprupld/debug.log
   
   # Check system state
   grep "Detected.*system" ~/.config/hyprupld/debug.log
   ```

4. **Test Solutions:**
   ```bash
   # Test with different options
   hyprupld -debug -strict
   
   # Test with different services
   hyprupld -debug -imgur
   ```

### Debug Maintenance

1. **Regular Log Rotation:**
   ```bash
   # Rotate logs weekly
   mv ~/.config/hyprupld/debug.log ~/.config/hyprupld/debug.log.$(date +%Y%m%d)
   ```

2. **Monitor Log Size:**
   ```bash
   # Check log file size
   ls -lh ~/.config/hyprupld/debug.log
   
   # Compress old logs
   find ~/.config/hyprupld/ -name "debug.log.*" -exec gzip {} \;
   ```

3. **Clean Up Old Logs:**
   ```bash
   # Remove logs older than 30 days
   find ~/.config/hyprupld/ -name "debug.log.*" -mtime +30 -delete
   ```

## Common Debug Scenarios

### Screenshot Tool Issues

#### Tool Not Found
```bash
# Check tool availability
which hyprshot grimblast grim flameshot

# Check installation
pacman -Q hyprshot 2>/dev/null || echo "hyprshot not installed"

# Check PATH
echo $PATH | grep -o "[^:]*" | grep -E "(bin|local)"
```

#### Tool Execution Failure
```bash
# Test tool manually
hyprshot -m region -z -s -o /tmp -f test.png

# Check tool permissions
ls -la $(which hyprshot)

# Check tool dependencies
ldd $(which hyprshot)
```

### Upload Service Issues

#### Authentication Problems
```bash
# Check saved credentials
cat ~/.config/hyprupld/settings.json | grep -E "(auth|key)"

# Test authentication manually
curl -H "Authorization: your_key" https://api.service.com/upload
```

#### Network Problems
```bash
# Test connectivity
ping -c 3 api.imgur.com

# Test HTTPS
curl -I https://api.imgur.com/3/upload

# Check DNS
nslookup api.imgur.com
```

### Configuration Issues

#### Settings File Problems
```bash
# Validate JSON
python3 -c "import json; json.load(open('~/.config/hyprupld/settings.json'))"

# Check file permissions
ls -la ~/.config/hyprupld/settings.json

# Backup and reset
cp ~/.config/hyprupld/settings.json ~/.config/hyprupld/settings.json.backup
hyprupld -reset
```

---

**Note**: Debug mode provides extensive information but may impact performance. Use it only when troubleshooting issues or during development. 