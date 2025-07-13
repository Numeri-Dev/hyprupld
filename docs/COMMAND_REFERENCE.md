# Command Reference

Complete reference for all HyprUpld command-line options and arguments.

## Basic Syntax

```bash
hyprupld [OPTIONS] [SERVICE_OPTIONS]
```

## General Options

| Option | Description | Example |
|--------|-------------|---------|
| `-h, --help` | Display help information | `hyprupld -h` |
| `-debug` | Enable verbose debug logging | `hyprupld -debug` |
| `-strict` | Enable strict error handling | `hyprupld -strict` |
| `-reset` | Reset all settings and start fresh | `hyprupld -reset` |
| `-s, --save` | Save screenshots to a specified directory | `hyprupld -s` |
| `-update` | Update hyprupld to the latest version | `hyprupld -update` |
| `-mute` | Mute sound feedback | `hyprupld -mute` |
| `-silent` | Silent mode (no sound or notification) | `hyprupld -silent` |
| `-kill` | Kill all running instances of hyprupld | `hyprupld -kill` |
| `-uwsm` | Enable UWSM compatibility mode for Hyprland | `hyprupld -uwsm` |

## Upload Service Options

### Built-in Services

| Service | Command | Auth Required | Description |
|---------|---------|---------------|-------------|
| guns.lol | `-guns` | Yes | Upload to guns.lol service |
| e-z.host | `-ez` | Yes | Upload to e-z.host service |
| fakecri.me | `-fakecrime` | Yes | Upload to fakecri.me service |
| nest.rip | `-nest` | Yes | Upload to nest.rip service |
| pixelvault.co | `-pixelvault` | Yes | Upload to pixelvault.co service |
| imgur.com | `-imgur` | No | Upload to imgur.com (anonymous) |

### Custom Services

| Service | Command | Parameters | Description |
|---------|---------|------------|-------------|
| Zipline | `-zipline` | `<base_url> <authorization>` | Use custom Zipline instance |
| xBackBone | `-xbackbone` | `<base_url> <token>` | Use custom xBackBone instance |

## Detailed Option Descriptions

### General Options

#### `-h, --help`
Displays comprehensive help information including all available options and examples.

```bash
hyprupld -h
# or
hyprupld --help
```

#### `-debug`
Enables verbose debug logging. Useful for troubleshooting issues.

```bash
hyprupld -debug
```

**What it does:**
- Enables detailed logging to console
- Writes debug information to `~/.config/hyprupld/debug.log`
- Shows function names, line numbers, and timestamps
- Displays environment information and system detection

#### `-strict`
Enables strict error handling mode. Useful for development and debugging.

```bash
hyprupld -strict
```

**What it does:**
- Enables `set -euox pipefail` for strict bash error handling
- Exits immediately on any error
- Shows command execution with `+` prefix
- Useful for identifying exactly where errors occur

#### `-reset`
Resets all saved settings and configuration. Use with caution.

```bash
hyprupld -reset
```

**What it does:**
- Removes `~/.config/hyprupld/settings.json`
- Clears all saved authentication keys
- Removes package manager cache
- Forces re-detection of system components

#### `-s, --save`
Enables local screenshot saving with organized directory structure.

```bash
hyprupld -s
```

**What it does:**
- Prompts for save directory on first use
- Creates organized folder structure by month
- Saves files with timestamp format: `hyprupld-YYYYMMDD-HHMMSS.png`
- Example structure:
  ```
  ~/Pictures/hyprupld/
  ├── january-2024/
  │   ├── hyprupld-20240115-143022.png
  │   └── hyprupld-20240118-091545.png
  └── february-2024/
      └── hyprupld-20240203-104512.png
  ```

#### `-update`
Updates HyprUpld to the latest version from the repository.

```bash
hyprupld -update
```

**What it does:**
- Clones repository to `~/hyprupld` if not present
- Pulls latest changes from GitHub
- Runs compilation and installation scripts
- Exits after successful update

#### `-mute`
Disables sound feedback while keeping notifications.

```bash
hyprupld -mute
```

#### `-silent`
Disables both sound feedback and notifications.

```bash
hyprupld -silent
```

#### `-kill`
Terminates all running instances of HyprUpld.

```bash
hyprupld -kill
```

**Use cases:**
- When HyprUpld becomes unresponsive
- To stop multiple instances
- Before updating or reinstalling

#### `-uwsm`
Enables UWSM (User Wayland Session Manager) compatibility mode.

```bash
hyprupld -uwsm
```

**What it does:**
- Enhanced error handling for UWSM environments
- Retry logic for screenshot capture
- More resilient clipboard operations
- Better logging for UWSM sessions

### Upload Service Options

#### Built-in Services

##### `-guns`
Upload to guns.lol service.

```bash
hyprupld -guns
```

**Authentication:** API key required (prompted on first use)
**Response:** JSON with `link` field

##### `-ez`
Upload to e-z.host service.

```bash
hyprupld -ez
```

**Authentication:** API key required (prompted on first use)
**Response:** JSON with `imageUrl` field

##### `-fakecrime`
Upload to fakecri.me service.

```bash
hyprupld -fakecrime
```

**Authentication:** Authorization header required (prompted on first use)
**Response:** Direct URL

##### `-nest`
Upload to nest.rip service.

```bash
hyprupld -nest
```

**Authentication:** Authorization header required (prompted on first use)
**Response:** JSON with `fileURL` field

##### `-pixelvault`
Upload to pixelvault.co service.

```bash
hyprupld -pixelvault
```

**Authentication:** Authorization header required (prompted on first use)
**Response:** JSON with `resource` field

##### `-imgur`
Upload to imgur.com service.

```bash
hyprupld -imgur
```

**Authentication:** Optional (uses anonymous upload by default)
**Response:** JSON with nested `data.link` field

#### Custom Services

##### `-zipline`
Use a custom Zipline instance.

```bash
hyprupld -zipline <base_url> <authorization>
```

**Parameters:**
- `<base_url>`: Base URL of your Zipline instance (e.g., `https://my-zipline.com`)
- `<authorization>`: Authorization key for your instance

**Example:**
```bash
hyprupld -zipline https://my-zipline.com myauthkey
```

**What it does:**
- Automatically appends `/api/upload` to the base URL
- Uses `authorization` header for authentication
- Supports any Zipline-compatible instance

##### `-xbackbone`
Use a custom xBackBone instance.

```bash
hyprupld -xbackbone <base_url> <token>
```

**Parameters:**
- `<base_url>`: Base URL of your xBackBone instance (e.g., `https://my-xbackbone.com`)
- `<token>`: Token for your instance

**Example:**
```bash
hyprupld -xbackbone https://my-xbackbone.com mytoken
```

**What it does:**
- Automatically appends `/upload` to the base URL
- Uses `token` header for authentication
- Supports any xBackBone-compatible instance

## Option Combinations

You can combine multiple options for advanced functionality:

```bash
# Debug mode with imgur upload
hyprupld -debug -imgur

# Silent mode with local save
hyprupld -silent -s

# UWSM mode with guns upload and debug
hyprupld -uwsm -guns -debug

# Custom Zipline with save and mute
hyprupld -zipline https://example.com key -s -mute
```

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `HYPRUPLD_CONFIG` | Override default config directory | `export HYPRUPLD_CONFIG=/custom/path` |
| `HYPRUPLD_DEBUG` | Enable debug output | `export HYPRUPLD_DEBUG=1` |

## Exit Codes

| Code | Description |
|------|-------------|
| 0 | Success |
| 1 | General error |
| 125 | User cancelled screenshot |

## Examples

### Basic Usage
```bash
# Take screenshot and copy to clipboard
hyprupld

# Take screenshot and upload to imgur
hyprupld -imgur

# Take screenshot and save locally
hyprupld -s
```

### Advanced Usage
```bash
# Debug mode with guns upload
hyprupld -debug -guns

# Silent custom Zipline upload
hyprupld -silent -zipline https://my-zipline.com mykey

# UWSM mode with save and debug
hyprupld -uwsm -s -debug
```

### Troubleshooting
```bash
# Enable debug mode
hyprupld -debug

# Reset all settings
hyprupld -reset

# Kill all instances
hyprupld -kill
```

## Notes

- **Authentication**: API keys are stored securely in `~/.config/hyprupld/settings.json`
- **Configuration**: Settings persist between runs and can be reset with `-reset`
- **Logging**: Debug logs are written to `~/.config/hyprupld/debug.log`
- **Compatibility**: Options work across all supported platforms (Linux, macOS)
- **Order**: Option order generally doesn't matter, but service options should come after general options 