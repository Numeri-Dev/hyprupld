#!/bin/bash -e

# ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░       ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░      ░▒▓██████▓▒░  ░▒▓█▓▒▒▓█▓▒░░▒▓██████▓▒░  ░▒▓██████▓▒░
# ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░  ░▒▓██▓▒░  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓████████▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░
# ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓████████▓▒░▒▓███████▓▒░
# Script by PhoenixAceVFX
# Licensed under GPL-2.0


# Main script variables
url="https://guns.lol/api/upload"
temp_file="/tmp/screenshot.png"
response_file="/tmp/upload.json"
settings_file="$HOME/.config/guns/settings.json"
pckmgrs_file="$HOME/.config/hyprupld/pckmgrs.json"

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Verbose logging function
log() {
    local level=$1
    local message=$2
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    
    case "$level" in
        "INFO")
            echo -e "${GREEN}[INFO]${NC} ${timestamp} - $message"
            ;;
        "WARN")
            echo -e "${YELLOW}[WARN]${NC} ${timestamp} - $message"
            ;;
        "ERROR")
            echo -e "${RED}[ERROR]${NC} ${timestamp} - $message"
            ;;
        "DEBUG")
            echo -e "${BLUE}[DEBUG]${NC} ${timestamp} - $message"
            ;;
        "SUCCESS")
            echo -e "${GREEN}[SUCCESS]${NC} ${timestamp} - $message"
            ;;
        *)
            echo -e "${CYAN}[$level]${NC} ${timestamp} - $message"
            ;;
    esac
}

# Helper functions
get_saved_value() {
    log "DEBUG" "Retrieving saved value for key: $1"
    local value=""
    if [[ -f "$settings_file" ]]; then
        value=$(jq -r ".$1" "$settings_file")
        log "DEBUG" "Found value: $value"
    else
        log "DEBUG" "Settings file not found"
    fi
    echo "$value"
}

save_value() {
    log "INFO" "Saving value for key: $1"
    mkdir -p "$(dirname "$settings_file")"
    if [[ -f "$settings_file" ]]; then
        jq ".$1=\"$2\"" "$settings_file" > "$settings_file.tmp" && mv "$settings_file.tmp" "$settings_file"
    else
        echo "{\"$1\": \"$2\"}" > "$settings_file"
    fi
    log "SUCCESS" "Value saved successfully"
}

detect_package_managers() {
    log "INFO" "Detecting package managers..."
    declare -a managers=("pacman" "apt-get" "dnf" "nix-env" "emerge" "zypper" "xbps-install" "yay" "paru")
    declare -A manager_names=(
        ["pacman"]="arch"
        ["apt-get"]="debian"
        ["dnf"]="fedora"
        ["nix-env"]="nixos"
        ["emerge"]="gentoo"
        ["zypper"]="opensuse"
        ["xbps-install"]="void"
        ["yay"]="arch_community"
        ["paru"]="arch_community"
    )

    detected_managers=()
    for manager in "${managers[@]}"; do
        if command -v "$manager" &>/dev/null; then
            detected_managers+=("${manager_names[$manager]}")
            log "DEBUG" "Found package manager: $manager (${manager_names[$manager]})"
        fi
    done

    # Save detected managers to JSON
    printf '%s\n' "${detected_managers[@]}" | jq -R . | jq -s . > "$pckmgrs_file"
    log "SUCCESS" "Detected package managers: ${detected_managers[*]}"
    echo "${detected_managers[@]}"
}

get_package_managers() {
    if [[ -f "$pckmgrs_file" ]]; then
        jq -r '.[]' "$pckmgrs_file"
    else
        detect_package_managers
    fi
}

install_dependencies() {
    required_packages=("$@")
    log "INFO" "Checking for required dependencies: ${required_packages[*]}"
    package_managers=($(get_package_managers))
    missing_packages=()

    # Check for missing dependencies
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
            log "WARN" "Missing package: $package"
        else
            log "DEBUG" "Package already installed: $package"
        fi
    done

    if [[ ${#missing_packages[@]} -eq 0 ]]; then
        log "SUCCESS" "All required packages are already installed"
        return
    fi

    log "INFO" "Attempting to install missing packages: ${missing_packages[*]}"
    log "INFO" "Available package managers: ${package_managers[*]}"
    
    for manager in "${package_managers[@]}"; do
        case "$manager" in
            "arch") 
                log "INFO" "Installing with pacman..."
                sudo pacman -S --noconfirm "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return ;;
            "debian") 
                log "INFO" "Installing with apt-get..."
                sudo apt-get install -y "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return ;;
            "fedora") 
                log "INFO" "Installing with dnf..."
                sudo dnf install -y "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return ;;
            "nixos") 
                log "INFO" "Installing with nix-env..."
                sudo nix-env -iA nixpkgs."${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return ;;
            "gentoo") 
                log "INFO" "Installing with emerge..."
                sudo emerge --ask "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return ;;
            "opensuse") 
                log "INFO" "Installing with zypper..."
                sudo zypper install -y "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return ;;
            "void") 
                log "INFO" "Installing with xbps-install..."
                sudo xbps-install -y "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return ;;
            "arch_community")
                if command -v yay &>/dev/null; then
                    log "INFO" "Installing with yay..."
                    yay -S --noconfirm "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return
                elif command -v paru &>/dev/null; then
                    log "INFO" "Installing with paru..."
                    paru -S --noconfirm "${missing_packages[@]}" && log "SUCCESS" "Packages installed successfully" && return
                fi
                ;;
        esac
    done

    log "ERROR" "Could not install dependencies. Install the following manually: ${missing_packages[*]}"
    exit 1
}

# Ensure Zenity, jq, and xclip are installed
log "INFO" "Checking for required dependencies..."
install_dependencies "zenity" "jq" "xclip"

# Detect distro and desktop environment
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
desktop_env=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
log "INFO" "Detected distro: $distro"
log "INFO" "Detected desktop environment: $desktop_env"

# Get auth key
log "INFO" "Retrieving authentication key..."
auth=$(get_saved_value "auth")
if [[ -z "$auth" ]]; then
    log "INFO" "No saved auth key found, prompting user..."
    auth=$(zenity --entry --title="Authentication Key" --text="Enter your auth key:" --width=500) || exit 1
    save_value "auth" "$auth"
    log "SUCCESS" "Authentication key saved"
fi

# Handle screenshots based on the desktop environment
log "INFO" "Taking screenshot based on desktop environment..."
case "$desktop_env" in
    *"sway"*|*"hyprland"*|*"i3"*)
        log "INFO" "Using grimblast for $desktop_env"
        install_dependencies "grimblast"
        grimblast save area "$temp_file"
        ;;
    *"kde"*)
        log "INFO" "Detected KDE environment"
        install_dependencies "flameshot" "spectacle"
        tool=$(get_saved_value "kde_tool")
        if [[ -z "$tool" ]]; then
            log "INFO" "No preferred tool saved, prompting user..."
            tool=$(zenity --list --radiolist --title="KDE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE Flameshot FALSE Spectacle --width=500 --height=316) || exit 1
            save_value "kde_tool" "$tool"
        fi
        log "INFO" "Using $tool for screenshots"
        if [[ "$tool" == "Flameshot" ]]; then
            flameshot gui -p "$temp_file"
        else
            spectacle --region --background --nonotify --output "$temp_file"
        fi
        ;;
    *"xfce"*)
        install_dependencies "xfce4-screenshooter" "flameshot"
        tool=$(get_saved_value "xfce_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="XFCE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE XFCE4-Screenshooter FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "xfce_tool" "$tool"
        fi
        if [[ "$tool" == "XFCE4-Screenshooter" ]]; then
            xfce4-screenshooter -r -s "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"gnome"*)
        install_dependencies "gnome-screenshot" "flameshot"
        tool=$(get_saved_value "gnome_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="GNOME Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE GNOME-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "gnome_tool" "$tool"
        fi
        if [[ "$tool" == "GNOME-Screenshot" ]]; then
            gnome-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"cinnamon"*)
        install_dependencies "gnome-screenshot" "flameshot"
        tool=$(get_saved_value "cinnamon_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="Cinnamon Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE GNOME-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "cinnamon_tool" "$tool"
        fi
        if [[ "$tool" == "GNOME-Screenshot" ]]; then
            gnome-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *"deepin"*)
        install_dependencies "deepin-screenshot"
        deepin-screenshot -s "$temp_file"
        ;;
    *"mate"*)
        install_dependencies "mate-screenshot" "flameshot"
        tool=$(get_saved_value "mate_tool")
        if [[ -z "$tool" ]]; then
            tool=$(zenity --list --radiolist --title="MATE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE MATE-Screenshot FALSE Flameshot --width=500 --height=316) || exit 1
            save_value "mate_tool" "$tool"
        fi
        if [[ "$tool" == "MATE-Screenshot" ]]; then
            mate-screenshot -a -f "$temp_file"
        else
            flameshot gui -p "$temp_file"
        fi
        ;;
    *)
        log "ERROR" "Unsupported desktop environment: $desktop_env"
        notify-send "Error" "Unsupported desktop environment: $desktop_env" -a "Screenshot Script"
        exit 1
        ;;
esac

# Verify screenshot
if [[ ! -f "$temp_file" ]]; then
    log "ERROR" "Failed to take screenshot"
    notify-send "Error" "Failed to take screenshot." -a "Screenshot Script"
    exit 1
fi
log "SUCCESS" "Screenshot captured successfully"

# Upload screenshot
log "INFO" "Uploading screenshot to $url..."
response=$(curl -s -X POST -F "file=@$temp_file" -F "key=$auth" "$url")
image_url=$(echo "$response" | jq -r '.link')

if [[ -z "$image_url" || "$image_url" == "null" ]]; then
    log "ERROR" "Failed to upload screenshot"
    notify-send "Error" "Failed to upload screenshot." -a "Screenshot Script"
    rm -f "$temp_file"
    exit 1
fi
log "SUCCESS" "Screenshot uploaded successfully"

# Copy url to clipboard
log "INFO" "Copying URL to clipboard: $image_url"
echo -n "$image_url" | xclip -selection clipboard
log "SUCCESS" "URL copied to clipboard"

# Final alert
notify-send "Image URL copied to clipboard" "$image_url" -a "Screenshot Script" -i "$temp_file"
log "SUCCESS" "Process completed successfully"

# Clean up temporary files
log "INFO" "Cleaning up temporary files..."
rm -f "$temp_file" "$response_file"
log "SUCCESS" "Temporary files removed"