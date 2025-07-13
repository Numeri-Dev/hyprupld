# API Reference

Technical reference for HyprUpld's functions, architecture, and internal APIs. This document is intended for developers and advanced users who need to understand the script's internal structure.

## Architecture Overview

### Script Structure

HyprUpld is a monolithic bash script with the following architectural components:

```
Scripts/hyprupld.sh
├── Configuration Section (lines 1-150)
│   ├── Constants and Variables
│   ├── Environment Setup
│   └── Service Configurations
├── Function Definitions (lines 151-800)
│   ├── Logging Functions
│   ├── System Detection Functions
│   ├── Screenshot Functions
│   ├── Upload Functions
│   ├── Configuration Functions
│   └── Utility Functions
└── Main Execution Logic (lines 801-1944)
    ├── Initialization
    ├── Argument Parsing
    ├── Core Logic
    └── Cleanup
```

### Execution Flow

```
main()
├── initialize_script()
│   ├── check_system_requirements()
│   ├── check_basic_dependencies()
│   └── ensure_config_dir()
├── parse_arguments()
├── detect_uwsm_session()
├── get_authentication() (if needed)
├── take_screenshot()
└── handle_upload()
```

## Configuration Constants

### Core Constants

```bash
# Configuration paths
readonly CONFIG_DIR="${HOME}/.config/hyprupld"
readonly SETTINGS_FILE="${CONFIG_DIR}/settings.json"
readonly PCKMGRS_FILE="${CONFIG_DIR}/pckmgrs.json"

# Temporary files
readonly TEMP_DIR="/tmp"
readonly SCREENSHOT_FILE="${TEMP_DIR}/screenshot.png"
readonly UPLOAD_RESPONSE="${TEMP_DIR}/upload.json"

# Version information
readonly VERSION="hyprupld-dev"

# Sound file paths
readonly SOUND_DIR="/usr/local/share/hyprupld/sounds"
readonly SCREENSHOT_SOUND="${SOUND_DIR}/sstaken.mp3"
readonly CLIPBOARD_SOUND="${SOUND_DIR}/clipboard.mp3"
readonly LINK_SOUND="${SOUND_DIR}/link.mp3"
```

### Environment Variables

```bash
# Override default config directory
export HYPRUPLD_CONFIG="/custom/path"

# Enable debug output
export HYPRUPLD_DEBUG=1
```

## Function Reference

### Logging Functions

#### `log_debug(message)`
**Purpose**: Output debug information when debug mode is enabled
**Parameters**: `message` - Debug message to output
**Returns**: None
**Example**:
```bash
log_debug "Starting screenshot capture"
```

#### `log_info(message)`
**Purpose**: Output informational messages
**Parameters**: `message` - Information message to output
**Returns**: None
**Example**:
```bash
log_info "Detected desktop environment: $desktop_env"
```

#### `log_success(message)`
**Purpose**: Output success messages
**Parameters**: `message` - Success message to output
**Returns**: None
**Example**:
```bash
log_success "Screenshot taken successfully"
```

#### `log_warning(message)`
**Purpose**: Output warning messages
**Parameters**: `message` - Warning message to output
**Returns**: None
**Example**:
```bash
log_warning "Screenshot tool not found, installing..."
```

#### `log_error(message)`
**Purpose**: Output error messages with stack trace
**Parameters**: `message` - Error message to output
**Returns**: None
**Example**:
```bash
log_error "Failed to take screenshot"
```

#### `log_step(message)`
**Purpose**: Output step-by-step progress messages
**Parameters**: `message` - Step message to output
**Returns**: None
**Example**:
```bash
log_step "Checking system requirements"
```

### System Detection Functions

#### `check_system_requirements()`
**Purpose**: Validate system compatibility and requirements
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Side Effects**: Sets `os_type` and `distro` variables
**Example**:
```bash
check_system_requirements
```

#### `detect_display_server()`
**Purpose**: Detect whether running on Wayland or X11
**Parameters**: None
**Returns**: "wayland", "x11", or "unknown"
**Example**:
```bash
display_server=$(detect_display_server)
```

#### `detect_package_managers()`
**Purpose**: Detect available package managers on the system
**Parameters**: None
**Returns**: Space-separated list of detected package managers
**Side Effects**: Creates `pckmgrs.json` file
**Example**:
```bash
package_managers=$(detect_package_managers)
```

### Screenshot Functions

#### `take_screenshot()`
**Purpose**: Take a screenshot using the appropriate tool for the desktop environment
**Parameters**: None
**Returns**: 0 on success, 1 on failure, 125 on user cancellation
**Side Effects**: Creates screenshot file at `SCREENSHOT_FILE`
**Example**:
```bash
if take_screenshot; then
    log_success "Screenshot captured"
else
    log_error "Screenshot failed"
fi
```

#### `take_wayland_screenshot()`
**Purpose**: Take screenshot in Wayland environments
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
take_wayland_screenshot
```

#### `take_macos_screenshot()`
**Purpose**: Take screenshot on macOS
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
take_macos_screenshot
```

#### `verify_screenshot()`
**Purpose**: Verify that screenshot file exists and is not empty
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
verify_screenshot
```

### Upload Functions

#### `upload_screenshot()`
**Purpose**: Upload screenshot to the configured service
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
upload_screenshot
```

#### `upload_to_guns()`
**Purpose**: Upload to guns.lol service
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
upload_to_guns
```

#### `upload_to_imgur()`
**Purpose**: Upload to imgur.com service
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
upload_to_imgur
```

#### `upload_to_generic_service()`
**Purpose**: Upload to generic service with custom configuration
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
upload_to_generic_service
```

#### `process_upload_response()`
**Purpose**: Process the response from upload service and extract URL
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Side Effects**: Sets `url` variable with extracted URL
**Example**:
```bash
process_upload_response
```

### Clipboard Functions

#### `copy_to_clipboard()`
**Purpose**: Copy screenshot to clipboard
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
copy_to_clipboard
```

#### `copy_url_to_clipboard(url)`
**Purpose**: Copy URL to clipboard
**Parameters**: `url` - URL to copy
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
copy_url_to_clipboard "https://example.com/image.png"
```

### Configuration Functions

#### `ensure_config_dir()`
**Purpose**: Create configuration directory if it doesn't exist
**Parameters**: None
**Returns**: None
**Example**:
```bash
ensure_config_dir
```

#### `validate_config()`
**Purpose**: Validate the settings file format
**Parameters**: None
**Returns**: None
**Side Effects**: May call `backup_and_reset_config()` if invalid
**Example**:
```bash
validate_config
```

#### `get_saved_value(key)`
**Purpose**: Retrieve a value from the settings file
**Parameters**: `key` - Setting key to retrieve
**Returns**: Value as string, empty string if not found
**Example**:
```bash
auth_key=$(get_saved_value "guns_auth")
```

#### `save_value(key, value)`
**Purpose**: Save a key-value pair to the settings file
**Parameters**: `key` - Setting key, `value` - Value to save
**Returns**: None
**Example**:
```bash
save_value "guns_auth" "my_api_key"
```

### Authentication Functions

#### `get_authentication(service)`
**Purpose**: Retrieve authentication key for a service
**Parameters**: `service` - Service name
**Returns**: None
**Side Effects**: Sets `auth` variable with authentication key
**Example**:
```bash
get_authentication "guns"
```

### Audio Functions

#### `play_sound(sound_file)`
**Purpose**: Play a sound file if not muted
**Parameters**: `sound_file` - Path to sound file
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
play_sound "$SCREENSHOT_SOUND"
```

#### `ensure_audio_player()`
**Purpose**: Ensure audio player is configured
**Parameters**: None
**Returns**: 0 on success, 1 on failure
**Example**:
```bash
ensure_audio_player
```

### Utility Functions

#### `cleanup_files()`
**Purpose**: Remove temporary files created during execution
**Parameters**: None
**Returns**: None
**Example**:
```bash
cleanup_files
```

#### `cleanup_on_error()`
**Purpose**: Error handler for cleanup on script failure
**Parameters**: None
**Returns**: None
**Example**:
```bash
trap cleanup_on_error ERR
```

#### `cleanup_on_exit()`
**Purpose**: Cleanup handler for script exit
**Parameters**: None
**Returns**: None
**Example**:
```bash
trap cleanup_on_exit EXIT
```

## Service Configuration API

### Service Configuration Structure

```bash
get_service_config(service_name) {
    case "$service_name" in
    "pixelvault")
        url="https://pixelvault.co"
        auth_header="Authorization"
        ;;
    "guns")
        url="https://guns.lol/api/upload"
        auth_header="key"
        ;;
    # ... other services
    esac
}
```

### Adding New Services

To add a new upload service:

1. **Add service configuration**:
```bash
"newservice")
    url="https://newservice.com/api/upload"
    auth_header="Authorization"
    ;;
```

2. **Add upload function** (if needed):
```bash
upload_to_newservice() {
    local response
    response=$(curl -s -X POST \
        -F "file=@$SCREENSHOT_FILE" \
        -H "$auth_header: $auth" \
        "$url")
    echo "$response" >"$UPLOAD_RESPONSE"
    process_upload_response
}
```

3. **Add to upload_screenshot()**:
```bash
case "$service" in
"newservice")
    upload_to_newservice
    ;;
```

## Data Structures

### Settings File Format

```json
{
    "screenshot_save_directory": "/path/to/save/directory",
    "preferred_audio_player": "paplay",
    "guns_auth": "your_api_key",
    "pixelvault_auth": "your_auth_token",
    "hyprland_tool": "hyprshot",
    "kde_tool": "spectacle",
    "gnome_tool": "gnome-screenshot"
}
```

### Package Manager Cache Format

```json
["arch", "arch_community"]
```

### Upload Response Format

```json
{
    "link": "https://service.com/i/abc123.png",
    "success": true
}
```

## Error Handling

### Exit Codes

| Code | Description |
|------|-------------|
| 0 | Success |
| 1 | General error |
| 125 | User cancelled screenshot |

### Error Handling Patterns

#### Function-Level Error Handling
```bash
function_name() {
    if ! command -v tool &>/dev/null; then
        log_error "Tool not found"
        return 1
    fi
    
    if ! tool_command; then
        log_error "Tool command failed"
        return 1
    fi
    
    return 0
}
```

#### Script-Level Error Handling
```bash
# Set error handling
set -o errexit
set -o nounset
set -o pipefail

# Set up traps
trap cleanup_on_error ERR
trap cleanup_on_exit EXIT
```

## Environment Variables

### Internal Variables

| Variable | Purpose | Scope |
|----------|---------|-------|
| `os_type` | Operating system type | Global |
| `desktop_env` | Desktop environment | Global |
| `display_server` | Display server type | Global |
| `service` | Selected upload service | Global |
| `auth` | Authentication key | Global |
| `url` | Upload service URL | Global |
| `debug_enabled` | Debug mode flag | Global |
| `mute_enabled` | Mute mode flag | Global |
| `save_enabled` | Save mode flag | Global |

### Configuration Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `CONFIG_DIR` | Configuration directory | `~/.config/hyprupld` |
| `TEMP_DIR` | Temporary files directory | `/tmp` |
| `SOUND_DIR` | Sound files directory | `/usr/local/share/hyprupld/sounds` |
| `VERSION` | Script version | `hyprupld-dev` |

## File System API

### Configuration Files

#### Settings File (`settings.json`)
- **Location**: `~/.config/hyprupld/settings.json`
- **Format**: JSON
- **Permissions**: 600 (user read/write)
- **Purpose**: Store user preferences and authentication keys

#### Package Manager Cache (`pckmgrs.json`)
- **Location**: `~/.config/hyprupld/pckmgrs.json`
- **Format**: JSON array
- **Permissions**: 644 (user read/write, group/other read)
- **Purpose**: Cache detected package managers

#### Debug Log (`debug.log`)
- **Location**: `~/.config/hyprupld/debug.log`
- **Format**: Plain text with timestamps
- **Permissions**: 644 (user read/write, group/other read)
- **Purpose**: Debug and error logging

### Temporary Files

#### Screenshot File (`screenshot.png`)
- **Location**: `/tmp/screenshot.png`
- **Format**: PNG image
- **Lifetime**: Until script completion
- **Purpose**: Temporary storage of captured screenshot

#### Upload Response (`upload.json`)
- **Location**: `/tmp/upload.json`
- **Format**: JSON
- **Lifetime**: Until script completion
- **Purpose**: Temporary storage of upload service response

## Network API

### HTTP Client Usage

#### Basic Upload Request
```bash
response=$(curl -s -X POST \
    -F "file=@$SCREENSHOT_FILE" \
    -H "$auth_header: $auth" \
    "$url")
```

#### Service Status Check
```bash
if curl -I "$url" &>/dev/null; then
    log_info "Service is available"
else
    log_error "Service is unavailable"
fi
```

### Response Processing

#### JSON Response Parsing
```bash
url=$(python3 -c "import json; print(json.load(open('$UPLOAD_RESPONSE')).get('link', ''))" 2>/dev/null)
```

#### Error Response Handling
```bash
if python3 -c "import json; response = json.load(open('$UPLOAD_RESPONSE')); exit(1 if response.get('status') == 429 else 0)" 2>/dev/null; then
    log_warning "Rate limit exceeded"
fi
```

## Security Considerations

### Input Validation

#### File Path Validation
```bash
if [[ ! -f "$file_path" ]]; then
    log_error "File not found: $file_path"
    return 1
fi
```

#### URL Validation
```bash
if [[ ! "$url" =~ ^https?:// ]]; then
    log_error "Invalid URL: $url"
    return 1
fi
```

### Credential Security

#### Secure Storage
```bash
# Store credentials in user-readable JSON
chmod 600 "$SETTINGS_FILE"

# Don't log credentials in debug mode
log_debug "Using saved auth key for $service"
```

#### Credential Validation
```bash
if [[ -z "$auth" ]]; then
    log_error "Authentication required for $service"
    return 1
fi
```

## Performance Considerations

### Caching

#### Package Manager Detection
```bash
# Cache package manager detection
if [[ -f "$PCKMGRS_FILE" ]]; then
    log_info "Using cached package manager information"
    package_managers=$(python3 -c "import json; print(json.load(open('$PCKMGRS_FILE')))")
else
    package_managers=$(detect_package_managers)
fi
```

#### Tool Selection
```bash
# Cache tool preferences
tool=$(get_saved_value "${de}_tool")
if [[ -z "$tool" ]]; then
    # Prompt user for selection
    tool=$(select_tool)
    save_value "${de}_tool" "$tool"
fi
```

### Optimization

#### Reduce External Commands
```bash
# Use built-in bash features when possible
# Instead of: echo "$var" | grep "pattern"
# Use: [[ "$var" =~ pattern ]]
```

#### Efficient File Operations
```bash
# Use temporary files for large operations
# Clean up temporary files on exit
trap cleanup_files EXIT
```

## Testing API

### Function Testing

#### Unit Test Example
```bash
test_get_saved_value() {
    # Setup
    echo '{"test_key": "test_value"}' > "$SETTINGS_FILE"
    
    # Test
    result=$(get_saved_value "test_key")
    
    # Assert
    if [[ "$result" == "test_value" ]]; then
        echo "✓ get_saved_value test passed"
    else
        echo "✗ get_saved_value test failed"
        return 1
    fi
}
```

#### Integration Test Example
```bash
test_screenshot_workflow() {
    # Test complete workflow
    if hyprupld -debug -silent; then
        echo "✓ Screenshot workflow test passed"
    else
        echo "✗ Screenshot workflow test failed"
        return 1
    fi
}
```

---

**Note**: This API reference is intended for developers and advanced users. For general usage, refer to the other documentation files in the `docs/` directory. 