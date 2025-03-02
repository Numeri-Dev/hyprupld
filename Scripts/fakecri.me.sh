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
url="https://fakecrime-uploader.fakecri.me"
temp_file="/tmp/screenshot.png"
response_file="/tmp/upload.json"
settings_file="$HOME/.config/fakecri.me/settings.json"
pckmgrs_file="$HOME/.config/hyprupld/pckmgrs.json"

# Color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

get_saved_value() {
    [[ -f "$settings_file" ]] && jq -r ".$1" "$settings_file" || echo ""
}

save_value() {
    log_step "Saving $1 to settings file"
    mkdir -p "$(dirname "$settings_file")"
    [[ -f "$settings_file" ]] && jq ".$1=\"$2\"" "$settings_file" > "$settings_file.tmp" && mv "$settings_file.tmp" "$settings_file" || echo "{\"$1\": \"$2\"}" > "$settings_file"
    log_success "Value saved successfully"
}

detect_package_managers() {
    log_step "Detecting package managers"
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
            log_info "Found package manager: $manager (${manager_names[$manager]})"
        fi
    done

    # Save detected managers to JSON
    printf '%s\n' "${detected_managers[@]}" | jq -R . | jq -s . > "$pckmgrs_file"
    log_success "Detected package managers: ${detected_managers[*]}"
    echo "${detected_managers[@]}"
}

get_package_managers() {
    if [[ -f "$pckmgrs_file" ]]; then
        log_info "Using cached package manager information"
        jq -r '.[]' "$pckmgrs_file"
    else
        log_info "No cached package manager information found, detecting now"
        detect_package_managers
    fi
}

install_dependencies() {
    required_packages=("$@")
    log_step "Checking for required dependencies: ${required_packages[*]}"
    package_managers=($(get_package_managers))
    missing_packages=()

    # Check for missing dependencies
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &>/dev/null; then
            missing_packages+=("$package")
            log_warning "Missing package: $package"
        else
            log_info "Found package: $package"
        fi
    done

    if [[ ${#missing_packages[@]} -eq 0 ]]; then
        log_success "All dependencies are installed"
        return
    fi

    log_step "Installing missing packages: ${missing_packages[*]}"
    for manager in "${package_managers[@]}"; do
        case "$manager" in
            "arch") 
                log_info "Using pacman to install packages"
                sudo pacman -S --noconfirm "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "debian") 
                log_info "Using apt-get to install packages"
                sudo apt-get install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "fedora") 
                log_info "Using dnf to install packages"
                sudo dnf install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "nixos") 
                log_info "Using nix-env to install packages"
                sudo nix-env -iA nixpkgs."${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "gentoo") 
                log_info "Using emerge to install packages"
                sudo emerge --ask "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "opensuse") 
                log_info "Using zypper to install packages"
                sudo zypper install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "void") 
                log_info "Using xbps-install to install packages"
                sudo xbps-install -y "${missing_packages[@]}" && log_success "Packages installed successfully" && return ;;
            "arch_community")
                if command -v yay &>/dev/null; then
                    log_info "Using yay to install packages"
                    yay -S --noconfirm "${missing_packages[@]}" && log_success "Packages installed successfully" && return
                elif command -v paru &>/dev/null; then
                    log_info "Using paru to install packages"
                    paru -S --noconfirm "${missing_packages[@]}" && log_success "Packages installed successfully" && return
                fi
                ;;
        esac
    done

    log_error "Could not install dependencies. Install the following manually: ${missing_packages[*]}"
    exit 1
}

# Ensure Zenity, jq, and xclip are installed
log_step "Checking for required tools"
install_dependencies "zenity" "jq" "xclip"

# Detect distro and desktop environment
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
desktop_env=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
log_info "Detected distro: $distro"
log_info "Detected desktop environment: $desktop_env"

# Get auth key
log_step "Retrieving authentication key"
auth=$(get_saved_value "auth")
if [[ -z "$auth" ]]; then
    log_info "No saved auth key found, prompting user"
    auth=$(zenity --entry --title="Authentication Key" --text="Enter your auth key:" --width=500) || exit 1
    save_value "auth" "$auth"
else
    log_info "Using saved auth key"
fi

# Handle screenshots based on the desktop environment
log_step "Taking screenshot based on desktop environment"
case "$desktop_env" in
    *"sway"*|*"hyprland"*|*"i3"*)
        log_info "Using grimblast for $desktop_env"
        install_dependencies "grimblast"
        log_info "Running grimblast save area $temp_file"
        grimblast save area "$temp_file"
        ;;
    *"kde"*)
        install_dependencies "flameshot" "spectacle"
        tool=$(get_saved_value "kde_tool")
        if [[ -z "$tool" ]]; then
            log_info "No preferred KDE screenshot tool found, prompting user"
            tool=$(zenity --list --radiolist --title="KDE Screenshot Tool" --text="Choose your preferred screenshot tool:" --column="" --column="Tool" TRUE Flameshot FALSE Spectacle --width=500 --height=316) || exit 1
            save_value "kde_tool" "$tool"
        fi
        if [[ "$tool" == "Flameshot" ]]; then
            log_info "Using Flameshot for KDE"
            flameshot gui -p "$temp_file"
        else
            log_info "Using Spectacle for KDE"
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
        log_error "Unsupported desktop environment: $desktop_env"
        notify-send "Error" "Unsupported desktop environment: $desktop_env" -a "Screenshot Script"
        exit 1
        ;;
esac

# Verify screenshot
if [[ ! -f "$temp_file" ]]; then
    log_error "Failed to take screenshot"
    notify-send "Error" "Failed to take screenshot." -a "Screenshot Script"
    exit 1
fi
log_success "Screenshot saved to $temp_file"

# Upload screenshot
log_step "Uploading screenshot to $url"
log_info "Executing curl command with auth token"
image_url=$(curl -X POST -F "file=@"$temp_file -H "Authorization: "$auth -v "$url" 2>/dev/null)
echo $image_url > /tmp/upload.json
response_file="/tmp/upload.json"

if [[ -z "$image_url" || "$image_url" == "null" ]]; then
    log_error "Failed to upload screenshot"
    notify-send "Error" "Failed to upload screenshot." -a "Screenshot Script"
    rm -f "$temp_file"
    exit 1
fi
log_success "Screenshot uploaded successfully"

# Copy URL to clipboard
log_step "Copying URL to clipboard"
echo -n "$image_url" | xclip -selection clipboard
log_success "URL copied to clipboard: $image_url"

# Final alert
notify-send "Image URL copied to clipboard" "$image_url" -a "Screenshot Script" -i "$temp_file"

# Clean up temporary files
log_step "Cleaning up temporary files"
rm -f "$temp_file" "$response_file"
log_success "Temporary files removed"
log_success "Script completed successfully"
