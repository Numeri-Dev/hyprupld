<div align="center">

![HyprUpld](Banner.png)

# HyprUpld

A versatile screenshot and file upload utility for Linux with multi-platform support

![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)
![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)

`Licensed under GPL-2.0`

</div>

## Quick Start

One-line installation:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PhoenixAceVFX/hyprupld/main/install.sh)"
```

> **Note**: If downloading manually from the releases page, remember to make the script executable with `chmod +x` before creating keybindings. This step is not needed when using the one-line installer.

## Features

### Upload Services
- atums.world
- e-z.host
- fakecri.me
- guns.lol
- nest.rip
- pixelvault.co
- Custom URL support (see [wiki](../../wiki) for instructions)

### Command Line Options
```
Usage: hyprupld [OPTIONS]

Options:
  -atumsworld    Use atums.world
  -ez            Use e-z.host
  -fakecrime     Use fakecri.me
  -guns          Use guns.lol
  -nest          Use nest.rip
  -pixelvault    Use pixelvault.co
  -h, --help     Show this help message
  -reset         Reset all settings
  -u, --url URL  Set custom upload URL

Note: If no service is selected, the file will be copied to clipboard
```

## Desktop Environment Support

HyprUpld works seamlessly with:
- KDE Plasma
- Hyprland
- GNOME
- XFCE
- i3
- Deepin
- Cinnamon
- Openbox
- MATE
- Sway

## Package Manager Support

Installation is supported on systems using:
- Pacman (Arch)
- Apt (Debian/Ubuntu)
- DNF (Fedora)
- Nix-Env (NixOS)
- Emerge (Gentoo)
- Zypper (openSUSE)
- XBPS (Void)
- AUR Helpers (Yay/Paru)

## AppImage Support

- Pre-built AppImages are available in the [Releases](../../releases) section
- Can be compiled using the included `compile.sh` script
- Automatic builds generated from the latest commit
- Functionally identical to the standard scripts

## Installation

The `install.sh` script:
- Places executables in `/usr/local/bin`
- Sets appropriate permissions
- Verifies PATH configuration
- Handles dependency installation

To install:
1. Clone the repository or download the release package
2. Run `bash install_scripts.sh`
3. (Optional) Run `bash compile.sh` to build from source

## Dependencies

### Core Tools
* [curl](https://github.com/curl/curl) - Command line tool for transferring data
* [xclip](https://github.com/astrand/xclip) - Command line interface to X selections (clipboard)
* [fyi](https://github.com/Macchina-CLI/fyi) - Minimal desktop notifications
* [zenity](https://gitlab.gnome.org/GNOME/zenity) - Display graphical dialog boxes from shell scripts
* [jq](https://github.com/stedolan/jq) - Lightweight command-line JSON processor
* [grimblast](https://github.com/hyprwm/contrib) - Screenshot utility for Hyprland

### Screenshot Tools
* [grimblast](https://github.com/hyprwm/contrib) - For Hyprland
* [spectacle](https://github.com/KDE/spectacle) - For KDE Plasma
* [gnome-screenshot](https://gitlab.gnome.org/GNOME/gnome-screenshot) - For GNOME
* [xfce4-screenshooter](https://docs.xfce.org/apps/xfce4-screenshooter/start) - For XFCE
* [scrot](https://github.com/resurrecting-open-source-projects/scrot) - For i3, Openbox, and other minimal WMs
* [deepin-screenshot](https://github.com/linuxdeepin/deepin-screenshot) - For Deepin
* [mate-screenshot](https://github.com/mate-desktop/mate-utils) - For MATE
* [grim](https://github.com/emersion/grim) - For Sway

## Issues and Support
Please use the [Issues](../../issues) section to:
- Report bugs
- Request new features
- Request additional upload service support

---
Created by PhoenixAceVFX
