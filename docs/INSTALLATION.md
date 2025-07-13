# Installation Guide

Complete installation guide for HyprUpld across all supported platforms and distributions.

## Prerequisites

### System Requirements

- **Linux**: Any modern distribution (Arch, Debian, Fedora, Ubuntu, etc.)
- **macOS**: 10.0 or later
- **RAM**: 512MB minimum, 1GB recommended
- **Storage**: 50MB free space
- **Network**: Internet connection for upload services

### Required Dependencies

#### Linux Dependencies

**Core Dependencies:**
- `curl` - HTTP client for uploads
- `python3` - JSON processing and utilities
- `zenity` - GUI dialogs for user interaction

**Screenshot Tools (auto-detected and installed):**
- `hyprshot` - For Hyprland
- `grimblast` - For Sway
- `grim` + `slurp` - For Wayland
- `flameshot` - Cross-platform screenshot tool
- `spectacle` - KDE screenshot tool
- `gnome-screenshot` - GNOME screenshot tool

**Audio Players (at least one required):**
- `paplay` - PulseAudio sound player
- `play` - SoX sound player
- `aplay` - ALSA sound player
- `mpg123` - MPG123 audio player

**Clipboard Utilities:**
- `wl-clipboard` - For Wayland
- `xclip` - For X11

#### macOS Dependencies

**Core Dependencies:**
- `curl` - HTTP client
- `python3` - JSON processing
- `Homebrew` - Package manager (recommended)

**Built-in Tools:**
- `screencapture` - Screenshot tool
- `pbcopy`/`pbpaste` - Clipboard utilities
- `osascript` - Notifications and automation

## Installation Methods

### Method 1: One-Line Install (Recommended)

#### Linux
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PhoenixAceVFX/hyprupld/main/install.sh)"
```

#### macOS
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PhoenixAceVFX/hyprupld/main/install_macos.sh)"
```

**What the one-line installer does:**
1. Downloads the installation script
2. Checks system requirements
3. Installs missing dependencies
4. Compiles and installs HyprUpld
5. Sets up configuration directory
6. Verifies installation

### Method 2: Package Manager Installation

#### Arch Linux (AUR)
```bash
# Using yay
yay -S hyprupld

# Using paru
paru -S hyprupld

# Using pacman (if available in official repos)
sudo pacman -S hyprupld
```

#### Other Distributions
```bash
# Ubuntu/Debian (if available)
sudo apt install hyprupld

# Fedora (if available)
sudo dnf install hyprupld

# openSUSE (if available)
sudo zypper install hyprupld
```

### Method 3: Manual Installation

#### Step 1: Clone Repository
```bash
git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld
```

#### Step 2: Install Dependencies

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install curl python3 zenity wl-clipboard flameshot \
  pulseaudio-utils sox alsa-utils mpg123 git
```

**Arch Linux:**
```bash
sudo pacman -S curl python3 zenity wl-clipboard flameshot \
  pulseaudio-utils sox alsa-utils mpg123 git
```

**Fedora:**
```bash
sudo dnf install curl python3 zenity wl-clipboard flameshot \
  pulseaudio-utils sox alsa-utils mpg123 git
```

**macOS:**
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install curl python3
```

#### Step 3: Compile and Install
```bash
# Compile the project
bash compile.sh

# Install scripts
bash install_scripts.sh
```

### Method 4: AppImage Installation

#### Download AppImage
1. Go to the [Releases page](https://github.com/PhoenixAceVFX/hyprupld/releases)
2. Download the latest AppImage for your architecture
3. Make it executable and run:

```bash
# Download AppImage
wget https://github.com/PhoenixAceVFX/hyprupld/releases/latest/download/hyprupld-x86_64.AppImage

# Make executable
chmod +x hyprupld-x86_64.AppImage

# Run
./hyprupld-x86_64.AppImage
```

## Platform-Specific Installation

### Ubuntu/Debian Installation

#### Automatic Installation
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PhoenixAceVFX/hyprupld/main/install.sh)"
```

#### Manual Installation
```bash
# Update package list
sudo apt update

# Install dependencies
sudo apt install curl python3 zenity wl-clipboard flameshot \
  pulseaudio-utils sox alsa-utils mpg123 git

# Clone and install
git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld
bash compile.sh
bash install_scripts.sh
```

### Arch Linux Installation

#### Using AUR Helper
```bash
# Install yay if not already installed
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install HyprUpld
yay -S hyprupld
```

#### Manual Installation
```bash
# Install dependencies
sudo pacman -S curl python3 zenity wl-clipboard flameshot \
  pulseaudio-utils sox alsa-utils mpg123 git

# Clone and install
git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld
bash compile.sh
bash install_scripts.sh
```

### Fedora Installation

#### Automatic Installation
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PhoenixAceVFX/hyprupld/main/install.sh)"
```

#### Manual Installation
```bash
# Install dependencies
sudo dnf install curl python3 zenity wl-clipboard flameshot \
  pulseaudio-utils sox alsa-utils mpg123 git

# Clone and install
git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld
bash compile.sh
bash install_scripts.sh
```

### macOS Installation

#### Using Homebrew (Recommended)
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install HyprUpld
brew install hyprupld
```

#### Manual Installation
```bash
# Install dependencies
brew install curl python3

# Clone and install
git clone https://github.com/PhoenixAceVFX/hyprupld.git
cd hyprupld
bash compile.sh
bash install_scripts.sh
```

### NixOS Installation

#### Using nix-env
```bash
nix-env -iA nixos.hyprupld
```

#### Using configuration.nix
```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprupld
  ];
}
```

## Post-Installation Setup

### First Run Configuration

1. **Run HyprUpld for the first time:**
   ```bash
   hyprupld
   ```

2. **Select audio player** when prompted
3. **Test screenshot functionality**
4. **Configure upload services** (optional)

### Configuration Directory

The installation creates a configuration directory at `~/.config/hyprupld/`:

```bash
~/.config/hyprupld/
├── settings.json      # User preferences and saved values
├── pckmgrs.json       # Detected package managers
└── debug.log          # Debug log file
```

### Setting Up Keybindings

#### Hyprland
Add to `~/.config/hypr/hyprland.conf`:
```conf
# Screenshot and copy to clipboard
bind = , Print, exec, hyprupld

# Screenshot and upload to imgur
bind = SHIFT, Print, exec, hyprupld -imgur

# Screenshot and save locally
bind = CTRL, Print, exec, hyprupld -s
```

#### GNOME
1. Go to Settings → Keyboard → Keyboard Shortcuts
2. Click "Add Shortcut"
3. Set name: "Screenshot"
4. Set command: `hyprupld`
5. Set keyboard shortcut (e.g., `Print`)

#### KDE
1. Go to System Settings → Shortcuts → Custom Shortcuts
2. Click "Edit" → "New" → "Global Shortcut" → "Command/URL"
3. Set name: "Screenshot"
4. Set command: `hyprupld`
5. Set trigger to your preferred key combination

#### i3/Sway
Add to your config file:
```conf
# Screenshot and copy to clipboard
bindsym Print exec hyprupld

# Screenshot and upload to imgur
bindsym Shift+Print exec hyprupld -imgur
```

## Verification

### Check Installation

```bash
# Check if HyprUpld is installed
which hyprupld

# Check version
hyprupld

# Test basic functionality
hyprupld -debug
```

### Test Dependencies

```bash
# Check screenshot tools
which hyprshot grimblast grim flameshot spectacle gnome-screenshot

# Check clipboard tools
which wl-copy xclip

# Check audio players
which paplay play aplay mpg123

# Check core dependencies
which curl python3 zenity
```

### Test Functionality

```bash
# Test screenshot and clipboard
hyprupld

# Test upload service (imgur doesn't require auth)
hyprupld -imgur

# Test save functionality
hyprupld -s
```

## Troubleshooting Installation

### Common Installation Issues

#### Permission Denied
```bash
# Fix script permissions
chmod +x install.sh
chmod +x compile.sh
chmod +x install_scripts.sh

# Fix installed binary permissions
sudo chmod +x /usr/local/bin/hyprupld
```

#### Missing Dependencies
```bash
# Check what's missing
hyprupld -debug

# Install missing packages manually
sudo apt install [missing-package]  # Ubuntu/Debian
sudo pacman -S [missing-package]    # Arch Linux
sudo dnf install [missing-package]  # Fedora
```

#### PATH Issues
```bash
# Check if HyprUpld is in PATH
echo $PATH
which hyprupld

# Add to PATH if needed
export PATH="$PATH:/usr/local/bin"
echo 'export PATH="$PATH:/usr/local/bin"' >> ~/.bashrc
```

### Installation Logs

Check installation logs for detailed information:

```bash
# Check debug log
tail -f ~/.config/hyprupld/debug.log

# Check system logs
journalctl -u hyprupld  # If installed as service
```

## Uninstallation

### Remove HyprUpld

#### Using Package Manager
```bash
# Arch Linux
sudo pacman -R hyprupld
# or
yay -R hyprupld

# Ubuntu/Debian
sudo apt remove hyprupld

# Fedora
sudo dnf remove hyprupld

# macOS
brew uninstall hyprupld
```

#### Manual Removal
```bash
# Remove binary
sudo rm -f /usr/local/bin/hyprupld

# Remove configuration (optional)
rm -rf ~/.config/hyprupld

# Remove sound files (optional)
sudo rm -rf /usr/local/share/hyprupld
```

#### Using Cleanup Script
```bash
# Download and run cleanup script
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PhoenixAceVFX/hyprupld/main/cleanup.sh)"
```

## Updating

### Automatic Update
```bash
hyprupld -update
```

### Manual Update
```bash
# If installed from source
cd ~/hyprupld
git pull
bash compile.sh
bash install_scripts.sh

# If installed via package manager
sudo pacman -Syu hyprupld  # Arch Linux
sudo apt update && sudo apt upgrade hyprupld  # Ubuntu/Debian
sudo dnf update hyprupld  # Fedora
brew upgrade hyprupld  # macOS
```

## Support

### Getting Help

If you encounter installation issues:

1. **Check the troubleshooting guide**: See [Troubleshooting Guide](TROUBLESHOOTING.md)
2. **Enable debug mode**: Run `hyprupld -debug`
3. **Check logs**: Review `~/.config/hyprupld/debug.log`
4. **Create an issue**: Report problems on [GitHub Issues](https://github.com/PhoenixAceVFX/hyprupld/issues)

### System Requirements Check

```bash
# Check system information
uname -a
lsb_release -a  # Linux
sw_vers  # macOS

# Check available memory
free -h  # Linux
vm_stat  # macOS

# Check disk space
df -h

# Check network connectivity
ping -c 3 google.com
```

---

**Note**: The installation process is designed to be automatic and handle most dependencies. If you encounter issues, the debug mode will provide detailed information to help resolve them. 